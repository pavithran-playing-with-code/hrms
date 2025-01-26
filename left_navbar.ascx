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

<nav id="left-navbar" class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-primary p-0">
    <div class="container-fluid d-flex flex-column p-0" style="background-color: hsl(0,0%,13%); height: 100%;">
        <div class="flex-shrink-0" style="margin-left: -20%; margin-top: 10px">
            <a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" id="mom_redirect_url" runat="server" href="#">
                <div class="sidebar-brand-icon">
                    <img src="\asset\hrms_icon.jpg" class="rounded-circle" style="width: 36px; height: 34px; object-fit: cover;">
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
                    <a class="nav-link" href="../dashboard.aspx" id="dashboard_left_nav" runat="server">
                        <i class="fas fa-home" style="font-size: 1.25rem;"></i>
                        <span>Dashboard</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="../announcements.aspx" id="announcements_left_nav" runat="server">
                        <i class="fas fa-user-lock" style="font-size: 1.25rem;"></i>
                        <span>Announcements</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="../assessment_form.aspx" id="assessmentFormNavLink" runat="server">
                        <i class="fab fa-wpforms" style="font-size: 1.25rem;"></i>
                        <span>Assessment Form</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#leaveSubMenu" data-toggle="collapse" aria-expanded="false" aria-controls="leaveSubMenu">
                        <i class="fas fa-print" style="font-size: 1.25rem;"></i>
                        <span>Leave</span>
                    </a>
                    <div id="leaveSubMenu" runat="server" clientidmode="Static" class="collapse">
                        <ul class="navbar-nav text-light">
                            <li class="nav-item">
                                <a id="ltestNavLink" class="nav-link" href="../ltest.aspx" runat="server">
                                    <span>Dashboard</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a id="testingNavLink" class="nav-link" href="../sdv.aspx" runat="server">
                                    <span>Leave Requests</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a id="myLeaveRequestsNavLink" class="nav-link" href="../my_leave_requests.aspx" runat="server">
                                    <span>My Leave Requests</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a id="leaveTypeNavLink" class="nav-link" href="../leave-type.aspx" runat="server">
                                    <span>Leave Type</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="../testing.aspx" id="A1" runat="server">
                        <i class="fa-solid fa-gamepad" style="font-size: 1.25rem;"></i>
                        <span>Testing</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="../configuration.aspx" id="configurationNavLink" runat="server">
                        <i class="fas fa-cog" style="font-size: 1.25rem;"></i>
                        <span>Configuration</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
