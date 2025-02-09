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
    public partial class leave_emp_dashboard : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(leave_emp_dashboard));

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string populate_leave_details()
        {
            var data = new Dictionary<string, object>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string get_leave_info_query = @"
                SELECT 
                    COUNT(*) AS total_leave_requests,
                    SUM(CASE WHEN l.leave_status = 'Approved' THEN 1 ELSE 0 END) AS approved_leave_requests,
                    SUM(CASE WHEN l.leave_status = 'Rejected' THEN 1 ELSE 0 END) AS rejected_leave_requests
                FROM hrms.leave_requests l
                WHERE l.emp_id = @emp_id
                AND YEARWEEK(l.start_date, 1) = YEARWEEK(CURDATE(), 1);";

                    using (var cmd = new MySqlCommand(get_leave_info_query, conn))
                    {
                        cmd.Parameters.AddWithValue("@emp_id", emp_id);

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
        public static string populateleaves(int selectedMonth = 0, int selectedYear = 0)
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

                    string leave_Query = @"SELECT l.leave_requests_id AS leave_id, l.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, lt.leave_type, l.start_date, 
                                            l.start_date_breakdown, l.end_date, l.end_date_breakdown, l.leave_description, l.attachment, l.leave_status 
                                            FROM hrms.leave_requests l 
                                            LEFT JOIN hrms.employee e ON e.emp_id = l.emp_id
                                            LEFT JOIN hrms.leave_type lt ON lt.leave_type_id = l.leave_type_id
                                            WHERE l.emp_id = @emp_id 
                                            AND MONTH(l.created_time) = @selectedMonth 
                                            AND YEAR(l.created_time) = @selectedYear";

                    using (var cmd = new MySqlCommand(leave_Query, conn))
                    {
                        cmd.Parameters.AddWithValue("@emp_id", emp_id);
                        cmd.Parameters.AddWithValue("@selectedMonth", selectedMonth);
                        cmd.Parameters.AddWithValue("@selectedYear", selectedYear);

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
                                leave_type = row["leave_type"].ToString(),
                                start_date = startDate.ToString("MM-dd-yyyy"),
                                end_date = endDate.ToString("MM-dd-yyyy"),
                                start_date_breakdown = startBreakdown,
                                end_date_breakdown = endBreakdown,
                                requested_days = totalDays.ToString("0.##"),
                                leave_description = row["leave_description"].ToString(),
                                attachment = row["attachment"].ToString(),
                                leave_status = row["leave_status"].ToString(),
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
        public static string GetHolidays()
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