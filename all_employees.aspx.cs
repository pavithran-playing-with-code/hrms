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
using static Google.Protobuf.Reflection.SourceCodeInfo.Types;
using Twilio.Types;

namespace hrms
{
    public partial class all_employees : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(all_employees));

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

        public class employee
        {
            public string emp_id { get; set; }
            public string first_name { get; set; }
            public string last_name { get; set; }
            public string phone_number { get; set; }
            public string email { get; set; }
            public string dob { get; set; }
            public string location { get; set; }
            public string department { get; set; }
            public string job_position { get; set; }
            public string career_level { get; set; }
            public string access_level { get; set; }
            public string is_active { get; set; }
        }

        [WebMethod]
        public static string populateemployees()
        {
            var data = "";
            var List = new List<employee>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string employee_Query = $@"SELECT e.*, d.department_name, j.job_position_name
                                                FROM hrms.employee e
                                                LEFT JOIN hrms.department d ON (d.department_id = e.emp_dept_id)
                                                LEFT JOIN hrms.job_position j ON (j.job_position_id = e.emp_job_position_id);";

                    var da = new MySqlDataAdapter(employee_Query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        List.Add(new employee
                        {
                            emp_id = row["emp_id"].ToString(),
                            first_name = row["first_name"].ToString(),
                            last_name = row["last_name"].ToString(),
                            phone_number = row["phone_number"].ToString(),
                            email = row["email"].ToString(),
                            dob = row["dob"].ToString(),
                            location = row["location"].ToString(),
                            department = row["department_name"].ToString(),
                            job_position = row["job_position_name"].ToString(),
                            career_level = row["career_level"].ToString(),
                            access_level = row["access_level"].ToString(),
                            is_active = row["is_active"].ToString()
                        });
                    }

                    conn.Close();

                    var employee_data = JsonConvert.SerializeObject(List);
                    data = employee_data;

                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_employees: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string insertEmployee(string firstName, string lastName, string phoneNumber, string email, string dob, string location, string department, string jobPosition, string careerLevel, string accessLevel)
        {
            var data = "";

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    using (var transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            var emp_id = HttpContext.Current.Session["emp_id"];

                            string insertQuery = @"INSERT INTO hrms.employee 
                                            (first_name, last_name, phone_number, email, dob, location, emp_dept_id, emp_job_position_id, career_level, access_level, is_active, created_by, created_time) 
                                          VALUES 
                                            (@firstName, @lastName, @phoneNumber, @email, @dob, @location, @department, @jobPosition, @careerLevel, @accessLevel, 'Y', @created_by, NOW());";

                            using (var cmd = new MySqlCommand(insertQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@firstName", firstName);
                                cmd.Parameters.AddWithValue("@lastName", lastName);
                                cmd.Parameters.AddWithValue("@phoneNumber", phoneNumber);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue("@dob", dob);
                                cmd.Parameters.AddWithValue("@location", location);
                                cmd.Parameters.AddWithValue("@department", department);
                                cmd.Parameters.AddWithValue("@jobPosition", jobPosition);
                                cmd.Parameters.AddWithValue("@careerLevel", careerLevel);
                                cmd.Parameters.AddWithValue("@accessLevel", accessLevel);
                                cmd.Parameters.AddWithValue("@created_by", emp_id);

                                cmd.ExecuteNonQuery();
                            }

                            transaction.Commit();
                            data = "Employee created successfully.";
                        }
                        catch (Exception)
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in insertEmployee: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;

        }

        [WebMethod]
        public static string getEmployeeById(int emp_id)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"SELECT first_name, last_name, phone_number, email, dob, location, emp_dept_id AS department,
                                    emp_job_position_id AS jobPosition, career_level, access_level
                             FROM hrms.employee 
                             WHERE emp_id = @empId";
                    using (var cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@empId", emp_id);
                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                var employee = new
                                {
                                    firstName = reader["first_name"].ToString(),
                                    lastName = reader["last_name"].ToString(),
                                    phoneNumber = reader["phone_number"].ToString(),
                                    email = reader["email"].ToString(),
                                    dob = reader["dob"].ToString(),
                                    location = reader["location"].ToString(),
                                    department = reader["department"].ToString(),
                                    jobPosition = reader["jobPosition"].ToString(),
                                    careerLevel = reader["career_level"].ToString(),
                                    accessLevel = reader["access_level"].ToString()
                                };
                                data = JsonConvert.SerializeObject(employee);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in getEmployeeById: " + ex.ToString());
                HttpContext.Current.Response.StatusCode = 500;
            }
            return data;
        }

        [WebMethod]
        public static string updateEmployee(string emp_id, string firstName, string lastName, string phoneNumber, string email, string dob, string location, string department, string jobPosition, string careerLevel, string accessLevel)
        {
            var data = "";

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    using (var transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            string updateQuery = @"UPDATE hrms.employee 
                                           SET first_name = @firstName, last_name = @lastName, phone_number = @phoneNumber, 
                                               email = @email, dob = @dob, location = @location, emp_dept_id = @department, 
                                               emp_job_position_id = @jobPosition, career_level = @careerLevel, access_level = @accessLevel, 
                                               edited_by = @edited_by, edited_time = NOW()
                                           WHERE emp_id = @emp_id";

                            using (var cmd = new MySqlCommand(updateQuery, conn, transaction))
                            {
                                var employee_id = HttpContext.Current.Session["emp_id"];

                                cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                cmd.Parameters.AddWithValue("@firstName", firstName);
                                cmd.Parameters.AddWithValue("@lastName", lastName);
                                cmd.Parameters.AddWithValue("@phoneNumber", phoneNumber);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue("@dob", dob);
                                cmd.Parameters.AddWithValue("@location", location);
                                cmd.Parameters.AddWithValue("@department", department);
                                cmd.Parameters.AddWithValue("@jobPosition", jobPosition);
                                cmd.Parameters.AddWithValue("@careerLevel", careerLevel);
                                cmd.Parameters.AddWithValue("@accessLevel", accessLevel);
                                cmd.Parameters.AddWithValue("@edited_by", employee_id);

                                cmd.ExecuteNonQuery();
                            }

                            transaction.Commit();
                            data = "Employee updated successfully.";
                        }
                        catch (Exception)
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in updateEmployee: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;

        }

        [WebMethod]
        public static string deactive_delete_emp(string emp_id, string action, string is_active)
        {
            var data = "";

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    using (var transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            var employee_id = HttpContext.Current.Session["emp_id"];

                            if (action == "delete")
                            {
                                string updateCommentsQuery = "DELETE FROM hrms.employee WHERE emp_id = @emp_id;";
                                using (var cmd = new MySqlCommand(updateCommentsQuery, conn, transaction))
                                {
                                    cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                    cmd.ExecuteNonQuery();
                                }
                                data = "Employee deleted successfully.";
                            }
                            else if (action == "deactivate")
                            {
                                string updateAnnouncementQuery = "UPDATE hrms.employee SET is_active = @is_active, deactive_by = @deactive_by, deactive_time = NOW() WHERE emp_id = @emp_id;";
                                using (var cmd = new MySqlCommand(updateAnnouncementQuery, conn, transaction))
                                {
                                    cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                    cmd.Parameters.AddWithValue("@is_active", is_active);
                                    cmd.Parameters.AddWithValue("@deactive_by", employee_id);
                                    cmd.ExecuteNonQuery();
                                }
                                data = "Employee deactivate successfully.";
                            }
                            else if (action == "activate")
                            {
                                string updateAnnouncementQuery = "UPDATE hrms.employee SET is_active = @is_active, deactive_by = @deactive_by, deactive_time = NOW() WHERE emp_id = @emp_id;";
                                using (var cmd = new MySqlCommand(updateAnnouncementQuery, conn, transaction))
                                {
                                    cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                    cmd.Parameters.AddWithValue("@is_active", is_active);
                                    cmd.Parameters.AddWithValue("@deactive_by", employee_id);
                                    cmd.ExecuteNonQuery();
                                }
                                data = "Employee activate successfully.";
                            }

                            transaction.Commit();
                        }
                        catch (Exception)
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                log.Error("Error in deactive_delete_emp: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;

        }

    }
}