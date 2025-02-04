using log4net;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Twilio.Jwt.Taskrouter;

namespace hrms
{
    public partial class policies : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(policies));
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];
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

        public class Policy
        {
            public int policy_id { get; set; }
            public string policy_name { get; set; }
            public string description { get; set; }
        }

        [WebMethod]
        public static List<Policy> populatepolicies()
        {
            List<Policy> policies = new List<Policy>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new MySqlCommand("SELECT policy_id, policy_name, description FROM hrms.policies WHERE deleted_time IS NULL", conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            policies.Add(new Policy
                            {
                                policy_id = reader.GetInt32("policy_id"),
                                policy_name = reader.GetString("policy_name"),
                                description = reader.GetString("description")
                            });
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in SaveHoliday: " + ex.ToString());
            }

            return policies;
        }

        [WebMethod]
        public static string createpolicy(string policy_name, string description)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    using (MySqlCommand cmd = new MySqlCommand("INSERT INTO hrms.policies (policy_name, description, created_by, created_time) VALUES (@policy_name, @description, @created_by, NOW())", conn))
                    {
                        cmd.Parameters.AddWithValue("@policy_name", policy_name);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@created_by", emp_id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                return "Policy Added Successfully";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string editpolicy(int policy_id, string policy_name, string description)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE hrms.policies SET policy_name = @policy_name, description = @description, edited_by = @edited_by, edited_time = NOW() WHERE policy_id = @policy_id", conn))
                    {
                        cmd.Parameters.AddWithValue("@policy_id", policy_id);
                        cmd.Parameters.AddWithValue("@policy_name", policy_name);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@edited_by", emp_id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                return "Policy Updated Successfully";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string deletepolicy(int policy_id)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE hrms.policies SET deleted_by = @deleted_by, deleted_time = NOW() WHERE policy_id = @policy_id", conn))
                    {
                        cmd.Parameters.AddWithValue("@policy_id", policy_id);
                        cmd.Parameters.AddWithValue("@deleted_by", emp_id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                return "Policy Deleted Successfully";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
    }
}