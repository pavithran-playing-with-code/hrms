using log4net;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
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
            public int ticket_type_id { get; set; }
            public string ticket_type { get; set; }
        }

        [WebMethod]
        public static List<ticket_types> populate_ticket_type()
        {
            List<ticket_types> ticket_types = new List<ticket_types>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new MySqlCommand("SELECT ticket_type_id, ticket_type FROM hrms.ticket_types WHERE deleted_time IS NULL", conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ticket_types.Add(new ticket_types
                            {
                                ticket_type_id = reader.GetInt32("ticket_type_id"),
                                ticket_type = reader.GetString("ticket_type")
                            });
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populateticket_type: " + ex.ToString());
                return new List<ticket_types>();
            }

            return ticket_types;
        }

        [WebMethod]
        public static string create_ticket_type(string newTicketType)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    using (MySqlCommand cmd = new MySqlCommand("INSERT INTO hrms.ticket_types (ticket_type, created_by, created_time) VALUES (@ticket_type, @created_by, NOW())", conn))
                    {
                        cmd.Parameters.AddWithValue("@ticket_type", newTicketType);
                        cmd.Parameters.AddWithValue("@created_by", emp_id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
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
        public static string edit_ticket_type(int ticket_type_id, string newTicketType)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    using (MySqlCommand cmd = new MySqlCommand("UPDATE hrms.ticket_types SET ticket_type = @ticket_type, edited_by = @edited_by, edited_time = NOW() WHERE ticket_type_id = @ticket_type_id", conn))
                    {
                        cmd.Parameters.AddWithValue("@ticket_type_id", ticket_type_id);
                        cmd.Parameters.AddWithValue("@ticket_type", newTicketType);
                        cmd.Parameters.AddWithValue("@edited_by", emp_id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
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