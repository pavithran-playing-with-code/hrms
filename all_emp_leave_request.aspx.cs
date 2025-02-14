using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class all_emp_leave_request : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(all_emp_leave_request));
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var emp_id = HttpContext.Current.Session["emp_id"];
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string accessLevelQuery = @"SELECT access_level FROM hrms.employee WHERE emp_id = @emp_id";
                    using (var cmd = new MySqlCommand(accessLevelQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@emp_id", emp_id);
                        var accessLevel = cmd.ExecuteScalar();

                        if (accessLevel != null && accessLevel.ToString().ToLower() == "high")
                        {
                            emp_access_lvl.Value = "true";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"Error: {ex.Message}");
            }
        }
        public class leave
        {
            public string leave_id { get; set; }
            public string emp_name { get; set; }
            public string department_name { get; set; }
            public string job_position_name { get; set; }
            public string profile_img { get; set; }
            public string profile_color { get; set; }
            public string profile_letters { get; set; }
            public string leave_type { get; set; }
            public string start_date { get; set; }
            public string end_date { get; set; }
            public string start_date_breakdown { get; set; }
            public string end_date_breakdown { get; set; }
            public string requested_days { get; set; }
            public string leave_description { get; set; }
            public string attachment { get; set; }
            public string clashLeaveIds { get; set; }
            public string leave_status { get; set; }
            public string created_by { get; set; }
            public string created_time { get; set; }
        }

        [WebMethod]
        public static string populateleaves()
        {
            var data = "";
            var List = new List<leave>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string leave_Query = $@"SELECT l.leave_requests_id AS leave_id, l.emp_id, d.department_id, j.job_position_id, CONCAT(LEFT(e.first_name, 1), LEFT(e.last_name, 1)) AS profile_letters, 
                                            CONCAT(e.first_name, ' ', e.last_name) AS emp_name, d.department_name, j.job_position_name, p.profile_img, p.profile_color, 
                                            lt.leave_type, l.start_date, l.start_date_breakdown, l.end_date, l.end_date_breakdown, l.leave_description, l.attachment, 
                                            l.leave_status, la.level_1, la.level_1, la.level_1, l.created_by, l.created_time 
                                            FROM hrms.leave_requests l 
                                            LEFT JOIN hrms.employee e ON (e.emp_id = l.emp_id)
                                            LEFT JOIN hrms.department d ON (d.department_id = e.emp_dept_id)
                                            LEFT JOIN hrms.job_position j ON (j.job_position_id = e.emp_job_position_id)
                                            LEFT JOIN profile_picture p ON (p.emp_id = e.emp_id)
                                            LEFT JOIN hrms.leave_type lt ON (lt.leave_type_id = l.leave_type_id)
                                            LEFT JOIN hrms.leave_approval la ON (e.emp_dept_id = la.department_id)
                                            WHERE (l.leave_status IS NULL OR l.leave_status != 'Canceled') 
                                            AND (
                                            (DATEDIFF(CURRENT_DATE(), l.created_time) <= 3 AND la.level_1 = '{emp_id}')
                                            OR (DATEDIFF(CURRENT_DATE(), l.created_time) > 3 AND DATEDIFF(CURRENT_DATE(), l.created_time) <= 6 AND la.level_2 = '{emp_id}')
                                            OR (DATEDIFF(CURRENT_DATE(), l.created_time) > 6 AND la.level_3 = '{emp_id}')
                                            ); ";

                    var da = new MySqlDataAdapter(leave_Query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        DateTime startDate = DateTime.Parse(row["start_date"].ToString());
                        DateTime endDate = DateTime.Parse(row["end_date"].ToString());

                        string startBreakdown = row["start_date_breakdown"].ToString();
                        string endBreakdown = row["end_date_breakdown"].ToString();

                        double totalDays = 0;

                        if (startBreakdown == "Full")
                        {
                            totalDays += 1;
                        }
                        else if (startBreakdown == "First Half" || startBreakdown == "Second Half")
                        {
                            totalDays += 0.5;
                        }

                        if (startDate.ToString("yyyy-MM-dd") == endDate.ToString("yyyy-MM-dd"))
                        {
                            if (startBreakdown == "First Half" && endBreakdown == "Second Half")
                            {
                                totalDays = 1;
                            }
                            else if (startBreakdown == "Second Half" && endBreakdown == "Second Half")
                            {
                                totalDays = 0.5;
                            }
                        }
                        else
                        {
                            for (DateTime date = startDate.AddDays(1); date < endDate; date = date.AddDays(1))
                            {
                                if (date.DayOfWeek != DayOfWeek.Saturday && date.DayOfWeek != DayOfWeek.Sunday)
                                {
                                    totalDays++;
                                }
                            }

                            if (endBreakdown == "Full")
                            {
                                totalDays += 1;
                            }
                            else if (endBreakdown == "First Half" || endBreakdown == "Second Half")
                            {
                                totalDays += 0.5;
                            }
                        }

                        string clashLeaveIds = GetClashingLeaveRequests(conn, startDate, endDate, row["job_position_id"].ToString(), row["leave_id"].ToString());

                        if (clashLeaveIds.Contains("ExceptionMessage"))
                        {
                            data = "ExceptionMessage - " + clashLeaveIds;
                            return data;
                        }

                        List.Add(new leave
                        {
                            leave_id = row["leave_id"].ToString(),
                            emp_name = row["emp_name"].ToString(),
                            department_name = row["department_name"].ToString(),
                            job_position_name = row["job_position_name"].ToString(),
                            profile_img = row["profile_img"].ToString(),
                            profile_color = row["profile_color"].ToString(),
                            profile_letters = row["profile_letters"].ToString(),
                            leave_type = row["leave_type"].ToString(),
                            start_date = startDate.ToString("MM-dd-yyyy"),
                            end_date = endDate.ToString("MM-dd-yyyy"),
                            start_date_breakdown = startBreakdown.ToString(),
                            end_date_breakdown = endBreakdown.ToString(),
                            requested_days = totalDays.ToString("0.##"),
                            leave_description = row["leave_description"].ToString(),
                            attachment = row["attachment"].ToString(),
                            clashLeaveIds = clashLeaveIds,
                            leave_status = row["leave_status"].ToString(),
                            created_by = row["created_by"].ToString(),
                            created_time = row["created_time"].ToString()
                        });
                    }

                    conn.Close();

                    var leave_data = JsonConvert.SerializeObject(List);
                    data = leave_data;
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populateleaves: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        private static string GetClashingLeaveRequests(MySqlConnection conn, DateTime startDate, DateTime endDate, string jobPositionId, string currentLeaveId)
        {
            string clashLeaveIds = "";

            try
            {
                string clashQuery = $@"
            SELECT l.leave_requests_id 
            FROM hrms.leave_requests l
            LEFT JOIN hrms.employee e ON e.emp_id = l.emp_id
            WHERE e.emp_job_position_id = '{jobPositionId}' 
            AND l.leave_requests_id != '{currentLeaveId}'
            AND ((l.start_date BETWEEN '{startDate.ToString("yyyy-MM-dd")}' AND '{endDate.ToString("yyyy-MM-dd")}')
            OR (l.end_date BETWEEN '{startDate.ToString("yyyy-MM-dd")}' AND '{endDate.ToString("yyyy-MM-dd")}'))
            AND (l.leave_status IS NULL OR l.leave_status != 'Canceled')";

                MySqlCommand cmd = new MySqlCommand(clashQuery, conn);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    if (!string.IsNullOrEmpty(clashLeaveIds))
                        clashLeaveIds += ", ";
                    clashLeaveIds += reader["leave_requests_id"].ToString();
                }

                reader.Close();
            }
            catch (Exception ex)
            {
                log.Error("Error in GetClashingLeaveRequests: " + ex.ToString());
                return "ExceptionMessage - " + ex.Message;
            }

            return clashLeaveIds;
        }

        [WebMethod]
        public static string approveLeave(List<int> leaveIds)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string query = @"UPDATE hrms.leave_requests 
                             SET leave_status = 'Approved', status_updated_by = @emp_id, 
                                 status_updated_time = NOW(), status_updated_reason = null 
                             WHERE leave_requests_id IN (" + string.Join(",", leaveIds) + @") 
                             AND (leave_status IS NULL OR leave_status != 'Canceled')";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@emp_id", HttpContext.Current.Session["emp_id"]);
                    cmd.ExecuteNonQuery();

                    conn.Close();
                }

                return "Success";
            }
            catch (Exception ex)
            {
                log.Error("Error in approveLeave: " + ex.ToString());
                return "ExceptionMessage - " + ex.Message;
            }
        }


        [WebMethod]
        public static string rejectLeave(List<int> leaveIds, string rejectionReason)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string query = @"UPDATE hrms.leave_requests 
                             SET leave_status = 'Rejected', status_updated_by = @emp_id, 
                                 status_updated_time = NOW(), status_updated_reason = @reason 
                             WHERE leave_requests_id IN (" + string.Join(",", leaveIds) + @") 
                             AND (leave_status IS NULL OR leave_status != 'Canceled')";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@emp_id", HttpContext.Current.Session["emp_id"]);
                    cmd.Parameters.AddWithValue("@reason", rejectionReason);
                    cmd.ExecuteNonQuery();

                    conn.Close();
                }

                return "Success";
            }
            catch (Exception ex)
            {
                log.Error("Error in rejectLeave: " + ex.ToString());
                return "ExceptionMessage - " + ex.Message;
            }
        }


    }
}