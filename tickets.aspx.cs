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
using static hrms.dashboard;
using static hrms.tickets;

namespace hrms
{
    public partial class tickets : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(tickets));

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class ticket_types
        {
            public string ticket_type_id { get; set; }
            public string ticket_type { get; set; }
            public string assignee { get; set; }
            public string emp_name { get; set; }
            public string departments { get; set; }
            public string department_name { get; set; }
            public string job_positions { get; set; }
            public string job_position_name { get; set; }
        }

        [WebMethod]
        public static string populate_ticket_type()
        {
            var data = "";
            var List = new List<ticket_types>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new MySqlCommand("SELECT ticket_type_id, ticket_type, assignee FROM hrms.ticket_types WHERE deleted_time IS NULL", conn))
                    {
                        var da = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            var emp_ids = row["assignee"].ToString().Split(',');
                            var emp_name = new List<string>();
                            var departments = new List<string>();
                            var department_name = new List<string>();
                            var jobPositions = new List<string>();
                            var job_position_name = new List<string>();

                            foreach (var emp_id in emp_ids)
                            {
                                string emp_details_query = @"SELECT CONCAT(e.first_name, "" "", e.last_name) AS emp_name, e.emp_dept_id, e.emp_job_position_id, d.department_name, j.job_position_name 
                                                            FROM hrms.employee e
                                                            LEFT JOIN hrms.department d ON (d.department_id = e.emp_dept_id)
                                                            LEFT JOIN hrms.job_position j ON (j.job_position_id = e.emp_job_position_id)
                                                            WHERE e.emp_id = @emp_id;";
                                using (var empCmd = new MySqlCommand(emp_details_query, conn))
                                {
                                    empCmd.Parameters.AddWithValue("@emp_id", emp_id);
                                    using (var reader = empCmd.ExecuteReader())
                                    {
                                        if (reader.Read())
                                        {
                                            emp_name.Add(reader["emp_name"].ToString());
                                            departments.Add(reader["emp_dept_id"].ToString());
                                            department_name.Add(reader["department_name"].ToString());
                                            jobPositions.Add(reader["emp_job_position_id"].ToString());
                                            job_position_name.Add(reader["job_position_name"].ToString());
                                        }
                                    }
                                }
                            }

                            List.Add(new ticket_types
                            {
                                ticket_type_id = row["ticket_type_id"].ToString(),
                                ticket_type = row["ticket_type"].ToString(),
                                assignee = row["assignee"].ToString(),
                                emp_name = string.Join(",", emp_name),
                                departments = string.Join(",", departments),
                                department_name = string.Join(",", department_name),
                                job_positions = string.Join(",", jobPositions),
                                job_position_name = string.Join(",", job_position_name)
                            });
                        }
                        conn.Close();

                        var tickets_data = JsonConvert.SerializeObject(List);
                        data = tickets_data;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populateticket_type: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string create_ticket_type(string newTicketType, string[] assignee)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    var assigneeList = new List<string>(assignee);

                    if (assignee.Contains("All"))
                    {
                        string employeeQuery = "SELECT emp_id FROM hrms.employee WHERE is_active = 'Y'";
                        using (MySqlCommand employeecmd = new MySqlCommand(employeeQuery, conn))
                        using (MySqlDataReader reader = employeecmd.ExecuteReader())
                        {
                            assigneeList.Clear();
                            while (reader.Read())
                            {
                                assigneeList.Add(reader["emp_id"].ToString());
                            }
                        }
                    }
                    string finalAssigneeList = string.Join(",", assigneeList);

                    using (MySqlCommand cmd = new MySqlCommand("INSERT INTO hrms.ticket_types (ticket_type, assignee, created_by, created_time) VALUES (@ticket_type, @assignee, @created_by, NOW())", conn))
                    {
                        cmd.Parameters.AddWithValue("@ticket_type", newTicketType);
                        cmd.Parameters.AddWithValue("@assignee", finalAssigneeList);
                        cmd.Parameters.AddWithValue("@created_by", emp_id);
                        cmd.ExecuteNonQuery();
                    }
                    conn.Close();
                }
                return "Ticket type Added Successfully";
            }
            catch (Exception ex)
            {
                log.Error("Error in create_ticket_type: " + ex.ToString());
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string edit_ticket_type(int ticket_type_id, string newTicketType, string[] assignee)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    var assigneeList = new List<string>(assignee);

                    if (assignee.Contains("All"))
                    {
                        string employeeQuery = "SELECT emp_id FROM hrms.employee WHERE is_active = 'Y'";
                        using (MySqlCommand employeecmd = new MySqlCommand(employeeQuery, conn))
                        using (MySqlDataReader reader = employeecmd.ExecuteReader())
                        {
                            assigneeList.Clear();
                            while (reader.Read())
                            {
                                assigneeList.Add(reader["emp_id"].ToString());
                            }
                        }
                    }
                    string finalAssigneeList = string.Join(",", assigneeList);

                    using (MySqlCommand cmd = new MySqlCommand("UPDATE hrms.ticket_types SET ticket_type = @ticket_type, assignee = @assignee, edited_by = @edited_by, edited_time = NOW() WHERE ticket_type_id = @ticket_type_id", conn))
                    {
                        cmd.Parameters.AddWithValue("@ticket_type_id", ticket_type_id);
                        cmd.Parameters.AddWithValue("@ticket_type", newTicketType);
                        cmd.Parameters.AddWithValue("@assignee", finalAssigneeList);
                        cmd.Parameters.AddWithValue("@edited_by", emp_id);
                        cmd.ExecuteNonQuery();
                    }
                    conn.Close();
                }
                return "Ticket type Updated Successfully";
            }
            catch (Exception ex)
            {
                log.Error("Error in edit_ticket_type: " + ex.ToString());
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string delete_ticket_type(int ticket_type_id)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE hrms.ticket_types SET deleted_by = @deleted_by, deleted_time = NOW() WHERE ticket_type_id = @ticket_type_id", conn))
                    {
                        cmd.Parameters.AddWithValue("@ticket_type_id", ticket_type_id);
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
                log.Error("Error in delete_ticket_type: " + ex.ToString());
                return "Error: " + ex.Message;
            }
        }
    }
}