<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Testing Page</title>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/searchpanes/2.1.2/js/dataTables.searchPanes.min.js"></script>
    <script src="https://cdn.datatables.net/select/1.6.2/js/dataTables.select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    <style>
        .main-container {
            display: flex;
            min-height: 100vh;
            transition: all 0.3s ease-in-out;
        }

        .left-navbar {
            width: 15%;
        }

            .left-navbar.toggled {
                width: 70px;
            }

        .content-container {
            flex-grow: 1;
            margin-left: 0;
            transition: margin-left 0.3s ease;
        }

        .dropdown-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }

        .dropdown-row {
            display: flex;
            justify-content: space-between;
            width: 100%;
            max-width: 800px;
        }

        .dropdown {
            flex: 1;
            margin: 0 10px;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Left Navbar -->
        <div id="sidebarContainer" class="left-navbar">
            <uc:LeftNavBar runat="server" />
        </div>

        <!-- Content Area -->
        <div id="content-container" class="content-container">
            <div id="banner_container" style="position: relative; z-index: 1050;">
                <div id="ad-banner" class="w-100 position-relative"
                    style="background-color: hsl(8, 77%, 56%); height: 40px; opacity: 1; transition: opacity 0.5s ease, height 0.5s ease; overflow: hidden;">
                    <div class="d-flex h-100 justify-content-center align-items-center gap-4">
                        <p class="text-white mb-0 mr-3">
                            Having any issues, feedback, or suggestions? We’d love to hear from you!
                       
                        </p>
                        <a class="btn btn-outline contact-now-btn" href="https://www.horilla.com/customer-feedback/" target="_blank"
                            style="font-size: 12px; padding: 0.4rem 0.6rem; border-radius: 10px; color: #E8E8E8; background-color: #e54f38; border: 2px solid #E8E8E8">Contact Now</a>
                    </div>
                    <div class="btn btn-outline" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%);">
                        <button class="d-flex justify-content-center align-items-center"
                            style="outline: none; border-radius: 50%; background-color: transparent; color: #fff; width: 34px; height: 34px; border: none; box-shadow: none;"
                            onclick="document.getElementById('banner_container').style.display = 'none';">
                            <i class="fa-light fa-x" style="cursor: pointer; font-size: 14px"></i>
                        </button>
                    </div>
                </div>
            </div>
            <!-- Header Navbar -->
            <div class="header-container">
                <uc:HeaderNavBar runat="server" />
            </div>
            <!-- Main Page Content -->
            <div class="dropdown-card">
                <div class="dropdown-row">
                    <div class="nav-item">
                        <button onclick="toggleSidebar()" class="btn btn-sm btn-success">Toggle Sidebar</button>
                    </div>
                    <select class="dropdown form-control">
                        <option>Select Option 1</option>
                        <option>Option 1.1</option>
                        <option>Option 1.2</option>
                    </select>
                    <select class="dropdown form-control">
                        <option>Select Option 2</option>
                        <option>Option 2.1</option>
                        <option>Option 2.2</option>
                    </select>
                    <select class="dropdown form-control">
                        <option>Select Option 3</option>
                        <option>Option 3.1</option>
                        <option>Option 3.2</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Sidebar toggle functionality
        function toggleSidebar() {
            sidebarToggle();
        }

        function sidebarToggle() {
            var isToggled = false;
            $("#sidebarContainer").toggleClass("toggled");
            $(".sidebar").toggleClass("toggled");
            isToggled = !isToggled;
            if (isToggled) {
                $("#leaveSubMenu").collapse('hide');
            } else {
                $("#leaveSubMenu").collapse('show');
            }
            document.cookie = "toggle=" + (isToggled ? "1" : "0") + "; path=/";
        }
    </script>
</body>
</html>
