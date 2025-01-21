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
using Antlr.Runtime.Misc;
using System.Net.Mail;
using Twilio;

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

            /* try
             {
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
             }*/
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
            public string emp_access_lvl { get; set; }
        }

        [WebMethod]
        public static string populateannounncements()
        {
            var data = "";
            var List = new List<announncement>();

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    string accessLevelQuery = @"SELECT access_level FROM hrms.employee WHERE emp_id = @emp_id";
                    var emp_access_lvl = "";
                    using (var cmd = new MySqlCommand(accessLevelQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@emp_id", emp_id);
                        var accessLevel = cmd.ExecuteScalar();

                        if (accessLevel != null && accessLevel.ToString().ToLower() == "high")
                        {
                            emp_access_lvl = "true";
                        }
                    }

                    string announncement_Query = $@"SELECT a.announcement_id, CONCAT(LEFT(e.first_name, 1), LEFT(e.last_name, 1)) AS profile_letters, 
                                                            p.profile_img, p.profile_color, a.heading
                                                            FROM hrms.announcement a
                                                            LEFT JOIN hrms.employee e ON (e.emp_id = a.posted_by) 
                                                            LEFT JOIN hrms.profile_picture p ON (p.emp_id = e.emp_id) 
                                                            WHERE e.is_active = 'Y' AND a.posted_on IS NOT NULL AND a.deleted_by IS NULL AND a.expire_date >= CURDATE() 
                                                            AND (FIND_IN_SET('{emp_id}', a.viewable_by) > 0 OR e.access_level = 'high') 
                                                            ORDER BY a.posted_on DESC; ";
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
                            heading = row["heading"].ToString(),
                            emp_access_lvl = emp_access_lvl
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
                                                            WHERE a.announcement_id = '{announcement_id}' AND a.deleted_by IS NULL;";
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

        [WebMethod]
        public static string add_viewed_by(string announcement_id)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    int rowsAffected = 0;
                    if (!string.IsNullOrEmpty(announcement_id))
                    {
                        string updatequery = $@"UPDATE announcement SET viewed_by = CONCAT(viewed_by, ',', {emp_id}) 
                                                WHERE announcement_id = '{announcement_id}' AND (viewed_by IS NULL OR viewed_by = '' OR NOT FIND_IN_SET({emp_id}, viewed_by));";
                        MySqlCommand updatecmd = new MySqlCommand(updatequery, conn);
                        rowsAffected = updatecmd.ExecuteNonQuery();

                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in add_viewed_by: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;
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

        public static void notifyemployee(string announcement_id)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    if (!string.IsNullOrEmpty(announcement_id))
                    {
                        string getAnnouncementInfoQuery = $@"SELECT CONCAT(e.first_name, "" "", e.last_name) AS emp_name, a.Heading, a.announcement_description, a.attachments, 
												     a.posted_on, a.viewable_by, a.notify 
                                                     FROM hrms.announcement a 
                                                     LEFT JOIN hrms.employee e ON (e.emp_id = a.posted_by)
                                                     WHERE a.announcement_id = '{announcement_id}';";
                        MySqlCommand getAnnouncementInfoCmd = new MySqlCommand(getAnnouncementInfoQuery, conn);
                        MySqlDataReader reader = getAnnouncementInfoCmd.ExecuteReader();

                        if (reader.Read())
                        {
                            string emp_name = reader["emp_name"].ToString();
                            string title = reader["Heading"].ToString();
                            string description = reader["announcement_description"].ToString();
                            string attachments = reader["attachments"].ToString();
                            string posted_on = reader["posted_on"].ToString();
                            string viewable_by = reader["viewable_by"].ToString();
                            string notify = reader["notify"].ToString();

                            reader.Close();

                            if (!string.IsNullOrEmpty(posted_on))
                            {
                                string getEmpInfoQuery = $@"SELECT email, phone_number FROM hrms.employee WHERE is_active = 'Y' AND emp_id IN ({viewable_by});";
                                MySqlCommand getEmpInfoCmd = new MySqlCommand(getEmpInfoQuery, conn);
                                MySqlDataReader empReader = getEmpInfoCmd.ExecuteReader();

                                var notifyByList = new List<(string Email, string PhoneNumber)>();

                                while (empReader.Read())
                                {
                                    string email = empReader["email"].ToString();
                                    string phone = empReader["phone_number"].ToString();
                                    notifyByList.Add((email, phone));
                                }

                                empReader.Close();

                                if (!string.IsNullOrEmpty(notify))
                                {
                                    string[] notifyArray = notify.Split(new[] { ',', ' ' }, StringSplitOptions.RemoveEmptyEntries);

                                    foreach (var (email, phone) in notifyByList)
                                    {
                                        if (notifyArray.Contains("email"))
                                        {
                                            MailMessage mailMessage = new MailMessage();
                                            mailMessage.From = new MailAddress("vv.pavithran12@gmail.com");
                                            mailMessage.To.Add(email);
                                            mailMessage.Subject = title;
                                            mailMessage.Body = description;
                                            mailMessage.IsBodyHtml = true;

                                            string folderPath = HttpContext.Current.Server.MapPath("~/UploadedFiles/");
                                            string absoluteAttachmentPath = Path.Combine(folderPath, Path.GetFileName(attachments));

                                            if (!string.IsNullOrEmpty(attachments) && File.Exists(absoluteAttachmentPath))
                                            {
                                                mailMessage.Attachments.Add(new Attachment(absoluteAttachmentPath));
                                            }

                                            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                                            smtpClient.UseDefaultCredentials = false;
                                            smtpClient.Credentials = new System.Net.NetworkCredential("vv.pavithran12@gmail.com", "aajuyoahcuszqrey");
                                            smtpClient.EnableSsl = true;

                                            try
                                            {
                                                smtpClient.Send(mailMessage);
                                            }
                                            catch (Exception ex)
                                            {
                                                log.Error("Error sending email: " + ex.ToString());
                                            }
                                        }

                                        if (notifyArray.Contains("phone"))
                                        {
                                            try
                                            {
                                                const string accountSid = "USf76f6161a139c7f3bcf1c01a137273d6";
                                                const string authToken = "4RQCHBS2G5W294QXRYZ48XL2";
                                                const string twilioPhoneNumber = "6381273139";

                                                TwilioClient.Init(accountSid, authToken);

                                                var messageBody = $"Hello Team,\n\nA new announcement has been posted:\n\"{title}\"\n\nPlease check your Dashboard for details.\n\nThank you,\n{emp_name}";

                                                var message = Twilio.Rest.Api.V2010.Account.MessageResource.Create(
                                                    body: messageBody,
                                                    from: new Twilio.Types.PhoneNumber(twilioPhoneNumber),
                                                    to: new Twilio.Types.PhoneNumber(phone)
                                                );

                                                Console.WriteLine($"SMS sent to {phone}: {message.Sid}");
                                            }
                                            catch (Exception ex)
                                            {
                                                log.Error("Error sending SMS: " + ex.ToString());
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in check: " + ex.ToString());
            }
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
        public static string publish_edit_save_announcement(string title, string description, string attachments, string expireDate, string[] department, string[] jobPosition, string[] employees, string[] notify, string disableComments, string action, string announcementId)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];
                    MySqlCommand cmd = new MySqlCommand();

                    if (action == "publish_from_dashboard" && !string.IsNullOrEmpty(announcementId))
                    {
                        string updateAnnouncementfromdashboardQuery = $@"UPDATE hrms.announcement SET posted_by = '{emp_id}', posted_on = NOW() 
                        WHERE announcement_id = '{announcementId}';";

                        cmd = new MySqlCommand(updateAnnouncementfromdashboardQuery, conn);
                    }
                    else
                    {
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
                SELECT emp_id , email, phone_number
                FROM hrms.employee 
                WHERE is_active = 'Y' {departmentCondition} {jobPositionCondition} {employeesCondition};";
                        cmd = new MySqlCommand(employeeQuery, conn);
                        var reader = cmd.ExecuteReader();
                        var viewableByList = new List<string>();
                        var notifyby = new List<(string Email, string PhoneNumber)>();

                        while (reader.Read())
                        {
                            viewableByList.Add(reader["emp_id"].ToString());
                            notifyby.Add((reader["email"].ToString(), reader["phone_number"].ToString()));
                        }
                        reader.Close();

                        string viewableBy = string.Join(",", viewableByList);
                        if (string.IsNullOrEmpty(viewableBy))
                        {
                            return JsonConvert.SerializeObject("No employees matched the criteria.");
                        }

                        string notifyValue;
                        if (notify != null && notify.Length > 0)
                        {
                            notifyValue = "'" + string.Join(",", notify) + "'";
                        }
                        else
                        {
                            notifyValue = "''";
                        }

                        if (action == "edit" && !string.IsNullOrEmpty(announcementId))
                        {
                            string updateAnnouncementQuery = $@"UPDATE hrms.announcement SET 
                        Heading = '{title}', announcement_description = '{description}', attachments = '{attachments}', expire_date = '{expireDate}', 
                        viewable_by = '{viewableBy}', notify = {notifyValue}, comments = '{disableComments}', edited_by = '{emp_id}', edited_time = NOW() 
                        WHERE announcement_id = '{announcementId}';";

                            cmd = new MySqlCommand(updateAnnouncementQuery, conn);
                        }
                        else if (action == "publish")
                        {
                            string insertAnnouncementQuery = $@"INSERT INTO hrms.announcement 
                    (Heading, announcement_description, attachments, posted_by, posted_on, expire_date, viewable_by, notify, comments, created_by, created_time) 
                    VALUES ('{title}', '{description}', '{attachments}', '{emp_id}', '{DateTime.Now:yyyy-MM-dd HH:mm:ss}', '{expireDate}', '{viewableBy}', {notifyValue}, '{disableComments}', '{emp_id}', '{DateTime.Now:yyyy-MM-dd HH:mm:ss}');";

                            cmd = new MySqlCommand(insertAnnouncementQuery, conn);
                        }
                        else if (action == "save")
                        {
                            string saveAnnouncementQuery = $@"INSERT INTO hrms.announcement 
                    (Heading, announcement_description, attachments, expire_date, viewable_by, notify, comments, created_by, created_time) 
                    VALUES ('{title}', '{description}', '{attachments}', '{expireDate}', '{viewableBy}', {notifyValue}, '{disableComments}', '{emp_id}', '{DateTime.Now:yyyy-MM-dd HH:mm:ss}');";

                            cmd = new MySqlCommand(saveAnnouncementQuery, conn);
                        }

                    }

                    int rowsAffected = cmd.ExecuteNonQuery();
                    data = rowsAffected > 0 ? "success" : "failure";

                    if (action == "publish")
                    {
                        var lastinsertidcmd = new MySqlCommand("SELECT LAST_INSERT_ID();", conn);
                        var insertedAnnouncementId = lastinsertidcmd.ExecuteScalar()?.ToString();

                        if (!string.IsNullOrEmpty(insertedAnnouncementId))
                        {
                            notifyemployee(insertedAnnouncementId);
                        }

                        data = "success";
                    }
                    else
                    {
                        if (data == "success")
                        {
                            notifyemployee(announcementId);
                        }
                    }
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

        [WebMethod]
        public static string Republish(string announcement_id)
        {
            var data = "";

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string announncement_details_Query = $@"SELECT a.heading, a.announcement_description, a.attachments, a.expire_date, a.viewable_by, a.notify, a.comments 
                                                            FROM hrms.announcement a
                                                            WHERE a.announcement_id = '{announcement_id}' AND a.deleted_by IS NULL;";

                    var announncement_details_da = new MySqlDataAdapter(announncement_details_Query, conn);
                    DataTable announncement_details_dt = new DataTable();
                    announncement_details_da.Fill(announncement_details_dt);

                    if (announncement_details_dt.Rows.Count > 0)
                    {
                        var heading = announncement_details_dt.Rows[0]["heading"].ToString();
                        var description = announncement_details_dt.Rows[0]["announcement_description"].ToString();
                        var attachments = announncement_details_dt.Rows[0]["attachments"].ToString();
                        var expireDate = Convert.ToDateTime(announncement_details_dt.Rows[0]["expire_date"]).ToString("yyyy-MM-dd");
                        var viewableBy = announncement_details_dt.Rows[0]["viewable_by"].ToString();
                        var notify = announncement_details_dt.Rows[0]["notify"].ToString();
                        var comments = announncement_details_dt.Rows[0]["comments"].ToString();
                        var emp_id = HttpContext.Current.Session["emp_id"];

                        if (emp_id != null)
                        {
                            string insertAnnouncementQuery = $@"
                        INSERT INTO hrms.announcement 
                        (Heading, announcement_description, attachments, posted_by, posted_on, expire_date, viewable_by, notify, comments, created_by, created_time) 
                        VALUES 
                        (@heading, @description, @attachments, @posted_by, NOW(), @expireDate, @viewableBy, @notify, @comments, @created_by, NOW());";

                            using (var cmd = new MySqlCommand(insertAnnouncementQuery, conn))
                            {
                                cmd.Parameters.AddWithValue("@heading", heading);
                                cmd.Parameters.AddWithValue("@description", description);
                                cmd.Parameters.AddWithValue("@attachments", attachments);
                                cmd.Parameters.AddWithValue("@posted_by", emp_id.ToString());
                                cmd.Parameters.AddWithValue("@expireDate", expireDate);
                                cmd.Parameters.AddWithValue("@viewableBy", viewableBy);
                                cmd.Parameters.AddWithValue("@notify", notify);
                                cmd.Parameters.AddWithValue("@comments", comments);
                                cmd.Parameters.AddWithValue("@created_by", emp_id.ToString());

                                cmd.ExecuteNonQuery();
                            }

                            if (notify != null && notify.Length > 0)
                            {
                                string employeeQuery = $@"
                SELECT email, phone_number
                FROM hrms.employee 
                WHERE is_active = 'Y' AND emp_id IN ({viewableBy});";
                                var cmd = new MySqlCommand(employeeQuery, conn);
                                var reader = cmd.ExecuteReader();
                                var notifyby = new List<(string Email, string PhoneNumber)>();

                                while (reader.Read())
                                {
                                    notifyby.Add((reader["email"].ToString(), reader["phone_number"].ToString()));
                                }
                                reader.Close();

                            }

                            data = "success";
                        }
                        else
                        {
                            data = "Session expired or employee ID not found.";
                        }
                    }
                    else
                    {
                        data = "Announcement not found.";
                    }

                    if (data == "success")
                    {
                        notifyemployee(announcement_id);
                    }

                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in Republish: " + ex.ToString());
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
            public string notify { get; set; }
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

                    string announncement_Query = $@"SELECT posted_by, Heading, announcement_description, attachments, expire_date, viewable_by, notify, comments FROM hrms.announcement WHERE announcement_id = @announcement_id;";
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
                                emp_id = row["posted_by"].ToString(),
                                Heading = row["Heading"].ToString(),
                                announcement_description = row["announcement_description"].ToString(),
                                attachments = row["attachments"].ToString(),
                                expire_date = row["expire_date"].ToString(),
                                viewable_by = row["viewable_by"].ToString(),
                                notify = row["notify"].ToString(),
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

                            var emp_id = HttpContext.Current.Session["emp_id"];

                            string updateCommentsQuery = "UPDATE hrms.announcement_comments SET deleted_by = @emp_id, deleted_time = NOW() WHERE announcement_id = @announcement_id;";
                            using (var cmd = new MySqlCommand(updateCommentsQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                cmd.Parameters.AddWithValue("@announcement_id", announcement_id);
                                cmd.ExecuteNonQuery();
                            }

                            string updateAnnouncementQuery = "UPDATE hrms.announcement SET deleted_by = @emp_id, deleted_time = NOW() WHERE announcement_id = @announcement_id;";
                            using (var cmd = new MySqlCommand(updateAnnouncementQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@emp_id", emp_id);
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
                                                             WHERE c.announcement_id = '{announcement_id}' AND c.deleted_by IS NULL AND e.is_active = 'Y';";
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