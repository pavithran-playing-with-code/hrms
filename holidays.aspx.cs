using log4net;
using Microsoft.Ajax.Utilities;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class holidays : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(holidays));
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
        public static string GetHolidays(int month, int year)
        {
            Dictionary<string, string> holidays = new Dictionary<string, string>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT holiday_date, holiday_name FROM holidays WHERE MONTH(holiday_date) = @month AND YEAR(holiday_date) = @year";
                    using (var command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@month", month);
                        command.Parameters.AddWithValue("@year", year);
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


        [WebMethod]
        public static void SaveHoliday(string date, string data, bool isEdit)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                DateTime holidayDate = DateTime.Parse(date);
                var emp_id = HttpContext.Current.Session["emp_id"];

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    MySqlCommand command;
                    if (isEdit)
                    {
                        command = new MySqlCommand("UPDATE holidays SET holiday_name = @data, edited_by = @emp_id, edited_time = NOW() WHERE holiday_date = @date", conn);
                    }
                    else
                    {
                        command = new MySqlCommand("INSERT INTO holidays (holiday_date, holiday_name, created_by, created_time) VALUES (@date, @data, @emp_id, NOW())", conn);
                    }

                    command.Parameters.AddWithValue("@date", holidayDate);
                    command.Parameters.AddWithValue("@data", data);
                    command.Parameters.AddWithValue("@emp_id", emp_id);

                    command.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in SaveHoliday: " + ex.ToString());
            }
        }
    }
}