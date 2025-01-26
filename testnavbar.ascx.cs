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
    public partial class testnavbar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            // Highlight the active page in the sidebar
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

            // Handle the leave submenu specifically
            if (currentPage == "ltest.aspx" || currentPage == "testing.aspx" || currentPage == "my_leave_requests.aspx" || currentPage == "leave-type.aspx")
            {
                leaveSubMenu.Attributes["class"] = "collapse show";

                // Highlight specific pages under Leave submenu
                switch (currentPage)
                {
                    case "ltest.aspx":
                        ltestNavLink.Attributes["class"] += " active-page";
                        break;
                    case "testing.aspx":
                        testingNavLink.Attributes["class"] += " active-page";
                        break;
                    case "my_leave_requests.aspx":
                        myLeaveRequestsNavLink.Attributes["class"] += " active-page";
                        break;
                    case "leave-type.aspx":
                        leaveTypeNavLink.Attributes["class"] += " active-page";
                        break;
                }
            }
        }

    }
}