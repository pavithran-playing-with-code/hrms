using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class leave_admin_dashboard : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(leave_admin_dashboard));

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
        public static string populate_leaves_details_based_months(string from, int selectedMonth = 0, int selectedYear = 0)
        {
            var response = new { departmentLeaves = new List<object>(), leaveTypeCounts = new List<object>() };

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    if (selectedMonth == 0 || selectedYear == 0)
                    {
                        selectedMonth = DateTime.Now.Month;
                        selectedYear = DateTime.Now.Year;
                    }

                    List<object> departmentLeaves = new List<object>();
                    List<object> leaveTypeCounts = new List<object>();

                    if (from == "department_leaves")
                    {
                        string departmentLeaveQuery = @"
                    SELECT d.department_id, d.department_name, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, lt.leave_type, 
                           l.start_date, l.end_date, l.leave_status, 
                           DATE_FORMAT(l.start_date, '%d %b %Y') AS start_date_breakdown,
                           DATE_FORMAT(l.end_date, '%d %b %Y') AS end_date_breakdown
                    FROM hrms.department d
                    LEFT JOIN hrms.employee e ON d.department_id = e.emp_dept_id
                    LEFT JOIN hrms.leave_requests l ON e.emp_id = l.emp_id
                    LEFT JOIN hrms.leave_type lt ON l.leave_type_id = lt.leave_type_id
                    WHERE ((YEAR(l.start_date) = @selectedYear AND MONTH(l.start_date) = @selectedMonth) 
                        OR (YEAR(l.end_date) = @selectedYear AND MONTH(l.end_date) = @selectedMonth)
                        OR (l.start_date < STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d') 
                            AND l.end_date >= LAST_DAY(STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d'))))
                    ORDER BY d.department_name, e.emp_id ASC;";

                        using (var cmd = new MySqlCommand(departmentLeaveQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@selectedMonth", selectedMonth);
                            cmd.Parameters.AddWithValue("@selectedYear", selectedYear);

                            using (var reader = cmd.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    departmentLeaves.Add(new
                                    {
                                        department_name = reader["department_name"].ToString(),
                                        emp_name = reader["emp_name"].ToString(),
                                        leave_type = reader["leave_type"].ToString(),
                                        start_date = reader["start_date"].ToString(),
                                        start_date_breakdown = reader["start_date_breakdown"].ToString(),
                                        end_date = reader["end_date"].ToString(),
                                        end_date_breakdown = reader["end_date_breakdown"].ToString(),
                                        leave_status = reader["leave_status"].ToString()
                                    });
                                }
                            }
                        }
                    }
                    else if (from == "leave_types")
                    {
                        string leaveTypeQuery = @"
        SELECT lt.leave_type, l.start_date, l.end_date, 
               l.start_date_breakdown, l.end_date_breakdown
        FROM hrms.leave_type lt
        LEFT JOIN hrms.leave_requests l ON lt.leave_type_id = l.leave_type_id
        WHERE ((YEAR(l.start_date) = @selectedYear AND MONTH(l.start_date) = @selectedMonth) 
            OR (YEAR(l.end_date) = @selectedYear AND MONTH(l.end_date) = @selectedMonth)
            OR (l.start_date < STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d') 
                AND l.end_date >= LAST_DAY(STR_TO_DATE(CONCAT(@selectedYear, '-', @selectedMonth, '-01'), '%Y-%m-%d'))))
        ORDER BY lt.leave_type ASC;";

                        using (var cmd = new MySqlCommand(leaveTypeQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@selectedMonth", selectedMonth);
                            cmd.Parameters.AddWithValue("@selectedYear", selectedYear);

                            using (var reader = cmd.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    DateTime startDate = DateTime.Parse(reader["start_date"].ToString());
                                    DateTime endDate = DateTime.Parse(reader["end_date"].ToString());

                                    string startBreakdown = reader["start_date_breakdown"].ToString();
                                    string endBreakdown = reader["end_date_breakdown"].ToString();

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

                                    leaveTypeCounts.Add(new
                                    {
                                        leave_type = reader["leave_type"].ToString(),
                                        requested_days = totalDays.ToString("0.##")
                                    });
                                }
                            }
                        }
                    }

                    response = new { departmentLeaves, leaveTypeCounts };
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_leaves_details_based_months: " + ex.ToString());
                return JsonConvert.SerializeObject(new { error = ex.Message });
            }

            return JsonConvert.SerializeObject(response);
        }

    }
}