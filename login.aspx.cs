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
    public partial class login : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(login));

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }

        [WebMethod]
        public static string login_info(string username, string password)
        {
            var data = "";
            try
            {
                username = username.Trim().Replace("'", "''");
                password = password.Trim().Replace("'", "''");

                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string login_info_Query = $@"SELECT emp_id FROM hrms.employee WHERE gmail = '{username}' AND account_password = '{password}';";
                    var cmd = new MySqlCommand(login_info_Query, conn);
                    var emp_id = cmd.ExecuteScalar();
                    if (emp_id != null && !string.IsNullOrEmpty(emp_id.ToString()))
                    {
                        HttpContext.Current.Session["emp_id"] = emp_id.ToString();
                        data = "true";
                    }
                    else
                    {
                        data = "false";
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in login: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
            }

            return data;
        }

    }
}