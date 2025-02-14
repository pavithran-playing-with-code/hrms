<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="left_navbar.ascx.cs" Inherits="hrms.left_navbar" %>

<style>
    html, body {
        height: 100%;
        margin: 0;
    }

    .sidebar {
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .sidebar-nav {
        margin-left: -10%;
        flex-grow: 1;
        overflow-y: auto;
    }

    .sidebar {
        transition: width 0.3s ease;
    }

        .sidebar.toggled {
            width: 70px !important;
        }

            .sidebar.toggled .sidebar-brand-text,
            .sidebar.toggled span {
                display: none;
            }

    .sidebar-nav {
        transition: all 0.3s ease;
    }

    .btn#sidebarToggle {
        background-color: transparent;
    }

    .sidebar-divider {
        border-top: 1px solid rgba(255, 255, 255, 0.7) !important;
        margin: 10px 0;
        width: 100%;
    }

    #left-navbar .navbar {
        background: rgb(0, 132, 85);
        border: none;
    }

    #left-navbar .navbar-nav .nav-item {
        margin-bottom: 10px;
    }

    #left-navbar .navbar-nav .nav-link {
        color: white !important;
    }

        #left-navbar .navbar-nav .nav-link:hover {
            color: gray !important;
        }

        #left-navbar .navbar-nav .nav-link i {
            color: white !important;
            margin-right: 5px;
        }

        #left-navbar .navbar-nav .nav-link:hover i {
            color: gray !important;
        }

    #leaveSubMenu .navbar-nav .nav-link:hover {
        color: white !important;
    }

    .active-page {
        font-weight: bold;
        color: white !important;
    }
</style>

<input type="hidden" id="emp_access_lvl" name="emp_access_lvl" runat="server" />

<nav id="left-navbar" class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-primary p-0">
    <div class="container-fluid d-flex flex-column p-0" style="background-color: hsl(0,0%,13%); height: 100%;">
        <div class="flex-shrink-0" style="margin-left: -20%; margin-top: 10px">
            <a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" runat="server" href="#">
                <div class="sidebar-brand-icon">
                    <img src="\asset\img\hrms_icon.jpg" class="rounded-circle" style="width: 36px; height: 34px; object-fit: cover;">
                </div>
                <div class="sidebar-brand-text ml-2 mt-1" style="line-height: 0.7;">
                    <span>HRMS.</span><br />
                    <span style="font-size: 10px; color: rgba(255,255,255,0.7)">My company</span>
                </div>
            </a>
        </div>
        <hr class="sidebar-divider my-2" style="color: rgba(255,255,255,0.7)">

        <div class="flex-grow-1 sidebar-nav mt-1" data-simplebar="">
            <ul class="navbar-nav text-light" id="accordionSidebar" runat="server">
                <li class="nav-item">
                    <a id="TeamsChatNavLink" class="nav-link" runat="server">
                        <i class="fas fa-comment-dots" style="font-size: 1.25rem;"></i>
                        <span>Teams Chat</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a id="MyPlannerNavLink" class="nav-link" runat="server">
                        <i class="fas fa-crosshairs" style="font-size: 1.25rem;"></i>
                        <span>My Planner</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a id="OutReachNavLink" class="nav-link" runat="server">
                        <i class="fas fa-newspaper" style="font-size: 1.25rem;"></i>
                        <span>OutReach</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a id="FormsModuleNavLink" class="nav-link" runat="server">
                        <i class="fas fa-file-alt" style="font-size: 1.25rem;"></i>
                        <span>Forms Module</span>
                    </a>
                </li>
                
                <li class="nav-item">
                    <a id="YammerNavLink" class="nav-link" runat="server">
                        <i class="fas fa-heart" style="font-size: 1.25rem;"></i>
                        <span>Yammer</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a id="DashboardNavLink" class="nav-link" href="../dashboard.aspx" runat="server">
                        <i class="fas fa-home" style="font-size: 1.25rem;"></i>
                        <span>Dashboard</span>
                    </a>
                </li>

                <li class="nav-item onlyhighaccesslvl">
                    <a id="AnnouncementsNavLink" class="nav-link" href="../announcements.aspx" runat="server">
                        <i class="fas fa-user-lock" style="font-size: 1.25rem;"></i>
                        <span>Announcements</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#leaveSubMenu" data-toggle="collapse" aria-expanded="false" aria-controls="leaveSubMenu">
                        <i class="fas fa-print" style="font-size: 1.25rem;"></i>
                        <span>Leave</span>
                    </a>
                    <div id="leaveSubMenu" runat="server" clientidmode="Static" class="collapse">
                        <ul class="navbar-nav text-light">
                            <li class="nav-item mt-2">
                                <a id="LeaveDashboardNavLink" class="nav-link" href="../leave_emp_dashboard.aspx" runat="server">
                                    <span>Dashboard</span>
                                </a>
                            </li>
                            <li class="nav-item onlyhighaccesslvl">
                                <a id="AllemployeeLeaveRequestNavLink" class="nav-link" href="../all_emp_leave_request.aspx" runat="server">
                                    <span>Leave Requests</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a id="myLeaveRequestsNavLink" class="nav-link" href="../my_leave_requests.aspx" runat="server">
                                    <span>My Leave Requests</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a id="leaveConfigurationNavLink" class="nav-link" href="../leave_configuration.aspx" runat="server">
                                    <span>Leave Configuration</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="nav-item">
                    <a id="HolidaysNavLink" class="nav-link" href="../holidays.aspx" runat="server">
                        <i class="fas fa-umbrella-beach" style="font-size: 1.25rem;"></i>
                        <span>holidays</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#HelpDeskSubMenu" data-toggle="collapse" aria-expanded="false" aria-controls="HelpDeskSubMenu">
                        <i class="fa-solid fa-headset" style="font-size: 1.25rem;"></i>
                        <span>Help Desk</span>
                    </a>
                    <div id="HelpDeskSubMenu" runat="server" clientidmode="Static" class="collapse">
                        <ul class="navbar-nav text-light">
                            <li class="nav-item mt-2">
                                <a id="ticketsNavLink" class="nav-link" href="../tickets.aspx" runat="server">
                                    <span>Tickets</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="nav-item">
                    <a id="configurationNavLink" class="nav-link" href="../configuration.aspx" runat="server">
                        <i class="fas fa-cog" style="font-size: 1.25rem;"></i>
                        <span>Configuration</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a id="PoliciesNavLink" class="nav-link" href="../policies.aspx" runat="server">
                        <i class="fa fa-thin fa-clipboard-list" style="font-size: 1.25rem;"></i>
                        <span>Policies</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a id="A1" class="nav-link" href="../testing.aspx" runat="server">
                        <i class="fa-solid fa-gamepad" style="font-size: 1.25rem;"></i>
                        <span>Testing</span>
                    </a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<script>
    $(document).ready(function () {
        var c = $("#emp_access_lvl").val();
        debugger
        if ($("#emp_access_lvl").val() != "true") {
            document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                element.style.display = 'none ';
            });
        }
    });

</script>
