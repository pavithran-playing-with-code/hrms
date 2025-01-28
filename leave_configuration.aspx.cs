using log4net;
using Microsoft.IdentityModel.Tokens;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class leave_configuration : System.Web.UI.Page
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(leave_configuration));

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

        [WebMethod]
        public static string getDepartmentsAndLeaveApprovals()
        {
            var data = new List<object>();
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string query = @"
                SELECT d.department_id, d.department_name, 
                       e.emp_id, 
                       CONCAT(e.first_name, ' ', e.last_name, ' (', j.job_position_name, ')') AS employee_name,
                       la.level_1, la.level_2, la.level_3
                FROM hrms.department d
                LEFT JOIN hrms.employee e ON d.department_id = e.emp_dept_id AND e.is_active = 'Y'
                LEFT JOIN hrms.job_position j ON j.job_position_id = e.emp_job_position_id
                LEFT JOIN hrms.leave_approval la ON d.department_id = la.department_id
                ORDER BY d.department_id, e.emp_id;";

                    var departments = new Dictionary<string, dynamic>();

                    using (var cmd = new MySqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var departmentId = reader["department_id"].ToString();
                            var departmentName = reader["department_name"].ToString();
                            var employeeId = reader["emp_id"]?.ToString();
                            var employeeName = reader["employee_name"]?.ToString();

                            if (!departments.ContainsKey(departmentId))
                            {
                                departments[departmentId] = new
                                {
                                    DepartmentId = departmentId,
                                    DepartmentName = departmentName,
                                    Employees = new List<dynamic>(),
                                    LeaveApproval = new
                                    {
                                        Level1 = reader["level_1"]?.ToString(),
                                        Level2 = reader["level_2"]?.ToString(),
                                        Level3 = reader["level_3"]?.ToString()
                                    }
                                };
                            }

                            if (!string.IsNullOrEmpty(employeeId) && !string.IsNullOrEmpty(employeeName))
                            {
                                departments[departmentId].Employees.Add(new
                                {
                                    EmployeeId = employeeId,
                                    EmployeeName = employeeName
                                });
                            }
                        }
                    }

                    data = departments.Values.ToList();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in getDepartmentsAndLeaveApprovals: " + ex.ToString());
                return JsonConvert.SerializeObject(new { Error = "ExceptionMessage - " + ex.Message });
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string SaveLeaveApprovalLevels(int departmentId, string level_1, string level_2, string level_3)
        {
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string checkQuery = @"SELECT COUNT(*) FROM hrms.leave_approval WHERE department_id = @DepartmentId;";
                    int count;

                    using (var checkCmd = new MySqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                        count = Convert.ToInt32(checkCmd.ExecuteScalar());
                    }

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    if (count > 0)
                    {
                        string updateQuery = @"
                    UPDATE hrms.leave_approval
                    SET level_1 = @Level1, level_2 = @Level2, level_3 = @Level3, edited_by = @emp_id, edited_time = NOW()  
                    WHERE department_id = @DepartmentId;";

                        using (var updateCmd = new MySqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@Level1", level_1);
                            updateCmd.Parameters.AddWithValue("@Level2", level_2);
                            updateCmd.Parameters.AddWithValue("@Level3", level_3);
                            updateCmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                            updateCmd.Parameters.AddWithValue("@emp_id", emp_id);
                            updateCmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        string insertQuery = @"
                    INSERT INTO hrms.leave_approval (department_id, level_1, level_2, level_3, created_by, created_time)
                    VALUES (@DepartmentId, @Level1, @Level2, @Level3, @emp_id, NOW() );";

                        using (var insertCmd = new MySqlCommand(insertQuery, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                            insertCmd.Parameters.AddWithValue("@Level1", level_1);
                            insertCmd.Parameters.AddWithValue("@Level2", level_2);
                            insertCmd.Parameters.AddWithValue("@Level3", level_3);
                            insertCmd.Parameters.AddWithValue("@emp_id", emp_id);
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }

                // Return success response
                return JsonConvert.SerializeObject("success");
            }
            catch (Exception ex)
            {
                log.Error("Error in SaveLeaveApprovalLevels: " + ex.ToString());
                return JsonConvert.SerializeObject(new { Error = "ExceptionMessage - " + ex.Message });
            }
        }

        [WebMethod]
        public static string populateLeaveTypes()
        {
            var data = new List<object>();
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string leave_typeQuery = @"SELECT leave_type_id, leave_type, priority_level, max_leave FROM hrms.leave_type 
                                               WHERE deleted_by IS NULL ORDER BY priority_level;";

                    using (var leave_typeCmd = new MySqlCommand(leave_typeQuery, conn))
                    using (var leave_typeReader = leave_typeCmd.ExecuteReader())
                    {
                        while (leave_typeReader.Read())
                        {
                            data.Add(new
                            {
                                leave_type_id = leave_typeReader["leave_type_id"].ToString(),
                                leave_type = leave_typeReader["leave_type"].ToString(),
                                priority_level = leave_typeReader["priority_level"].ToString(),
                                max_leave = leave_typeReader["max_leave"].ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in populateLeaveTypes: " + ex.ToString());
                return JsonConvert.SerializeObject(new { Error = "ExceptionMessage - " + ex.Message });
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string add_leave_types(string leave_type, string priority_level, string max_leave)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    var emp_id = HttpContext.Current.Session["emp_id"];

                    string checkleave_typeQuery = $@"SELECT leave_type FROM hrms.leave_type WHERE deleted_by IS NULL AND leave_type = '{leave_type}';";

                    var checkleave_typeCmd = new MySqlCommand(checkleave_typeQuery, conn);
                    var duplicate = checkleave_typeCmd.ExecuteScalar();
                    if (duplicate != null)
                    {
                        return JsonConvert.SerializeObject("duplicate");
                    }

                    string saveLeaveQuery = @"
                INSERT INTO hrms.leave_type 
                (leave_type, priority_level, max_leave, created_by, created_time) 
                VALUES 
                (@leave_type, @priority_level, @max_leave, @created_by, @created_time);";

                    using (var cmd = new MySqlCommand(saveLeaveQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@leave_type", leave_type);
                        cmd.Parameters.AddWithValue("@priority_level", priority_level);
                        cmd.Parameters.AddWithValue("@max_leave", max_leave);
                        cmd.Parameters.AddWithValue("@created_by", emp_id);
                        cmd.Parameters.AddWithValue("@created_time", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                        int rowsAffected = cmd.ExecuteNonQuery();
                        data = rowsAffected > 0 ? "success" : "failure";
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in add_leave_types: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

        [WebMethod]
        public static string updateleavetypes(string leave_type_id, string leave_type, string max_leaves)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string checkleave_typeQuery = $@"SELECT leave_type FROM hrms.leave_type WHERE deleted_by IS NULL AND leave_type_id != '{leave_type_id}' AND leave_type = '{leave_type}';";

                    var checkleave_typeCmd = new MySqlCommand(checkleave_typeQuery, conn);
                    var duplicate = checkleave_typeCmd.ExecuteScalar();
                    if (duplicate != null)
                    {
                        return "duplicate";
                    }

                    var emp_id = HttpContext.Current.Session["emp_id"];
                    if (!string.IsNullOrEmpty(leave_type_id))
                    {
                        string updatequery = $@"UPDATE hrms.leave_type SET leave_type = '{leave_type}', max_leave = '{max_leaves}', 
                                                edited_by='{emp_id}', edited_time=NOW()  
                                                WHERE leave_type_id = '{leave_type_id}';";
                        MySqlCommand updatecmd = new MySqlCommand(updatequery, conn);
                        int rowsAffected = updatecmd.ExecuteNonQuery();
                        data = rowsAffected > 0 ? "success" : "failure";
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in updateleavetypes: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;
        }

        public class PriorityData
        {
            public string leave_type_id { get; set; }
            public int priority { get; set; }
        }

        [WebMethod]
        public static string saveLeavePriority(List<PriorityData> priorityData)
        {
            var data = "";
            try
            {
                string connectionString = "server=localhost;uid=root;pwd=pavithran@123;database=hrms";

                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    foreach (var item in priorityData)
                    {
                        string updateQuery = $@"UPDATE hrms.leave_type SET priority_level = '{item.priority}' 
                                         WHERE leave_type_id = '{item.leave_type_id}';";
                        MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn);
                        updateCmd.ExecuteNonQuery();
                    }
                    conn.Close();
                    data = "success";
                }
            }
            catch (Exception ex)
            {
                log.Error("Error in saveLeavePriority: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return data;
        }

        [WebMethod]
        public static string removeleavetype(string leave_type_id)
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

                            string updateQuery = "UPDATE hrms.leave_type SET deleted_by = @emp_id, deleted_time = NOW() WHERE leave_type_id = @leave_type_id;";
                            using (var cmd = new MySqlCommand(updateQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@emp_id", emp_id);
                                cmd.Parameters.AddWithValue("@leave_type_id", leave_type_id);
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

            }
            catch (Exception ex)
            {
                log.Error("Error in removeleavetype: " + ex.ToString());
                data = "ExceptionMessage - " + ex.Message;
                HttpContext.Current.Response.StatusCode = 500;
            }

            return JsonConvert.SerializeObject(data);
        }

    }
}