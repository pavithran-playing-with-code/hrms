using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Org.BouncyCastle.Crypto.Generators;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net.PeerToPeer;
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
            if (!Request.Url.Query.Contains("changePassword"))
            {
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
            }
        }


        [WebMethod]
        public static string login_info(string username, string password)
        {
            string data = "";
            try
            {
                username = username.Trim().Replace("'", "''");

                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string login_info_Query = "SELECT emp_id, account_password FROM hrms.employee WHERE email = @username AND is_active = 'Y'";

                    using (MySqlCommand cmd = new MySqlCommand(login_info_Query, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string emp_id = reader["emp_id"].ToString();
                                string storedHashedPassword = reader["account_password"].ToString();

                                bool isPasswordCorrect = BCrypt.Net.BCrypt.Verify(password, storedHashedPassword);

                                if (isPasswordCorrect)
                                {
                                    HttpContext.Current.Session["emp_id"] = emp_id;
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
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in login: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;
        }


        [WebMethod]
        public static string checkUserExists(string userInput)
        {
            string data = "not_exists";
            try
            {
                userInput = userInput.Trim().Replace("'", "''");

                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string query = $@"SELECT COUNT(*) FROM hrms.employee WHERE (email = '{userInput}' OR phone_number = '{userInput}') AND is_active = 'Y';";
                    var cmd = new MySqlCommand(query, conn);
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    if (count > 0)
                    {
                        data = "exists";
                        GenerateOTP(userInput);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in checkUserExists: " + ex.ToString());
                data = "error";
            }

            return data;
        }

        public static string GenerateOTP(string userInput)
        {
            Random random = new Random();
            string otp = random.Next(100000, 999999).ToString();
            DateTime expiryTime = DateTime.Now.AddMinutes(5);

            string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                INSERT INTO hrms.OTPStorage (UserInput, OTP, ExpiryTime) 
                VALUES (@UserInput, @OTP, @ExpiryTime) 
                ON DUPLICATE KEY UPDATE 
                OTP = @OTP, ExpiryTime = @ExpiryTime";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserInput", userInput);
                    cmd.Parameters.AddWithValue("@OTP", otp);
                    cmd.Parameters.AddWithValue("@ExpiryTime", expiryTime);
                    cmd.ExecuteNonQuery();
                }
            }

            // TODO: Send OTP via Email/SMS (Use an API for this)

            return "OTP Sent";
        }

        [WebMethod]
        public static string VerifyOrValidate(string validationType, string userInput, string enteredValue)
        {
            string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                if (validationType == "OTP")
                {
                    string otpQuery = "SELECT OTP FROM hrms.OTPStorage WHERE UserInput = @UserInput AND ExpiryTime > NOW()";
                    using (MySqlCommand cmd = new MySqlCommand(otpQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserInput", userInput);
                        object dbOTP = cmd.ExecuteScalar();

                        if (dbOTP != null && dbOTP.ToString() == enteredValue)
                        {
                            bool isEmail = userInput.Contains("@");
                            string empQuery = isEmail
                                ? "SELECT emp_id FROM hrms.employee WHERE email = @UserInput AND is_active = 'Y'"
                                : "SELECT emp_id FROM hrms.employee WHERE phone_number = @UserInput AND is_active = 'Y'";

                            using (MySqlCommand empCmd = new MySqlCommand(empQuery, conn))
                            {
                                empCmd.Parameters.AddWithValue("@UserInput", userInput);
                                object emp_id = empCmd.ExecuteScalar();

                                if (emp_id != null)
                                {
                                    HttpContext.Current.Session["emp_id"] = emp_id.ToString();
                                }
                            }
                            return "OTP Verified";
                        }
                        else
                        {
                            return "Invalid or Expired OTP";
                        }
                    }
                }
                else if (validationType == "OldPassword")
                {
                    var emp_id = HttpContext.Current.Session["emp_id"];

                    string passwordQuery = "SELECT account_password FROM hrms.employee WHERE emp_id = @UserInput AND is_active = 'Y'";

                    using (MySqlCommand cmd = new MySqlCommand(passwordQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserInput", emp_id);
                        var dbPassword = cmd.ExecuteScalar();

                        if (dbPassword != null)
                        {
                            bool isPasswordCorrect = BCrypt.Net.BCrypt.Verify(enteredValue, dbPassword.ToString());

                            if (isPasswordCorrect)
                            {
                                return "Password Verified";
                            }
                        }
                        return "Invalid Password";
                    }
                }

                else
                {
                    return "Invalid Validation Type";
                }
            }
        }

        [WebMethod]
        public static string updatePassword(string newPassword)
        {
            string data = "";
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);

            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];

                    if (!string.IsNullOrEmpty(newPassword) && emp_id != null)
                    {
                        string updatequery = "UPDATE hrms.employee SET account_password = @password WHERE emp_id = @empId";

                        using (MySqlCommand updatecmd = new MySqlCommand(updatequery, conn))
                        {
                            updatecmd.Parameters.AddWithValue("@password", hashedPassword);
                            updatecmd.Parameters.AddWithValue("@empId", emp_id);

                            int rowsAffected = updatecmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                                data = "Password Updated";
                            else
                                data = "Error updating password";
                        }
                    }
                    else
                    {
                        data = "Invalid request";
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in updatePassword: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;
        }

    }
}