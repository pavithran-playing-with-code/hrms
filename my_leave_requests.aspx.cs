using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class my_leave_requests : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(my_leave_requests));

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class leave
        {
            public string leave_id { get; set; }
            public string emp_name { get; set; }
            public string leave_type { get; set; }
            public string start_date { get; set; }
            public string end_date { get; set; }
            public string start_date_breakdown { get; set; }
            public string end_date_breakdown { get; set; }
            public string requested_days { get; set; }
            public string leave_description { get; set; }
            public string attachment { get; set; }
            public string leave_status { get; set; }
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
                    string leave_Query = $@"SELECT l.leave_requests_id AS leave_id, l.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, 
lt.leave_type, l.start_date, l.start_date_breakdown, l.end_date, l.end_date_breakdown, l.leave_description, l.attachment, l.leave_status 
FROM hrms.leave_requests l 
LEFT JOIN hrms.employee e ON (e.emp_id = l.emp_id)
LEFT JOIN hrms.leave_type lt ON (lt.leave_type_id = l.leave_type_id)
WHERE l.emp_id = '{emp_id}';";
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


                        List.Add(new leave
                        {
                            leave_id = row["leave_id"].ToString(),
                            emp_name = row["emp_name"].ToString(),
                            leave_type = row["leave_type"].ToString(),
                            start_date = startDate.ToString("MM-dd-yyyy"),
                            end_date = endDate.ToString("MM-dd-yyyy"),
                            start_date_breakdown = startBreakdown.ToString(),
                            end_date_breakdown = endBreakdown.ToString(),
                            requested_days = totalDays.ToString("0.##"),
                            leave_description = row["leave_description"].ToString(),
                            attachment = row["attachment"].ToString(),
                            leave_status = row["leave_status"].ToString()
                        });
                    }

                    conn.Close();

                    var leave_data = JsonConvert.SerializeObject(List);
                    data = leave_data;
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_leaves: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }


        [WebMethod]
        public static string save_Leave(string leaveType, string startDate, string startDayBreakdown, string endDate, string endDayBreakdown, string description, string attachment)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];

                    string checkOverlapQuery = @"
                SELECT COUNT(*) 
                FROM hrms.leave_requests 
                WHERE emp_id = @emp_id AND leave_status != 'Canceled'  
                  AND (
                      (start_date <= @end_date AND end_date >= @start_date) 
                      OR 
                      (start_date = @start_date AND start_date_breakdown = @start_date_breakdown)
                  );";

                    using (var checkCmd = new MySqlCommand(checkOverlapQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@emp_id", emp_id);
                        checkCmd.Parameters.AddWithValue("@start_date", startDate);
                        checkCmd.Parameters.AddWithValue("@end_date", endDate);
                        checkCmd.Parameters.AddWithValue("@start_date_breakdown", startDayBreakdown);

                        int overlapCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                        if (overlapCount > 0)
                        {
                            return JsonConvert.SerializeObject("duplicate");
                        }
                    }

                    string saveLeaveQuery = @"
                INSERT INTO hrms.leave_requests 
                (emp_id, leave_type_id, start_date, start_date_breakdown, end_date, end_date_breakdown, leave_description, attachment, created_by, created_time) 
                VALUES 
                (@emp_id, @leave_type_id, @start_date, @start_date_breakdown, @end_date, @end_date_breakdown, @leave_description, @attachment, @created_by, @created_time);";

                    using (var cmd = new MySqlCommand(saveLeaveQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@emp_id", emp_id);
                        cmd.Parameters.AddWithValue("@leave_type_id", leaveType);
                        cmd.Parameters.AddWithValue("@start_date", startDate);
                        cmd.Parameters.AddWithValue("@start_date_breakdown", startDayBreakdown);
                        cmd.Parameters.AddWithValue("@end_date", endDate);
                        cmd.Parameters.AddWithValue("@end_date_breakdown", endDayBreakdown);
                        cmd.Parameters.AddWithValue("@leave_description", description);
                        cmd.Parameters.AddWithValue("@attachment", attachment);
                        cmd.Parameters.AddWithValue("@created_by", emp_id);
                        cmd.Parameters.AddWithValue("@created_time", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                        int rowsAffected = cmd.ExecuteNonQuery();
                        data = rowsAffected > 0 ? "success" : "failure";
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in save_Leave: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string cancelleave(string leave_requests_id)
        {
            var data = "";

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                string filePath = "";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    using (var transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            string getFilePathQuery = "SELECT attachment FROM hrms.leave_requests WHERE leave_requests_id = @leave_requests_id;";
                            using (var cmd = new MySqlCommand(getFilePathQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@leave_requests_id", leave_requests_id);
                                using (var reader = cmd.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        filePath = reader["attachment"].ToString();
                                    }
                                }
                            }

                            var emp_id = HttpContext.Current.Session["emp_id"];

                            string updateQuery = "UPDATE hrms.leave_requests SET leave_status = 'Canceled', canceled_by = @emp_id, canceled_time = NOW() WHERE leave_requests_id = @leave_requests_id;";
                            using (var cmd = new MySqlCommand(updateQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                cmd.Parameters.AddWithValue("@leave_requests_id", leave_requests_id);
                                cmd.ExecuteNonQuery();
                            }

                            transaction.Commit();
                            data = "success";
                        }
                        catch (Exception)
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }

                if (data == "success" && !string.IsNullOrEmpty(filePath) && File.Exists(HttpContext.Current.Server.MapPath(filePath)))
                {
                    File.Delete(HttpContext.Current.Server.MapPath(filePath));
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in deleteannouncement: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string GetLeaveBalanceandLeaveHistory()
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                var leaveBalanceList = new List<object>();
                var leaveHistoryList = new List<object>();

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string leaveRequestsQuery = $@"SELECT l.leave_requests_id AS leave_id, l.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, 
                                            lt.leave_type, l.start_date, l.start_date_breakdown, l.end_date, l.end_date_breakdown, 
                                            l.leave_description, l.leave_status 
                                            FROM hrms.leave_requests l 
                                            LEFT JOIN hrms.employee e ON (e.emp_id = l.emp_id)
                                            LEFT JOIN hrms.leave_type lt ON (lt.leave_type_id = l.leave_type_id)
                                            WHERE e.emp_id = '{emp_id}';";

                    DataTable leaveRequests = new DataTable();
                    using (var leaveAdapter = new MySqlDataAdapter(leaveRequestsQuery, conn))
                    {
                        leaveAdapter.Fill(leaveRequests);
                    }

                    string leaveTypeQuery = "SELECT leave_type, max_leave FROM hrms.leave_type WHERE deleted_by IS NULL;";
                    DataTable leaveTypes = new DataTable();
                    using (var leaveTypeAdapter = new MySqlDataAdapter(leaveTypeQuery, conn))
                    {
                        leaveTypeAdapter.Fill(leaveTypes);
                    }

                    DateTime currentDate = DateTime.Now;

                    foreach (DataRow leaveTypeRow in leaveTypes.Rows)
                    {
                        string leaveType = leaveTypeRow["leave_type"].ToString();
                        int maxLeave = Convert.ToInt32(leaveTypeRow["max_leave"]);

                        var leaveCount = leaveRequests.AsEnumerable()
                            .Where(r => r["leave_type"].ToString() == leaveType &&
                                        Convert.ToDateTime(r["end_date"]) < currentDate &&
                                        r["leave_status"].ToString() == "Approved")
                            .Count();

                        leaveBalanceList.Add(new
                        {
                            LeaveType = leaveType,
                            MaxLeave = maxLeave,
                            BalanceLeave = maxLeave - leaveCount
                        });
                    }

                    foreach (DataRow leaveRequestRow in leaveRequests.Rows)
                    {
                        DateTime endDate = Convert.ToDateTime(leaveRequestRow["end_date"]);

                        if (endDate < currentDate && leaveRequestRow["leave_status"].ToString() == "Approved")
                        {
                            leaveHistoryList.Add(new
                            {
                                LeaveID = leaveRequestRow["leave_id"].ToString(),
                                EmpName = leaveRequestRow["emp_name"].ToString(),
                                StartDate = Convert.ToDateTime(leaveRequestRow["start_date"]).ToString("MM-dd-yyyy"),
                                EndDate = endDate.ToString("MM-dd-yyyy"),
                                LeaveType = leaveRequestRow["leave_type"].ToString(),
                                Reason = leaveRequestRow["leave_description"].ToString()
                            });
                        }
                    }

                    conn.Close();
                }

                return JsonConvert.SerializeObject(new
                {
                    LeaveBalance = leaveBalanceList,
                    LeaveHistory = leaveHistoryList
                });
            }
            catch (Exception ex)
            {
                log.Error("Error in GetLeaveData: " + ex.ToString());
                return JsonConvert.SerializeObject(new { ExceptionMessage = ex.Message });
            }
        }

    }
}