using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
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
        public class ticket
        {
            public string ticket_id { get; set; }
            public string emp_id { get; set; }
            public string emp_name { get; set; }
            public string title { get; set; }
            public string ticket_description { get; set; }
            public string attachments { get; set; }
            public string ticket_type_id { get; set; }
            public string ticket_type { get; set; }
            public string assignee { get; set; }
            public string priority { get; set; }
            public string ticket_status { get; set; }
        }

        [WebMethod]
        public static string populatetickets(string from)
        {
            var data = "";
            var List = new List<ticket>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string ticket_Query = "";

                    if (from == "mytickets")
                    {
                        ticket_Query = $@"SELECT t.ticket_id, e.emp_id, CONCAT(e.first_name, "" "", e.last_name) AS emp_name, t.title, t.ticket_description, t.attachments, 
                                                    t.ticket_type_id, tt.ticket_type, tt.assignee, t.priority, t.ticket_status 
                                                    FROM hrms.tickets t
                                                    LEFT JOIN hrms.ticket_types tt ON (tt.ticket_type_id = t.ticket_type_id)
                                                    LEFT JOIN hrms.employee e ON (e.emp_id = t.created_by)
                                                    WHERE  e.is_active = 'Y' AND e.emp_id = '{emp_id}' AND t.deleted_by IS NULL 
                                                    ORDER BY t.priority;";
                    }
                    else if (from == "suggestedtickets")
                    {
                        ticket_Query = $@"SELECT t.ticket_id, e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, t.title, t.ticket_description, t.attachments, 
                                                t.ticket_type_id, tt.ticket_type, tt.assignee, t.priority, t.ticket_status 
                                                FROM hrms.tickets t
                                                LEFT JOIN hrms.ticket_types tt ON tt.ticket_type_id = t.ticket_type_id
                                                LEFT JOIN hrms.employee e ON e.emp_id = t.created_by
                                                WHERE e.is_active = 'Y'  AND t.deleted_by IS NULL 
                                                AND FIND_IN_SET('{emp_id}', tt.assignee) > 0 
                                                ORDER BY t.priority;";

                    }

                    var da = new MySqlDataAdapter(ticket_Query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        var emp_ids = row["assignee"].ToString().Split(',');
                        var emp_name = new List<string>();

                        foreach (var employee in emp_ids)
                        {
                            string emp_details_query = @"SELECT CONCAT(e.first_name, "" "", e.last_name) AS emp_name FROM hrms.employee e WHERE e.emp_id = @emp_id;";
                            using (var empCmd = new MySqlCommand(emp_details_query, conn))
                            {
                                empCmd.Parameters.AddWithValue("@emp_id", employee);
                                using (var reader = empCmd.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        emp_name.Add(reader["emp_name"].ToString());
                                    }
                                }
                            }
                        }

                        List.Add(new ticket
                        {
                            ticket_id = row["ticket_id"].ToString(),
                            emp_id = row["emp_id"].ToString(),
                            emp_name = row["emp_name"].ToString(),
                            title = row["title"].ToString(),
                            ticket_description = row["ticket_description"].ToString(),
                            attachments = row["attachments"].ToString(),
                            ticket_type_id = row["ticket_type_id"].ToString(),
                            ticket_type = row["ticket_type"].ToString(),
                            priority = row["priority"].ToString(),
                            assignee = string.Join(",", emp_name),
                            ticket_status = row["ticket_status"].ToString()
                        });
                    }

                    conn.Close();

                    var ticket_data = JsonConvert.SerializeObject(List);
                    data = ticket_data;

                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populatetickets: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }


        [WebMethod]
        public static string create_edit_ticket(string action, int? ticket_id, string id_title, string id_description, string attachments, string ticket_type, string priority, string status)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];

                    if (action == "edit" && ticket_id.HasValue)
                    {
                        using (MySqlCommand cmd = new MySqlCommand("UPDATE hrms.tickets SET title = @title, ticket_description = @ticket_description, attachments = @attachments, " +
                            "ticket_type_id = @ticket_type_id, priority = @priority, ticket_status = @ticket_status, edited_by = @edited_by, edited_time = NOW() WHERE ticket_id = @ticket_id", conn))
                        {
                            cmd.Parameters.AddWithValue("@ticket_id", ticket_id);
                            cmd.Parameters.AddWithValue("@title", id_title);
                            cmd.Parameters.AddWithValue("@ticket_description", id_description);
                            cmd.Parameters.AddWithValue("@attachments", attachments);
                            cmd.Parameters.AddWithValue("@ticket_type_id", ticket_type);
                            cmd.Parameters.AddWithValue("@priority", priority);
                            cmd.Parameters.AddWithValue("@ticket_status", status);
                            cmd.Parameters.AddWithValue("@edited_by", emp_id);

                            int rowsAffected = cmd.ExecuteNonQuery();
                            conn.Close();

                            return rowsAffected > 0 ? "Ticket Updated Successfully" : "Error: Ticket not found.";
                        }
                    }
                    else
                    {
                        using (MySqlCommand cmd = new MySqlCommand("INSERT INTO hrms.tickets (title, ticket_description, attachments, ticket_type_id, priority, ticket_status, created_by, created_time) " +
                            "VALUES (@title, @ticket_description, @attachments, @ticket_type_id, @priority, @ticket_status, @created_by, NOW())", conn))
                        {
                            cmd.Parameters.AddWithValue("@title", id_title);
                            cmd.Parameters.AddWithValue("@ticket_description", id_description);
                            cmd.Parameters.AddWithValue("@attachments", attachments);
                            cmd.Parameters.AddWithValue("@ticket_type_id", ticket_type);
                            cmd.Parameters.AddWithValue("@priority", priority);
                            cmd.Parameters.AddWithValue("@ticket_status", status);
                            cmd.Parameters.AddWithValue("@created_by", emp_id);

                            cmd.ExecuteNonQuery();
                            conn.Close();
                        }
                        return "Ticket Added Successfully";
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in create_edit_ticket: " + ex.ToString());
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string updateTicketStatus(string ticketId, string status)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    if (emp_id == null)
                    {
                        return "Error: Session expired. Please log in again.";
                    }

                    using (MySqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            string updateQuery = "UPDATE hrms.tickets SET ticket_status = @ticket_status WHERE ticket_id = @ticketId";
                            using (MySqlCommand cmd = new MySqlCommand(updateQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@ticket_status", status);
                                cmd.Parameters.AddWithValue("@ticketId", ticketId);
                                cmd.ExecuteNonQuery();
                            }

                            string insertQuery = "INSERT INTO hrms.ticket_status_details (ticket_id, status_update, update_by, updated_time) " +
                                                 "VALUES (@ticket_id, @status_update, @update_by, NOW())";
                            using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@ticket_id", ticketId);
                                cmd.Parameters.AddWithValue("@status_update", status);
                                cmd.Parameters.AddWithValue("@update_by", emp_id);
                                cmd.ExecuteNonQuery();
                            }

                            transaction.Commit();
                            return "Status updated successfully";
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            log.Error("Error in updateTicketStatus: " + ex.ToString());
                            return "Error: " + ex.Message;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Database connection error in updateTicketStatus: " + ex.ToString());
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string status_history(string ticket_id)
        {
            var status_history_List = new List<object>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new MySqlCommand(@"SELECT sd.ticket_id,  CONCAT(e.first_name, "" "", e.last_name) AS emp_name, sd.status_update, sd.update_by, sd.updated_time 
                                                        FROM hrms.ticket_status_details sd
                                                        LEFT JOIN hrms.employee e ON (e.emp_id = sd.update_by)
                                                        WHERE sd.ticket_id = @ticket_id", conn))
                    {
                        cmd.Parameters.AddWithValue("@ticket_id", ticket_id);

                        var da = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            status_history_List.Add(new
                            {
                                status_update = row["status_update"].ToString(),
                                emp_name = row["emp_name"].ToString(),
                                updated_time = row["updated_time"].ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in status_history: " + ex.ToString());
                return JsonConvert.SerializeObject(new { error = ex.Message });
            }

            return JsonConvert.SerializeObject(status_history_List);
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
        public static string delete_ticket_and_type(int id, string table)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string id_col = "";

                    if (table == "tickets")
                    {
                        id_col = "ticket_id";
                    }
                    else if (table == "ticket_types")
                    {
                        id_col = "ticket_type_id";
                    }
                    else
                    {
                        return "Error: Invalid table name";
                    }

                    string query = $"UPDATE hrms.{table} SET deleted_by = @deleted_by, deleted_time = NOW() WHERE {id_col} = @id";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@deleted_by", emp_id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                if (table == "tickets")
                {
                    return "Ticket has beeen deleted successfully";
                }
                else if (table == "ticket_types")
                {
                    return "Ticket Type has been deleted successfully";
                }
                else
                {
                    return "Table missing";
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in delete_ticket_type: " + ex.ToString());
                return "Error: " + ex.Message;
            }
        }

    }
}