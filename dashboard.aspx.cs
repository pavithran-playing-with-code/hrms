using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using log4net;
using System.Configuration;
using WebGrease;
using System.Web.Services;
using System.Security.Cryptography;

namespace hrms
{
    public partial class dashboard : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(dashboard));

        protected void Page_Load(object sender, EventArgs e)
        {
            var emp_id = HttpContext.Current.Session["emp_id"];
            if (emp_id == null || string.IsNullOrEmpty(emp_id.ToString()))
            {
                Response.Redirect("login.aspx");
            }
        }

        [WebMethod]
        public static string populate_emp_details()
        {
            var data = new Dictionary<string, object>();
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string empCountQuery = @"SELECT COUNT(emp_id) AS total_emp_count FROM hrms.employee WHERE is_active = 'Y';";
                    var empCountCmd = new MySqlCommand(empCountQuery, conn);
                    int totalEmpCount = Convert.ToInt32(empCountCmd.ExecuteScalar());

                    string newJoiningDateQuery = @"SELECT COUNT(new_joining_date) AS new_joining_after_today FROM hrms.new_joining WHERE new_joining_date = CURDATE();";
                    var newJoiningCmd = new MySqlCommand(newJoiningDateQuery, conn);
                    int newJoiningAfterToday = Convert.ToInt32(newJoiningCmd.ExecuteScalar());

                    string thisWeekQuery = @"SELECT COUNT(new_joining_date) AS new_joining_this_week FROM hrms.new_joining WHERE WEEK(new_joining_date) = WEEK(CURDATE()) AND YEAR(new_joining_date) = YEAR(CURDATE());";
                    var thisWeekCmd = new MySqlCommand(thisWeekQuery, conn);
                    int newJoiningThisWeek = Convert.ToInt32(thisWeekCmd.ExecuteScalar());

                    conn.Close();

                    data["totalEmpCount"] = totalEmpCount;
                    data["newJoiningAfterToday"] = newJoiningAfterToday;
                    data["newJoiningThisWeek"] = newJoiningThisWeek;
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_emp_details: " + ex.ToString());
                data["error"] = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        public class profile_details
        {
            public string emp_name { get; set; }
            public string profile_letters { get; set; }
            public string profile_img { get; set; }
            public string profile_color { get; set; }
        }

        [WebMethod]
        public static string populate_profile_details()
        {
            var data = "";
            var List = new List<profile_details>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string profile_details_Query = $@"SELECT CONCAT(e.first_name, "" "", e.last_name) AS emp_name, CONCAT(LEFT(e.first_name, 1), LEFT(e.last_name, 1)) AS profile_letters , p.profile_img, p.profile_color 
                                              FROM hrms.profile_picture p
                                              LEFT JOIN hrms.employee e ON (e.emp_id = p.emp_id) 
                                              WHERE e.emp_id = '{HttpContext.Current.Session["emp_id"]}';";
                    var da = new MySqlDataAdapter(profile_details_Query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        List.Add(new profile_details
                        {
                            emp_name = row["emp_name"].ToString(),
                            profile_letters = row["profile_letters"].ToString(),
                            profile_img = row["profile_img"].ToString(),
                            profile_color = row["profile_color"].ToString()
                        });
                    }
                    conn.Close();

                    var profile_details_data = JsonConvert.SerializeObject(List);
                    data = profile_details_data;

                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_profile_details: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        public class announncement
        {
            public string announcement_id { get; set; }
            public string profile_letters { get; set; }
            public string profile_img { get; set; }
            public string profile_color { get; set; }
            public string heading { get; set; }
        }

        [WebMethod]
        public static string populate_announncements()
        {
            var data = "";
            var List = new List<announncement>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string announncement_Query = $@"SELECT a.announcement_id, CONCAT(LEFT(e.first_name, 1), LEFT(e.last_name, 1)) AS profile_letters, 
                                                            p.profile_img, p.profile_color, a.heading
                                                            FROM hrms.announcement a
                                                            LEFT JOIN hrms.employee e ON (e.emp_id = a.emp_id) 
                                                            LEFT JOIN hrms.profile_picture p ON (p.emp_id = e.emp_id);";
                    var da = new MySqlDataAdapter(announncement_Query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        List.Add(new announncement
                        {
                            announcement_id = row["announcement_id"].ToString(),
                            profile_letters = row["profile_letters"].ToString(),
                            profile_img = row["profile_img"].ToString(),
                            profile_color = row["profile_color"].ToString(),
                            heading = row["heading"].ToString()
                        });
                    }
                    conn.Close();

                    var announncement_data = JsonConvert.SerializeObject(List);
                    data = announncement_data;

                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_announncements: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string PopulateCreateAnnouncementModal()
        {
            var data = new
            {
                Employees = new List<string>(),
                Departments = new List<object>()
            };

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string employeeQuery = @"SELECT CONCAT(first_name, ' ', last_name) AS emp_name FROM hrms.employee;";
                    var employeeCmd = new MySqlCommand(employeeQuery, conn);
                    var employeeReader = employeeCmd.ExecuteReader();
                    while (employeeReader.Read())
                    {
                        data.Employees.Add(employeeReader["emp_name"].ToString());
                    }
                    employeeReader.Close();

                    string departmentQuery = @"SELECT department_name, job_position FROM hrms.department;";
                    var departmentCmd = new MySqlCommand(departmentQuery, conn);
                    var departmentReader = departmentCmd.ExecuteReader();
                    while (departmentReader.Read())
                    {
                        data.Departments.Add(new
                        {
                            DepartmentName = departmentReader["department_name"].ToString(),
                            JobPosition = departmentReader["job_position"].ToString()
                        });
                    }
                    departmentReader.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in PopulateCreateAnnouncementModal: " + ex.ToString());
                return JsonConvert.SerializeObject(new { Error = "ExceptionMessage - " + ex.Message });
            }

            return JsonConvert.SerializeObject(data);
        }

        public class announncement_details
        {
            public string heading { get; set; }
            public string announcement_description { get; set; }
            public string posted_date { get; set; }
            public string posted_time { get; set; }
            public string viewed_by { get; set; }
        }


        [WebMethod]
        public static string openannouncementmodal(string announcement_id)
        {
            var data = "";
            var List = new List<announncement_details>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string announncement_details_Query = $@"SELECT a.heading, a.announcement_description, a.posted_on, a.viewed_by 
                                                            FROM hrms.announcement a
                                                            WHERE a.announcement_id = '{announcement_id}';";
                    var announncement_details_da = new MySqlDataAdapter(announncement_details_Query, conn);
                    DataTable announncement_details_dt = new DataTable();
                    announncement_details_da.Fill(announncement_details_dt);

                    foreach (DataRow row in announncement_details_dt.Rows)
                    {
                        var posted_on = row["posted_on"].ToString();
                        var posted_date = DateTime.Parse(posted_on).ToString("MMM. dd, yyyy");
                        var posted_time = DateTime.Parse(posted_on).ToString("hh:mm tt");

                        List.Add(new announncement_details
                        {
                            heading = row["heading"].ToString(),
                            announcement_description = row["announcement_description"].ToString(),
                            posted_date = posted_date,
                            posted_time = posted_time,
                            viewed_by = row["viewed_by"].ToString()
                        });
                    }
                    conn.Close();

                    var announncement_details_data = JsonConvert.SerializeObject(List);
                    data = announncement_details_data;

                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populate_announncements_details: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return JsonConvert.SerializeObject(data);
        }

        public class CommentDetails
        {
            public string comment_id { get; set; }
            public string emp_name { get; set; }
            public string profile_letters { get; set; }
            public string profile_img { get; set; }
            public string profile_color { get; set; }
            public string announcement_comments { get; set; }
            public string posted_date { get; set; }
            public string posted_time { get; set; }
        }


        [WebMethod]
        public static string populatecomments(string announcement_id, string commentInput)
        {
            var data = "";
            var List = new List<CommentDetails>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = "1";//need to work
                    int rowsAffected = 0;
                    if (!string.IsNullOrEmpty(commentInput))
                    {
                        string insert_comments_query = $@"insert hrms.announcement_comments (announcement_id,emp_id,announcement_comments,commented_time) values ('{announcement_id}','{emp_id}','{commentInput}','{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}');";
                        MySqlCommand cmd = new MySqlCommand(insert_comments_query, conn);
                        rowsAffected = cmd.ExecuteNonQuery();
                    }

                    if (string.IsNullOrEmpty(commentInput) || rowsAffected > 0)
                    {
                        string announncement_comments_Query = $@"SELECT CONCAT(e.first_name, "" "", e.last_name) AS emp_name, CONCAT(LEFT(e.first_name, 1), LEFT(e.last_name, 1)) AS profile_letters, 
                                                             p.profile_img, p.profile_color, c.announcement_comments, c.commented_time, c.comment_id  
                                                             FROM hrms.announcement_comments c 
                                                             LEFT JOIN hrms.employee e ON (e.emp_id = c.emp_id)	
                                                             LEFT JOIN hrms.profile_picture p ON (p.emp_id = e.emp_id)
                                                             WHERE c.announcement_id = '{announcement_id}';";
                        var announncement_comments_da = new MySqlDataAdapter(announncement_comments_Query, conn);
                        DataTable announncement_comments_dt = new DataTable();
                        announncement_comments_da.Fill(announncement_comments_dt);

                        foreach (DataRow row in announncement_comments_dt.Rows)
                        {
                            var posted_on = row["commented_time"].ToString();
                            var posted_date = DateTime.Parse(posted_on).ToString("MMM. dd, yyyy");
                            var posted_time = DateTime.Parse(posted_on).ToString("hh:mm tt");


                            List.Add(new CommentDetails
                            {
                                comment_id = row["comment_id"].ToString(),
                                emp_name = row["emp_name"].ToString(),
                                profile_letters = row["profile_letters"].ToString(),
                                profile_img = row["profile_img"].ToString(),
                                profile_color = row["profile_color"].ToString(),
                                announcement_comments = row["announcement_comments"].ToString(),
                                posted_date = posted_date,
                                posted_time = posted_time
                            });
                        }
                        conn.Close();

                        var announncement_details_data = JsonConvert.SerializeObject(List);
                        data = announncement_details_data;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populatecomments_details: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string deletecomment(string comment_id)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    int rowsAffected = 0;
                    if (!string.IsNullOrEmpty(comment_id))
                    {
                        string deletecomment_query = $@"DELETE FROM hrms.announcement_comments WHERE comment_id = '{comment_id}';";
                        MySqlCommand deletecomment_cmd = new MySqlCommand(deletecomment_query, conn);
                        rowsAffected = deletecomment_cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            data = "true";
                        }
                        else
                        {
                            data = "false";
                        }
                    }
                    else
                    {
                        data = "false";
                    }

                }
            }
            catch (Exception ex)
            {
                log.Error("Error in deletecomment: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;
        }
    }
}