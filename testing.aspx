<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
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
    <title>testing</title>
    <style>
        #wrapper {
            display: flex;
            grid-template-columns: 282.36px auto;
            flex-direction: row;
            height: 100%;
            overflow: hidden;
        }

        #content-wrapper {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
            overflow-y: auto;
            margin-left: 0;
        }
    </style>

</head>
<body id="page-top" class="vh-100">
    <input type="hidden" id="emp_id" runat="server" />
    <input type="hidden" id="redirect_mom" runat="server" />
    <div id="wrapper" class="vh-100">
        <div>
            <uc:LeftNavBar runat="server" ID="LeftNavBarControl" style="width: 282.36px;" />
        </div>
        <div class="d-flex flex-column vh-100" id="content-wrapper" style="flex-wrap: nowrap !important; overflow-y: hidden">
            <uc:HeaderNavBar runat="server" ID="HeaderNavBarControl" />
            <div class="flex-grow" data-simplebar="" style="min-height: 0">
                <div class="mt-3">
                    <div class="container-fluid">
                        <div class="row" id="dashboard" style="padding-bottom: 4.5rem;">
                            <div class="dashboard__left col-12 col-sm-12 col-md-12 col-lg-9">
                                <div class="row p-3">
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4">
                                        <div class="card hovercards">
                                            <div class="card-body" style="border-top: 5px solid hsl(148, 70%, 40%);">
                                                <h6 class="card-title">New Joining Today</h6>
                                                <h1 class="card-text" id="new_joining_today"></h1>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="card hovercards">
                                            <div class="card-body" style="border-top: 5px solid hsl(37,90%,47%);">
                                                <h6 class="card-title">New Joining This Week</h6>
                                                <h1 class="card-text" id="new_joining_this_week"></h1>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="card hovercards">
                                            <div class="card-body" style="border-top: 5px solid hsl(216,18%,64%);">
                                                <h6 class="card-title">Total Strength</h6>
                                                <h1 class="card-text" id="total_emp"></h1>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="dashboard__right col-12 col-sm-12 col-md-12 col-lg-3">
                                <div class="card p-3 mb-3 mt-3 mr-3">
                                    <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px">
                                        <h6 class="card-title">Announcements</h6>
                                        <span class="mb-1">
                                            <button id="addAnnouncement" style="display: inline-block; padding: 0px; border-radius: 6px; display: flex; align-items: center; justify-content: center; width: 50px; height: 28px;"
                                                class="btn btn-outline-custom ms-3 onlyhighaccesslvl" onclick="opencreateannouncementmodal()" title="Create Announcement">
                                                <i class="fa fa-plus m-0"></i>
                                            </button>
                                        </span>
                                    </div>
                                    <hr />
                                    <div class="card-body">
                                        <div class="announcement-body" id="announcementListCard" style="height: 300px; border: none;"></div>
                                    </div>
                                </div>
                                <div class="card p-3 mb-3 mt-3 mr-3">
                                    <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px">
                                        <h6 class="card-title">On Leave</h6>
                                    </div>
                                    <hr />
                                    <div class="card-body">
                                        <div class="onleave-body" id="onleaveListCard" style="height: 300px; border: none;">
                                            <div id="empty_leave" style="padding-top: 20%">
                                                <div class="empty_message">
                                                    <img style="display: block; width: 70px; margin: 20px auto;" src="\asset\attendance.png" />
                                                    <h5 style="color: hsl(0,0%,45%); text-align: center;">No employees have taken leave today.</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
