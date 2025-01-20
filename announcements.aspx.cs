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

namespace hrms
{
    public partial class announcements : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(announcements));

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class announncement
        {
            public string announcement_id { get; set; }
            public string emp_id { get; set; }
            public string emp_name { get; set; }
            public string department_name { get; set; }
            public string job_position_name { get; set; }
            public string Heading { get; set; }
            public string announcement_description { get; set; }
            public string attachments { get; set; }
            public string posted_on { get; set; }
            public string expire_date { get; set; }
            public string comments { get; set; }
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

                    string announncement_Query = $@"SELECT CONCAT(e.first_name, "" "", e.last_name) AS emp_name, d.department_name, j.job_position_name, 
                                                    a.announcement_id, a.posted_by, a.Heading, a.announcement_description, a.attachments, a.posted_on, a.expire_date, a.comments
                                                    FROM hrms.announcement a
                                                    LEFT JOIN hrms.employee e ON (e.emp_id = a.created_by)
                                                    LEFT JOIN hrms.department d ON (d.department_id = e.emp_dept_id) 
                                                    LEFT JOIN hrms.job_position j ON (j.job_position_id = e.emp_job_position_id) 
                                                    WHERE e.is_active = 'Y' AND a.deleted_by IS NULL 
                                                    ORDER BY a.created_time DESC; ";
                    var da = new MySqlDataAdapter(announncement_Query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        List.Add(new announncement
                        {
                            announcement_id = row["announcement_id"].ToString(),
                            emp_id = row["posted_by"].ToString(),
                            emp_name = row["emp_name"].ToString(),
                            department_name = row["department_name"].ToString(),
                            job_position_name = row["job_position_name"].ToString(),
                            Heading = row["Heading"].ToString(),
                            announcement_description = row["announcement_description"].ToString(),
                            attachments = row["attachments"].ToString(),
                            posted_on = row["posted_on"].ToString(),
                            expire_date = row["expire_date"].ToString(),
                            comments = row["comments"].ToString()
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

    }
}