<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="testnavbar.ascx.cs" Inherits="hrms.testnavbar" %>

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
</style>

<nav id="left-navbar" class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-primary p-0">
    <div class="container-fluid d-flex flex-column p-0" style="background-color: #2f2f2f; height: 100%;">
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
        <hr class="sidebar-divider my-2">

        <div class="flex-grow-1 sidebar-nav mt-1" data-simplebar="">
            <ul class="navbar-nav text-light" id="accordionSidebar">
                <li class="nav-item">
                    <a class="nav-link" href="../tpm_dashboard.aspx" id="tpm_dashboard_left_nav" runat="server">
                        <i class="fas fa-home" style="font-size: 1.25rem;"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../admin_supervisor_view.aspx" id="supervisor_view_left_nav" runat="server">
                        <i class="fas fa-user-lock" style="font-size: 1.25rem;"></i>
                        <span>Announcements</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../assesment_form.aspx" id="assessment_form_left_navbar" runat="server">
                        <i class="fab fa-wpforms" style="font-size: 1.25rem;"></i>
                        <span>Assessment Form</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../assessment_print.aspx" id="assessment_print_left_nav" runat="server">
                        <i class="fas fa-print" style="font-size: 1.25rem;"></i>
                        <span>Leave</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../configuration.aspx" id="tpm_config_left_navbar" runat="server">
                        <i class="fas fa-cog" style="font-size: 1.25rem;"></i>
                        <span>Perrformance</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../assessment_configuration.aspx" id="assessment_config_left_nav" runat="server">
                        <i class="fas fa-cog" style="font-size: 1.25rem;"></i>
                        <span>Configuration</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" onclick="sidebarToggle()" runat="server">
                        <i class="fa fa-bars mr-2" id="toggleSidebar" onclick="sidebarToggle()"></i>
                        <span>toggle</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <script>
        function sidebarToggle() {
            var isToggled = false;
            $(".sidebar").toggleClass("toggled");
            isToggled = !isToggled;

            document.cookie = "toggle=" + (isToggled ? "1" : "0") + "; path=/";
        }
    </script>
</nav>
