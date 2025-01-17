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
using Google.Protobuf.WellKnownTypes;
using Newtonsoft.Json.Linq;
using System.IO;

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
                                              WHERE e.emp_id = '{HttpContext.Current.Session["emp_id"]}' AND e.is_active = 'Y';";
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
                                                            LEFT JOIN hrms.profile_picture p ON (p.emp_id = e.emp_id) 
                                                            WHERE e.is_active = 'Y';";
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
        public static string PopulateCreateAnnouncementModal(string dropdowntype, string[] value, string[] departmentValues)
        {
            var data = new List<object>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    if (dropdowntype == "department")
                    {
                        string departmentQuery = value != null && value.Length > 0
                                            ? $@"SELECT department_id, department_name 
                         FROM hrms.department 
                         WHERE department_id IN ({string.Join(",", value.Select(v => $"'{v}'"))});"
                                            : "SELECT department_id, department_name FROM hrms.department;";
                        using (var departmentCmd = new MySqlCommand(departmentQuery, conn))
                        using (var departmentReader = departmentCmd.ExecuteReader())
                        {
                            var departments = new List<object>();
                            while (departmentReader.Read())
                            {
                                departments.Add(new
                                {
                                    id = departmentReader["department_id"].ToString(),
                                    name = departmentReader["department_name"].ToString()
                                });
                            }
                            if (departments.Count > 1)
                            {
                                data.Add(new { id = "All", name = "All" });
                            }
                            data.AddRange(departments);
                        }
                    }

                    if (dropdowntype == "job_position")
                    {
                        string jobPositionQuery = value.Contains("All")
                            ? "SELECT job_position_id, job_position_name FROM hrms.job_position;"
                            : $@"SELECT job_position_id, job_position_name 
                        FROM hrms.job_position WHERE department_id IN ({string.Join(",", value.Select(v => $"'{v}'"))});";

                        using (var jobPositionCmd = new MySqlCommand(jobPositionQuery, conn))
                        using (var jobPositionReader = jobPositionCmd.ExecuteReader())
                        {
                            var jobPositions = new List<object>();
                            while (jobPositionReader.Read())
                            {
                                jobPositions.Add(new
                                {
                                    id = jobPositionReader["job_position_id"].ToString(),
                                    name = jobPositionReader["job_position_name"].ToString()
                                });
                            }
                            if (jobPositions.Count > 1)
                            {
                                data.Add(new { id = "All", name = "All" });
                            }
                            data.AddRange(jobPositions);
                        }
                    }

                    if (dropdowntype == "employees")
                    {
                        string departmentCondition = departmentValues != null && !departmentValues.Contains("All")
                            ? $"AND emp_dept_id IN ({string.Join(",", departmentValues.Select(v => $"'{v}'"))})"
                            : "";

                        string jobPositionCondition = value.Contains("All")
                            ? ""
                            : $"AND emp_job_position_id IN ({string.Join(",", value.Select(v => $"'{v}'"))})";

                        string employeeQuery = $@"SELECT emp_id, CONCAT(first_name, ' ', last_name) AS emp_name 
                                        FROM hrms.employee 
                                        WHERE is_active = 'Y' {departmentCondition} {jobPositionCondition};";

                        using (var employeeCmd = new MySqlCommand(employeeQuery, conn))
                        using (var employeeReader = employeeCmd.ExecuteReader())
                        {
                            var employees = new List<object>();
                            while (employeeReader.Read())
                            {
                                employees.Add(new
                                {
                                    id = employeeReader["emp_id"].ToString(),
                                    name = employeeReader["emp_name"].ToString()
                                });
                            }
                            if (employees.Count > 1)
                            {
                                data.Add(new { id = "All", name = "All" });
                            }
                            data.AddRange(employees);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in PopulateCreateAnnouncementModal: " + ex.ToString());
                return JsonConvert.SerializeObject(new { Error = "ExceptionMessage - " + ex.Message });
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string UploadAttachment(string fileName, string fileData)
        {
            try
            {
                string folderPath = HttpContext.Current.Server.MapPath("~/UploadedFiles/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                byte[] fileBytes = Convert.FromBase64String(fileData);
                string empId = HttpContext.Current.Session["emp_id"].ToString();
                string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                string uniqueFileName = $"{empId}_{timestamp}_{fileName}";

                string filePath = Path.Combine(folderPath, uniqueFileName);
                File.WriteAllBytes(filePath, fileBytes);

                return $"/UploadedFiles/{uniqueFileName}";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string insertupdateannouncement(string title, string description, string attachments, string expireDate, string[] department, string[] jobPosition, string[] employees, string disableComments, bool isedit, string announcementId)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string departmentCondition = department != null && !department.Contains("All")
                        ? $"AND emp_dept_id IN ({string.Join(",", department.Select(v => $"'{v}'"))})"
                        : "";

                    string jobPositionCondition = jobPosition != null && !jobPosition.Contains("All")
                        ? $"AND emp_job_position_id IN ({string.Join(",", jobPosition.Select(v => $"'{v}'"))})"
                        : "";

                    string employeesCondition = employees != null && !employees.Contains("All")
                        ? $"AND emp_id IN ({string.Join(",", employees.Select(v => $"'{v}'"))})"
                        : "";

                    string employeeQuery = $@"
                SELECT emp_id 
                FROM hrms.employee 
                WHERE is_active = 'Y' {departmentCondition} {jobPositionCondition} {employeesCondition};";
                    MySqlCommand cmd = new MySqlCommand(employeeQuery, conn);
                    var reader = cmd.ExecuteReader();
                    var viewableByList = new List<string>();

                    while (reader.Read())
                    {
                        viewableByList.Add(reader["emp_id"].ToString());
                    }
                    reader.Close();

                    string viewableBy = string.Join(",", viewableByList);
                    if (string.IsNullOrEmpty(viewableBy))
                    {
                        return JsonConvert.SerializeObject("No employees matched the criteria.");
                    }

                    var emp_id = HttpContext.Current.Session["emp_id"];

                    if (isedit && !string.IsNullOrEmpty(announcementId))
                    {
                        // Update query
                        string updateAnnouncementQuery = $@"
                    UPDATE hrms.announcement 
                    SET emp_id = '{emp_id}', 
                        Heading = '{title}', 
                        announcement_description = '{description}', 
                        attachments = '{attachments}', 
                        expire_date = '{expireDate}', 
                        viewable_by = '{viewableBy}', 
                        comments = '{disableComments}' 
                    WHERE announcement_id = '{announcementId}';";

                        cmd = new MySqlCommand(updateAnnouncementQuery, conn);
                    }
                    else
                    {
                        // Insert query
                        string insertAnnouncementQuery = $@"
                    INSERT INTO hrms.announcement 
                    (emp_id, Heading, announcement_description, attachments, posted_on, expire_date, viewable_by, comments) 
                    VALUES ('{emp_id}', '{title}', '{description}', '{attachments}', '{DateTime.Now:yyyy-MM-dd HH:mm:ss}', '{expireDate}', '{viewableBy}', '{disableComments}');";

                        cmd = new MySqlCommand(insertAnnouncementQuery, conn);
                    }

                    int rowsAffected = cmd.ExecuteNonQuery();
                    data = rowsAffected > 0 ? "success" : "failure";
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in insertannouncement: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

        public class announncement_details
        {
            public string heading { get; set; }
            public string announcement_description { get; set; }
            public string attachments { get; set; }
            public string posted_date { get; set; }
            public string posted_time { get; set; }
            public string viewed_by { get; set; }
            public string comments { get; set; }
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

                    string announncement_details_Query = $@"SELECT a.heading, a.announcement_description, a.attachments, a.posted_on, a.viewed_by, a.comments  
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
                            attachments = row["attachments"].ToString(),
                            posted_date = posted_date,
                            posted_time = posted_time,
                            viewed_by = row["viewed_by"].ToString(),
                            comments = row["comments"].ToString()
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

        public class editannounncement
        {
            public string emp_id { get; set; }
            public string Heading { get; set; }
            public string announcement_description { get; set; }
            public string attachments { get; set; }
            public string expire_date { get; set; }
            public string viewable_by { get; set; }
            public string comments { get; set; }
            public string departments { get; set; }
            public string job_positions { get; set; }
        }

        [WebMethod]
        public static string editannouncement(string announcement_id)
        {
            var data = "";
            var List = new List<editannounncement>();
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string announncement_Query = $@"SELECT emp_id, Heading, announcement_description, attachments, expire_date, viewable_by, comments FROM hrms.announcement WHERE announcement_id = @announcement_id;";
                    using (var cmd = new MySqlCommand(announncement_Query, conn))
                    {
                        cmd.Parameters.AddWithValue("@announcement_id", announcement_id);
                        var da = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        foreach (DataRow row in dt.Rows)
                        {
                            var emp_ids = row["viewable_by"].ToString().Split(',');
                            var departments = new List<string>();
                            var jobPositions = new List<string>();

                            foreach (var emp_id in emp_ids)
                            {
                                string emp_details_query = @"SELECT emp_dept_id, emp_job_position_id 
                                                         FROM hrms.employee WHERE emp_id = @emp_id;";
                                using (var empCmd = new MySqlCommand(emp_details_query, conn))
                                {
                                    empCmd.Parameters.AddWithValue("@emp_id", emp_id);
                                    using (var reader = empCmd.ExecuteReader())
                                    {
                                        if (reader.Read())
                                        {
                                            departments.Add(reader["emp_dept_id"].ToString());
                                            jobPositions.Add(reader["emp_job_position_id"].ToString());
                                        }
                                    }
                                }
                            }

                            List.Add(new editannounncement
                            {
                                emp_id = row["emp_id"].ToString(),
                                Heading = row["Heading"].ToString(),
                                announcement_description = row["announcement_description"].ToString(),
                                attachments = row["attachments"].ToString(),
                                expire_date = row["expire_date"].ToString(),
                                viewable_by = row["viewable_by"].ToString(),
                                comments = row["comments"].ToString(),
                                departments = string.Join(",", departments),
                                job_positions = string.Join(",", jobPositions)
                            });
                        }

                        conn.Close();

                        var announncement_data = JsonConvert.SerializeObject(List);
                        data = announncement_data;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in editannouncement: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string deleteannouncement(string announcement_id)
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
                            string getFilePathQuery = "SELECT attachments FROM hrms.announcement WHERE announcement_id = @announcement_id;";
                            using (var cmd = new MySqlCommand(getFilePathQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@announcement_id", announcement_id);
                                using (var reader = cmd.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        filePath = reader["attachments"].ToString();
                                    }
                                }
                            }

                            string deleteCommentsQuery = "DELETE FROM hrms.announcement_comments WHERE announcement_id = @announcement_id;";
                            using (var cmd = new MySqlCommand(deleteCommentsQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@announcement_id", announcement_id);
                                cmd.ExecuteNonQuery();
                            }

                            string deleteAnnouncementQuery = "DELETE FROM hrms.announcement WHERE announcement_id = @announcement_id;";
                            using (var cmd = new MySqlCommand(deleteAnnouncementQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@announcement_id", announcement_id);
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
                                                             WHERE c.announcement_id = '{announcement_id}' AND e.is_active = 'Y';";
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