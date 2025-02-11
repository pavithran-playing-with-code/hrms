using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class leave_emp_dashboard : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(leave_emp_dashboard));

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

        [WebMethod]
        public static string populate_leave_details(string from)
        {
            var data = new Dictionary<string, object>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string get_leave_info_query = "";

                    if (from == "leave_emp_dashboard")
                    {
                        get_leave_info_query = @"SELECT COUNT(*) AS total_leave_requests,
                                                        SUM(CASE WHEN l.leave_status = 'Approved' THEN 1 ELSE 0 END) AS approved_leave_requests,
                                                        SUM(CASE WHEN l.leave_status = 'Rejected' THEN 1 ELSE 0 END) AS rejected_leave_requests
                                                FROM hrms.leave_requests l
                                                WHERE  canceled_by IS NULL AND l.emp_id = @emp_id AND YEAR(l.start_date) = YEAR(CURDATE()) ";
                    }
                    else if (from == "leave_admin_dashboard")
                    {
                        get_leave_info_query = @"SELECT SUM(CASE WHEN l.leave_status IS NULL AND YEAR(l.start_date) = YEAR(CURDATE()) THEN 1 ELSE 0 END) AS total_leave_requests, 
                                                        SUM(CASE WHEN l.leave_status = 'Approved' AND YEAR(l.start_date) = YEAR(CURDATE()) 
                                                            AND MONTH(l.start_date) = MONTH(CURDATE()) THEN 1 ELSE 0 END) AS approved_leave_requests, 
                                                        SUM(CASE WHEN l.leave_status = 'Rejected' AND YEAR(l.start_date) = YEAR(CURDATE()) 
                                                            AND MONTH(l.start_date) = MONTH(CURDATE()) THEN 1 ELSE 0 END) AS rejected_leave_requests 
                                                FROM hrms.leave_requests l
                                                WHERE l.canceled_by IS NULL ";
                    }

                    using (var cmd = new MySqlCommand(get_leave_info_query, conn))
                    {
                        if (from == "leave_emp_dashboard")
                        {
                            cmd.Parameters.AddWithValue("@emp_id", emp_id);
                        }

                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                data["total_leave_request"] = reader["total_leave_requests"] != DBNull.Value ? Convert.ToInt32(reader["total_leave_requests"]) : 0;
                                data["approved_leave_request"] = reader["approved_leave_requests"] != DBNull.Value ? Convert.ToInt32(reader["approved_leave_requests"]) : 0;
                                data["rejected_leave_request"] = reader["rejected_leave_requests"] != DBNull.Value ? Convert.ToInt32(reader["rejected_leave_requests"]) : 0;
                            }
                            else
                            {
                                data["total_leave_request"] = 0;
                                data["approved_leave_request"] = 0;
                                data["rejected_leave_request"] = 0;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_leave_details: " + ex.ToString());
                data["error"] = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        public class leave
        {
            public string leave_id { get; set; }
            public string emp_name { get; set; }
            public string department_name { get; set; }
            public string job_position_name { get; set; }
            public string profile_letters { get; set; }
            public string profile_img { get; set; }
            public string profile_color { get; set; }
            public string leave_type { get; set; }
            public string start_date { get; set; }
            public string end_date { get; set; }
            public string start_date_breakdown { get; set; }
            public string end_date_breakdown { get; set; }
            public string requested_days { get; set; }
            public string leave_description { get; set; }
            public string attachment { get; set; }
            public string leave_status { get; set; }
            public string created_by { get; set; }
            public string created_time { get; set; }
        }

        [WebMethod]
        public static string populate_leaves_based_months(string from, int selectedMonth = 0, int selectedYear = 0)
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

                    if (selectedMonth == 0 || selectedYear == 0)
                    {
                        selectedMonth = DateTime.Now.Month;
                        selectedYear = DateTime.Now.Year;
                    }

                    string leave_Query = @"SELECT l.leave_requests_id AS leave_id, l.emp_id, d.department_id, j.job_position_id, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, 
                                            CONCAT(LEFT(e.first_name, 1), LEFT(e.last_name, 1)) AS profile_letters, p.profile_img, p.profile_color, d.department_name, j.job_position_name, 
                                            lt.leave_type, l.start_date, l.start_date_breakdown, l.end_date, l.end_date_breakdown, l.leave_description, l.attachment, l.leave_status, l.created_by, l.created_time 
                                            FROM hrms.leave_requests l 
                                            LEFT JOIN hrms.employee e ON (e.emp_id = l.emp_id)
                                            LEFT JOIN hrms.department d ON (d.department_id = e.emp_dept_id)
                                            LEFT JOIN hrms.job_position j ON (j.job_position_id = e.emp_job_position_id)
                                            LEFT JOIN profile_picture p ON (p.emp_id = e.emp_id)
                                            LEFT JOIN hrms.leave_type lt ON (lt.leave_type_id = l.leave_type_id)
                                            WHERE canceled_by IS NULL ";

                    if (from == "leave_emp_dashboard")
                    {
                        leave_Query += @" AND l.emp_id = @emp_id 
                      AND ((YEAR(l.start_date) = @selectedYear AND MONTH(l.start_date) = @selectedMonth) 
                      OR (YEAR(l.end_date) = @selectedYear AND MONTH(l.end_date) = @selectedMonth) 
                      OR (l.start_date < STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d') 
                          AND l.end_date >= LAST_DAY(STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d')))) ";
                    }
                    else if (from == "leave_admin_dashboard")
                    {
                        leave_Query += @" AND ((YEAR(l.start_date) = @selectedYear AND MONTH(l.start_date) = @selectedMonth) 
                      OR (YEAR(l.end_date) = @selectedYear AND MONTH(l.end_date) = @selectedMonth) 
                      OR (l.start_date < STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d') 
                          AND l.end_date >= LAST_DAY(STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d')))) ";
                    }
                    else if (from == "leave_admin_dashboard_on_leave")
                    {
                        leave_Query += " AND CURDATE() BETWEEN l.start_date AND l.end_date ";
                    }
                    else if (from == "leave_emp_dashboard_total_leave_request")
                    {
                        leave_Query += " AND l.emp_id = @emp_id AND YEAR(l.start_date) = @selectedYear ";
                    }
                    else if (from == "leave_admin_dashboard_total_leave_request")
                    {
                        leave_Query += " AND YEAR(l.start_date) = @selectedYear ";
                    }


                    using (var cmd = new MySqlCommand(leave_Query, conn))
                    {
                        if (from == "leave_emp_dashboard")
                        {
                            cmd.Parameters.AddWithValue("@emp_id", emp_id);
                            cmd.Parameters.AddWithValue("@selectedMonth", selectedMonth);
                            cmd.Parameters.AddWithValue("@selectedYear", selectedYear);
                        }
                        else if (from == "leave_admin_dashboard")
                        {
                            cmd.Parameters.AddWithValue("@selectedMonth", selectedMonth);
                            cmd.Parameters.AddWithValue("@selectedYear", selectedYear);
                        }
                        else if (from == "leave_emp_dashboard_total_leave_request")
                        {
                            cmd.Parameters.AddWithValue("@emp_id", emp_id);
                            cmd.Parameters.AddWithValue("@selectedYear", selectedYear);
                        }
                        else if (from == "leave_admin_dashboard_total_leave_request")
                        {
                            cmd.Parameters.AddWithValue("@selectedYear", selectedYear);
                        }


                        var da = new MySqlDataAdapter(cmd);
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
                                totalDays += 1;
                            else if (startBreakdown == "First Half" || startBreakdown == "Second Half")
                                totalDays += 0.5;

                            if (startDate.ToString("yyyy-MM-dd") == endDate.ToString("yyyy-MM-dd"))
                            {
                                if (startBreakdown == "First Half" && endBreakdown == "Second Half")
                                    totalDays = 1;
                                else if (startBreakdown == "Second Half" && endBreakdown == "Second Half")
                                    totalDays = 0.5;
                            }
                            else
                            {
                                for (DateTime date = startDate.AddDays(1); date < endDate; date = date.AddDays(1))
                                {
                                    if (date.DayOfWeek != DayOfWeek.Saturday && date.DayOfWeek != DayOfWeek.Sunday)
                                        totalDays++;
                                }

                                if (endBreakdown == "Full")
                                    totalDays += 1;
                                else if (endBreakdown == "First Half" || endBreakdown == "Second Half")
                                    totalDays += 0.5;
                            }

                            List.Add(new leave
                            {
                                leave_id = row["leave_id"].ToString(),
                                emp_name = row["emp_name"].ToString(),
                                department_name = row["department_name"].ToString(),
                                job_position_name = row["job_position_name"].ToString(),
                                profile_letters = row["profile_letters"].ToString(),
                                profile_img = row["profile_img"].ToString(),
                                profile_color = row["profile_color"].ToString(),
                                leave_type = row["leave_type"].ToString(),
                                start_date = startDate.ToString("MM-dd-yyyy"),
                                end_date = endDate.ToString("MM-dd-yyyy"),
                                start_date_breakdown = startBreakdown,
                                end_date_breakdown = endBreakdown,
                                requested_days = totalDays.ToString("0.##"),
                                leave_description = row["leave_description"].ToString(),
                                attachment = row["attachment"].ToString(),
                                leave_status = row["leave_status"].ToString(),
                                created_by = row["created_by"].ToString(),
                                created_time = row["created_time"].ToString()
                            });
                        }
                    }

                    conn.Close();
                    data = JsonConvert.SerializeObject(List);
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populateleaves: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string HolidaysThisMonths()
        {
            Dictionary<string, string> holidays = new Dictionary<string, string>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT holiday_date, holiday_name FROM hrms.holidays WHERE MONTH(holiday_date) = MONTH(CURDATE()) AND YEAR(holiday_date) = YEAR(CURDATE()) ";
                    using (var command = new MySqlCommand(query, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                DateTime holidayDate = reader.GetDateTime(0);
                                string holidayName = reader.GetString(1);
                                holidays[holidayDate.ToString("yyyy-MM-dd")] = holidayName;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in GetHolidays: " + ex.ToString());
            }

            return JsonConvert.SerializeObject(holidays);
        }
    }
}