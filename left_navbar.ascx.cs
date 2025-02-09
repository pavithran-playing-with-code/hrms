using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace hrms
{
    public partial class left_navbar : System.Web.UI.UserControl
    {
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

                        if (accessLevel != null && accessLevel.ToString().ToLower() != "high")
                        {
                            LeaveDashboardNavLink.Visible = false;
                            AllemployeeLeaveRequestNavLink.Visible = false;
                            AnnouncementsNavLink.Visible = false;
                            DashboardNavLink.Visible = false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"Error: {ex.Message}");
            }

            string currentPage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            foreach (Control control in accordionSidebar.Controls)
            {
                if (control is HtmlAnchor link)
                {
                    string hrefValue = link.HRef.ToLower();
                    if (hrefValue.Contains(currentPage))
                    {
                        link.Attributes["class"] += " active-page";
                    }
                }
            }

            if (currentPage == "leave_emp_dashboard.aspx" || currentPage == "all_emp_leave_request.aspx" || currentPage == "my_leave_requests.aspx" || currentPage == "leave_configuration.aspx")
            {
                leaveSubMenu.Attributes["class"] = "collapse show";

                switch (currentPage)
                {
                    case "leave_emp_dashboard.aspx":
                        LeaveDashboardNavLink.Attributes["class"] += " active-page";
                        break;
                    case "all_emp_leave_request.aspx":
                        AllemployeeLeaveRequestNavLink.Attributes["class"] += " active-page";
                        break;
                    case "my_leave_requests.aspx":
                        myLeaveRequestsNavLink.Attributes["class"] += " active-page";
                        break;
                    case "leave_configuration.aspx":
                        leaveConfigurationNavLink.Attributes["class"] += " active-page";
                        break;
                }
            }

            if (currentPage == "tickets.aspx")
            {
                HelpDeskSubMenu.Attributes["class"] = "collapse show";

                switch (currentPage)
                {
                    case "tickets.aspx":
                        ticketsNavLink.Attributes["class"] += " active-page";
                        break;
                }
            }
        }

    }
}