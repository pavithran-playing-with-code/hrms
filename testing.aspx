<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Leave Dashboard</title>

  
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
            flex-shrink: 0;
            transition: all 0.3s ease-in-out;
        }

            .left-navbar.toggled {
                width: 70px;
            }

        .content-container {
            flex-grow: 1;
            margin-left: 0;
            overflow: auto;
            transition: margin-left 0.3s ease;
        }

        .wrapper {
            overflow: auto;
            margin-left: 20px;
            margin-right: 20px;
        }

        #Quickaction-container {
            position: absolute;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
            cursor: pointer;
        }

        * {
            scrollbar-width: thin;
        }

        .hovercards:hover {
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            transform: scale(1.05);
            transition: all 0.3s ease-in-out;
        }

        .btn-outline-custom {
            color: hsl(8, 77%, 56%);
            border: 1px solid hsl(8, 77%, 56%);
            background-color: transparent;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out;
        }

            .btn-outline-custom:hover {
                color: #fff;
                background-color: hsl(8, 77%, 56%);
                border-color: hsl(8, 77%, 56%);
            }

        .modal.fade .modal-dialog {
            transform: translate(0, 100%);
            transition: transform .3s ease-out;
        }

        .modal.show .modal-dialog {
            transform: translate(0, 0);
        }

        #commentInput, #successAlert {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 10px;
        }

        .contact-now-btn {
            text-decoration: none;
            position: relative;
        }

            .contact-now-btn::after {
                content: "";
                position: absolute;
                bottom: 8px;
                left: 9px;
                height: 1px;
                background-color: #E8E8E8;
                transition: width 0.3s ease;
            }

            .contact-now-btn:hover::after {
                width: 80%;
            }

        @keyframes slideInFromRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }

            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .alert-custom {
            animation: slideInFromRight 0.5s ease-out;
        }


        #greenAlert {
            display: none;
            position: fixed;
            top: 60px;
            right: 20px;
            z-index: 1050;
            width: 500px;
            height: 60px;
            border-left: 5px solid #28a745;
            padding-left: 15px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 0;
            opacity: 0;
            transition: opacity 2s ease-in-out;
        }

        #addAnnouncement:focus {
            outline: none;
            box-shadow: none;
        }

        .createannouncementfields .form-control,
        .createannouncementfields select,
        .createannouncementfields textarea,
        .createannouncementfields input[type="file"],
        .createannouncementfields button {
            border-radius: 0 !important;
        }

        .form-group {
            flex: 1;
            min-width: 150px;
        }

        .select2-container--default .select2-selection--multiple {
            height: 38px !important;
            border: 1px solid #ced4da;
            border-radius: 0;
            padding: 6px 12px;
            display: flex;
            align-items: center;
            overflow: hidden;
            flex-wrap: nowrap;
        }

            .select2-container--default .select2-selection--multiple .select2-selection__rendered {
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                overflow-x: hidden;
                white-space: nowrap;
                width: 100%;
            }

            .select2-container--default .select2-selection--multiple .select2-selection__choice {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: gray !important;
            color: white !important;
        }

        .attachment-link {
            color: #007bff;
            text-decoration: none;
        }

            .attachment-link:hover {
                text-decoration: underline;
            }

        .dropdown-menu {
            font-size: 15px;
            position: absolute !important;
            top: 0px !important;
            left: -100px !important;
        }
    </style>

</head>
<body style="background-color: #f8f9fa">
    <div id="greenAlert" style="display: none; align-items: center;" class="alert alert-success alert-dismissible fade alert-custom" role="alert">
        <strong><i class="fa-sharp fa-solid fa-circle-exclamation ml-1 mr-3"></i></strong><span id="greenAlertmessage"></span>
    </div>
    <input type="hidden" id="emp_access_lvl" name="emp_access_lvl" runat="server" />

    <div class="main-container">
        <div id="sidebarContainer" class="left-navbar">
            <uc:LeftNavBar runat="server" />
        </div>
        <div id="content-container" class="content-container">
            <div id="banner_container" style="position: relative; z-index: 1050;">
                <div id="ad-banner" class="w-100 position-relative"
                    style="background-color: hsl(8, 77%, 56%); height: 40px; opacity: 1; transition: opacity 0.5s ease, height 0.5s ease; overflow: hidden;">
                    <div class="d-flex h-100 justify-content-center align-items-center gap-4">
                        <p class="text-white mb-0 mr-3">Having any issues, feedback, or suggestions? We’d love to hear from you!</p>
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
            <div class="header-container">
                <uc:HeaderNavBar runat="server" />
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 35px; margin-top: 30px; margin-right: 65px">
                    <div class="row" id="dashboard" style="padding-bottom: 4.5rem;">
                        <div class="dashboard__left col-12 col-sm-12 col-md-12 col-lg-9">
                            <div class="row">
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
                            <div class="card p-3 mb-4">
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
                                    <div class="announcement-body" id="announcementListCard" style="height: 300px; overflow-y: auto; border: none;"></div>
                                </div>
                            </div>
                            <div class="card p-3 mb-3">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px">
                                    <h6 class="card-title">On Leave</h6>
                                </div>
                                <hr />
                                <div class="card-body">
                                    <div class="onleave-body" id="onleaveListCard" style="height: 300px; border: none;">
                                        <div id="empty_leave" style="padding-top: 20%">
                                            <div class="empty_message">
                                                <img style="display: block; width: 70px; margin: 20px auto;" src="\asset\img\attendance.png" />
                                                <h5 style="color: hsl(0,0%,45%); text-align: center;">No employees have taken leave today.</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="Quickaction-container">
                            <uc:Quick_action runat="server" />
                        </div>
                        <%-- createannouncementmodal --%>
                        <div class="modal fade pt-5" id="createannouncementmodal" tabindex="-1" aria-labelledby="createannouncementmodalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg mx-auto" style="max-width: 41%; margin: 0 auto;">
                                <div class="modal-content" style="border-radius: 0px !important; width: 100%;">
                                    <div class="modal-header" style="padding: 1.50rem 1.70rem 1rem; height: 30px; background-color: transparent; border-bottom: none;">
                                        <h2 class="modal-title" id="createannouncementmodalLabel" style="font: normal 80%/1.4 sans-serif; font-size: 1.10rem; font-weight: 600; color: #4f4a4a;"></h2>
                                        <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body createannouncementfields">
                                        <div class="mx-2 mb-2" style="color: hsl(0, 0%, 11%); font-weight: 500; background-color: hsl(0,0%,100%); border: 1px solid hsl(213,22%,84%); padding: 1.2rem;">
                                            <div class="form-group">
                                                <label for="id_title">Title:</label>
                                                <input type="text" name="title" class="form-control" id="id_title" placeholder="Title" maxlength="100" />
                                            </div>
                                            <div class="form-group">
                                                <label for="id_description">Description:</label>
                                                <textarea id="id_description" class="form-control"></textarea>
                                            </div>
                                            <div class="form-group d-flex flex-column">
                                                <div class="d-flex align-items-center">
                                                    <label for="id_attachments" class="mr-2">Attachments:</label>
                                                    <input type="file" name="attachments" class="attachment_file" id="id_attachments" />
                                                </div>
                                                <div class="d-flex align-items-center row ml-1">
                                                    <div id="id_attachments_helper">
                                                        <input type="text" id="id_attachments_helper_value" hidden="hidden" />
                                                    </div>
                                                    <button type="button" style="width: 17%; position: relative; left: 16%; outline: none; background-color: #f6f6f6; border: 1px solid #000; color: #000; cursor: pointer; font-size: 14px; display: none;"
                                                        class="btn btn-danger btn-sm mt-2" id="remove_attachment_btn">
                                                        Remove
                                                    </button>
                                                </div>

                                            </div>

                                            <div class="form-group">
                                                <label for="id_expire_date">Expire Date:</label>
                                                <input type="date" name="expire_date" class="form-control" id="id_expire_date" />
                                            </div>
                                            <div class="form-group">
                                                <label for="id_department">Department:</label>
                                                <select name="department" class="form-control select2" id="id_department" multiple="multiple"></select>
                                            </div>
                                            <div class="form-group">
                                                <label for="id_job_position">Job Position:</label>
                                                <select name="job_position" class="form-control select2" id="id_job_position" multiple="multiple"></select>
                                            </div>
                                            <div class="form-group">
                                                <label for="id_employees">Employees:</label>
                                                <select name="employees" class="form-control select2" id="id_employees" multiple="multiple"></select>
                                            </div>
                                            <div class="form-group d-flex align-items-center">
                                                <label class="mr-3">Notify:</label>
                                                <div class="custom-control custom-switch mr-3">
                                                    <input type="checkbox" class="custom-control-input" id="toggle_notify_email" />
                                                    <label class="custom-control-label" for="toggle_notify_email">Email</label>
                                                </div>
                                                <div class="custom-control custom-switch">
                                                    <input type="checkbox" class="custom-control-input" id="toggle_notify_phone" />
                                                    <label class="custom-control-label" for="toggle_notify_phone">Phone</label>
                                                </div>

                                                <div class="ml-auto" style="padding-right: 20px;">
                                                    <label for="id_disable_comments" class="form-check-label">Disable Comments:</label>
                                                    <input type="checkbox" name="disable_comments" class="form-check-input ml-2 mt-2" id="id_disable_comments" />
                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <button onclick="publish_edit_save_announcement('publish')" id="publishannouncementbtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Publish</button>
                                                <button onclick="publish_edit_save_announcement('edit')" id="editannouncementbtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Edit</button>
                                                <button onclick="publish_edit_save_announcement('save')" class="btn btn-primary ml-2" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Save</button>
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

    <%--  <script>
        $(document).ready(function () {
            var today = new Date();
            const currentMonth = today.getMonth() + 1;
            const currentYear = today.getFullYear();

            $('#monthPicker_for_emp_leaves').val(`${currentYear}-${String(currentMonth).padStart(2, '0')}`);
            $('#monthPicker_for_department_leaves').val(`${currentYear}-${String(currentMonth).padStart(2, '0')}`);
            $('#monthPicker_for_leave_types_leaves').val(`${currentYear}-${String(currentMonth).padStart(2, '0')}`);

            populate_leave_details();
            nextHolidays(today.getMonth(), today.getFullYear());
            populate_on_leaves();
            populate_leaves_based_months("leave_admin_dashboard", currentMonth, currentYear);
            HolidaysThisMonths();
            populate_department_leaves(currentMonth, currentYear);
            populate_leave_types(currentMonth, currentYear);

        });

        $('#monthPicker_for_emp_leaves').on('change', function () {
            const selectedDate = $(this).val().split('-');
            const selectedYear = selectedDate[0];
            const selectedMonth = selectedDate[1];
            populate_leaves_based_months("leave_admin_dashboard", selectedMonth, selectedYear);
        });

        $('#monthPicker_for_department_leaves').on('change', function () {
            const selectedDate = $(this).val().split('-');
            const selectedYear = selectedDate[0];
            const selectedMonth = selectedDate[1];
            populate_department_leaves(selectedMonth, selectedYear);
        });

        $('#monthPicker_for_leave_types_leaves').on('change', function () {
            const selectedDate = $(this).val().split('-');
            const selectedYear = selectedDate[0];
            const selectedMonth = selectedDate[1];
            populate_leave_types(selectedMonth, selectedYear);
        });

        function populate_leave_details() {
            $.ajax({
                type: "POST",
                url: 'leave_emp_dashboard.aspx/populate_leave_details',
                data: JSON.stringify({ from: "leave_admin_dashboard" }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    const data = JSON.parse(response.d);

                    $("#total_leave_request").text(data.total_leave_request || 0);
                    $("#approved_leave_request").text(data.approved_leave_request || 0);
                    $("#rejected_leave_request").text(data.rejected_leave_request || 0);
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        title: "Error!",
                        text: `An error occurred: ${error}. Response: ${xhr.responseText}`,
                        icon: "error"
                    });
                }
            });
        }

        $('.leave-summary-card').on('click', function () {
            let status = $(this).data('status');
            $('#modalTitle').text(status + ' Leaves');
            loadLeaveData(status);
            $('#leaveModal').modal('show');
        });

        function loadLeaveData(status) {
            let postData = JSON.stringify({
                from: "leave_admin_dashboard_total_leave_request",
                selectedMonth: new Date().getMonth() + 1,
                selectedYear: new Date().getFullYear()
            });

            $.ajax({
                type: "POST",
                url: 'leave_emp_dashboard.aspx/populate_leaves_based_months',
                contentType: 'application/json',
                data: postData,
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    const parseDate = (dateString) => {
                        const dateParts = dateString.split(' ')[0].split('-');
                        let day, month, year;

                        if (parseInt(dateParts[0], 10) > 12) {
                            day = parseInt(dateParts[0], 10);
                            month = parseInt(dateParts[1], 10) - 1;
                            year = parseInt(dateParts[2], 10);
                        } else {
                            month = parseInt(dateParts[0], 10) - 1;
                            day = parseInt(dateParts[1], 10);
                            year = parseInt(dateParts[2], 10);
                        }

                        return new Date(year, month, day);
                    };

                    const currentMonth = new Date().getMonth() + 1;
                    const currentYear = new Date().getFullYear();

                    const filteredData = (Array.isArray(data) && data.length > 0)
                        ? data.filter(item => {
                            if (!item.start_date || !item.end_date) return false;

                            const startDate = parseDate(item.start_date);
                            const endDate = parseDate(item.end_date);

                            const isInCurrentMonth = (
                                (startDate.getFullYear() === currentYear && startDate.getMonth() + 1 === currentMonth) ||
                                (endDate.getFullYear() === currentYear && endDate.getMonth() + 1 === currentMonth) ||
                                (startDate < new Date(currentYear, currentMonth - 1, 1) && endDate > new Date(currentYear, currentMonth, 0))
                            );

                            if (status === "Request to Approve") {
                                return item.leave_status !== "Approved" && item.leave_status !== "Rejected";
                            } else if (status === "Approved") {
                                return item.leave_status === "Approved" && isInCurrentMonth;
                            } else if (status === "Rejected") {
                                return item.leave_status === "Rejected" && isInCurrentMonth;
                            }
                            return false;
                        })
                        : data;

                    if ($.fn.DataTable.isDataTable('#modaltable')) {
                        $('#modaltable').DataTable().destroy();
                    }

                    $('#modaltable').DataTable({
                        data: filteredData,
                        scrollX: true,
                        scrollCollapse: true,
                        fixedColumns: {
                            rightColumns: 1
                        },
                        columns: [
                            { data: 'leave_id' },
                            { data: 'emp_name' },
                            { data: 'leave_type' },
                            {
                                data: 'start_date',
                                render: function (data) {
                                    const dateParts = data.split(' ')[0].split('-');
                                    const formattedDate = `${dateParts[1]}-${dateParts[0]}-${dateParts[2]}`;
                                    return `<span>${formattedDate}</span>`;
                                }
                            },
                            {
                                data: 'end_date',
                                render: function (data) {
                                    const dateParts = data.split(' ')[0].split('-');
                                    const formattedDate = `${dateParts[1]}-${dateParts[0]}-${dateParts[2]}`;
                                    return `<span>${formattedDate}</span>`;
                                }
                            },
                            {
                                data: 'requested_days',
                                render: function (data) {
                                    return `<span> ${data}<span />`;
                                }
                            },
                            {
                                data: 'leave_status',
                                render: function (data) {
                                    if (!data) {
                                        return `<span style="color: #077E8C;font-weight: bold;">Pending</span>`;
                                    } else if (data == "Canceled") {
                                        return `<span style="color: #FF6F61;font-weight: bold;">Canceled</span>`;
                                    }
                                    return data === "Approved"
                                        ? `<span style="color: green;font-weight: bold;">Approved</span>`
                                        : `<span style="color: red;font-weight: bold;">Rejected</span>`;
                                }
                            }
                        ],
                        headerCallback: function (thead, data, start, end, display) {
                            $('th', thead).addClass('text-center');
                        },
                        createdRow: function (row, data, dataIndex) {
                            $('td', row).addClass('text-center');
                        },
                        language: {
                            emptyTable: `<div style="text-align: center;">
       <img src="/asset/img/no-leave-requests.png" alt="No data available" style="max-width: 130px; margin-top: 70px; margin-bottom: 30px">
       <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
    </div>`
                        }
                    });

                    $('#modaltable').DataTable().columns.adjust().draw();
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        title: "Error!",
                        text: `An error occurred: ${error}. Response: ${xhr.responseText}`,
                        icon: "error"
                    });
                }
            });
        }

        function nextHolidays(month, year) {
            $.ajax({
                type: "POST",
                url: "holidays.aspx/GetHolidays",
                data: JSON.stringify({ month: month + 1, year: year }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var holidayData = response.d ? JSON.parse(response.d) : {};
                    var currentDate = new Date();
                    var nextHoliday = null;
                    var nextHolidayName = "";

                    Object.keys(holidayData).forEach(dateStr => {
                        var holidayDate = new Date(dateStr);
                        if (holidayDate >= currentDate) {
                            if (!nextHoliday || holidayDate < nextHoliday) {
                                nextHoliday = holidayDate;
                                nextHolidayName = holidayData[dateStr];
                            }
                        }
                    });

                    if (nextHoliday) {
                        $("#next_holiday").text(nextHolidayName);
                        $("#next_holiday_date").text(nextHoliday.toLocaleDateString('en-GB'));
                    } else {
                        $("#next_holiday").text("No Upcoming Holiday");
                        $("#next_holiday_date").text("-");
                    }
                },
                error: function () {
                    console.error("Error fetching holiday data.");
                }
            });
        }

        function populate_on_leaves() {
            let postData = JSON.stringify({
                from: "leave_admin_dashboard",
                selectedMonth: new Date().getMonth() + 1,
                selectedYear: new Date().getFullYear()
            });

            $.ajax({
                type: "POST",
                url: 'leave_emp_dashboard.aspx/populate_leaves_based_months',
                contentType: 'application/json',
                data: postData,
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    let HTML = "";
                    if (Array.isArray(data) && data.length > 0) {
                        data.forEach(emp => {
                            $("#onleave").css({
                                "display": "flex",
                                "flex-direction": "column",
                                "align-items": "center",
                                "justify-content": "flex-start"
                            });

                            HTML += emp.profile_img
                                ? `<div class="mb-3 mr-2 d-flex align-items-start w-75">
                                       <span class="rounded-circle d-inline-flex justify-content-center align-items-center mt-1" 
                                           style="flex-shrink: 0; width: 40px; height: 40px; overflow: hidden;">
                                           <img src="${emp.profile_img}" alt="Profile Image" style="width: 100%; height: 100%; border-radius: 50%;">
                                       </span>
                                       <div style="margin-left: 10px;">
                                           <div style="font-weight: bold; font-size: 1rem; white-space: nowrap">${emp.emp_name}</div>
                                           <div style="font-size: 0.9rem; color: #4d4a4a; white-space: nowrap">${emp.department_name} / ${emp.job_position_name}</div>
                                           <div style="font-size: 0.8rem; color: #dc3545; white-space: nowrap">${emp.leave_type}</div>
                                           <div style="font-size: 0.8rem; color: #dc3545; white-space: nowrap">(${emp.start_date} to ${emp.end_date})</div>
                                       </div>
                                   </div>`
                                : `<div class="mb-3 mr-2 d-flex align-items-start w-75">
                                       <span class="rounded-circle d-inline-flex justify-content-center align-items-center mt-1"
                                           style="flex-shrink: 0; width: 40px; height: 40px; background-color: ${emp.profile_color}; color: white; font-weight: bold; font-size: 1rem;">
                                           ${emp.profile_letters}
                                       </span>
                                       <div style="margin-left: 10px;">
                                           <div style="font-weight: bold; font-size: 1rem; white-space: nowrap">${emp.emp_name}</div>
                                           <div style="font-size: 0.9rem; color: #4d4a4a; white-space: nowrap">${emp.department_name} / ${emp.job_position_name}</div>
                                           <div style="font-size: 0.8rem; color: #dc3545; white-space: nowrap">${emp.leave_type}</div>
                                           <div style="font-size: 0.8rem; color: #dc3545; white-space: nowrap">(${emp.start_date} to ${emp.end_date})</div>
                                       </div>
                                   </div>`;
                        });
                    } else {
                        $("#onleave").css({
                            "display": "flex",
                            "align-items": "center",
                            "justify-content": "center"
                        });

                        HTML = `<div class="empty_message text-center">
                                    <img style="display: block; width: 70px; margin: 20px auto;" src="/asset/img/attendance.png" />
                                    <h5 style="color: hsl(0,0%,45%);">No employees have taken leave today.</h5>
                                </div>`;
                    }

                    $("#onleave").html(HTML);
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        title: "Error!",
                        text: `An error occurred: ${error}. Response: ${xhr.responseText}`,
                        icon: "error"
                    });
                }
            });
        }

        function populate_leaves_based_months(from, selectedMonth, selectedYear) {
            $.ajax({
                type: "POST",
                url: 'leave_emp_dashboard.aspx/populate_leaves_based_months',
                data: JSON.stringify({ from: from, selectedMonth: selectedMonth, selectedYear: selectedYear }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    if (response.d.includes("ExceptionMessage")) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: response.d,
                            confirmButtonText: 'Ok'
                        });
                        return;
                    }
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    if ($.fn.DataTable.isDataTable('#LeavesTable')) {
                        $('#LeavesTable').DataTable().clear().destroy();
                    }

                    $('#LeavesTable').DataTable({
                        data: data,
                        scrollX: true,
                        scrollCollapse: true,
                        fixedColumns: {
                            rightColumns: 1
                        },
                        columns: [
                            { data: 'leave_id', visible: false },
                            { data: 'emp_name' },
                            { data: 'leave_type' },
                            {
                                data: 'start_date',
                                render: function (data) {
                                    const dateParts = data.split(' ')[0].split('-');
                                    const start_date = `${dateParts[1]}-${dateParts[0]}-${dateParts[2]}`;
                                    return `<span>${start_date}</span>`;
                                }
                            },
                            {
                                data: 'end_date',
                                render: function (data) {
                                    const dateParts = data.split(' ')[0].split('-');
                                    const end_date = `${dateParts[1]}-${dateParts[0]}-${dateParts[2]}`;
                                    return `<span>${end_date}</span>`;
                                }
                            },
                            {
                                data: 'requested_days',
                                render: function (data) {
                                    return `<span> ${data}<span />`;
                                }
                            },
                            {
                                data: 'leave_status',
                                render: function (data) {
                                    if (!data) {
                                        return `<span style="color: #077E8C;font-weight: bold;">Pending</span>`;
                                    }
                                    else if (data == "Canceled") {
                                        return `<span style="color: #FF6F61;font-weight: bold;">Canceled</span>`;
                                    }
                                    return data === "Approved"
                                        ? `<span style="color: green;font-weight: bold;">Approved</span>`
                                        : `<span style="color: red;font-weight: bold;">Rejected</span>`;
                                }
                            }
                        ],
                        headerCallback: function (thead, data, start, end, display) {
                            $('th', thead).addClass('text-center');
                        },
                        createdRow: function (row, data, dataIndex) {
                            $('td', row).addClass('text-center');
                        },
                        language: {
                            emptyTable: `<div style="text-align: center;">
   <img src="/asset/img/no-leave-requests.png" alt="No data available" style="max-width: 130px; margin-top: 70px; margin-bottom: 30px">
   <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
</div>`
                        }
                    });

                    $('#LeavesTable').on('click', '.description-link', function (e) {
                        e.preventDefault();
                        const description = $(this).data('description');
                        const heading = $(this).closest('tr').find('td').eq(1).text();
                        $('#descriptionModalLabel').text(heading);
                        $('#fullDescriptionContent').html(description);
                        $('#descriptionModal').modal('show');
                    });

                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        title: "Error!",
                        text: `An error occurred: ${error}. Response: ${xhr.responseText}`,
                        icon: "error"
                    });
                }
            });
        }

        $('#LeavesTable').on('click', 'td', function () {
            const table = $('#LeavesTable').DataTable();
            const rowData = table.row(this).data();
            if (!rowData) return;

            const rows = table.rows().data().toArray();
            let carouselItems = '';

            rows.forEach((data, index) => {
                const activeClass = data.leave_id === rowData.leave_id ? 'active' : '';

                carouselItems += `
        <div class="carousel-item ${activeClass}">
            <div class="modal-header ml-3 mt-2" style="border:none; justify-content: center">
                <h5 class="modal-title">Details</h5> 
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                 <div class="leave_details" style="margin-left:12%; display: flex; flex-direction: column; align-items: flex-start; text-align: left; width: 100%;">
                    <div class="row" style="width: 100%; justify-content: flex-start;">
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Create By:</span><br />
                            <span style="font-size: 1rem;">${data.emp_name}</span>
                        </div>
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Create Time:</span><br /> 
                            <span style="font-size: 1rem;">${data.created_time}</span>
                        </div>
                    </div>
                    <div class="row" style="width: 100%; justify-content: flex-start;">
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Leave Type:</span><br />
                            <span style="font-size: 1rem;">${data.leave_type}</span>
                        </div>
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Requested Days:</span><br /> 
                            <span style="font-size: 1rem;">${data.requested_days}</span>
                        </div>
                    </div>
                    <div class="row" style="width: 100%; justify-content: flex-start;">
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Start Date:</span><br /> 
                            <span style="font-size: 1rem;">${data.start_date}</span>
                        </div>
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Start Date Breakdown:</span><br /> 
                            <span style="font-size: 1rem;">${data.start_date_breakdown}</span>
                        </div>
                    </div>
                    <div class="row" style="width: 100%; justify-content: flex-start;">
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">End Date:</span><br /> 
                            <span style="font-size: 1rem;">${data.end_date}</span>
                        </div>
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">End Date Breakdown:</span><br /> 
                            <span style="font-size: 1rem;">${data.end_date_breakdown}</span>
                        </div>
                    </div>
                    <div class="mt-3 ml-4 mb-3" style="text-align: center;">
                        <button class="btn btn-link description-link" data-description="${data.leave_description}" data-leave-type="${data.leave_type}">
                            View Description
                        </button>
                        <button class="btn btn-link attachment-link" onclick="window.open('${data.attachment}', '_blank')">
                            View Attachment
                        </button>
                    </div>
                </div>
            </div>
        </div>`;
            });

            $('#carouselContent').html(carouselItems);
            $('#detailsModal').modal('show');
        });

        function HolidaysThisMonths() {
            $.ajax({
                type: "POST",
                url: "leave_emp_dashboard.aspx/HolidaysThisMonths",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var holidayData = response.d ? JSON.parse(response.d) : {};
                    var holidaysHTML = "";

                    if (Object.keys(holidayData).length > 0) {
                        Object.keys(holidayData).forEach(date => {
                            holidaysHTML += `
                <div class="holiday-row pb-3 d-flex align-items-center justify-content-start rounded mb-2 shadow-sm" 
                     style="background-color: #fff; padding: 10px; box-shadow: 5px 5px 10px rgba(0, 0, 0, 1);">
                   <i class="fas fa-calendar-day text-primary mr-3" style="font-size: 1.5rem;"></i>
                    <div class="holiday-title">
                        <span class="profile-name font-weight-bold text-dark" style="font-size: 1rem;">
                            ${date} <br /> 
                            <span class="text-success" style="font-size: 1.1rem;">${holidayData[date]}</span>
                        </span>
                    </div>
                </div>`;
                        });
                    } else {
                        holidaysHTML = `
            <div id="empty_holiday" class="d-flex flex-column align-items-center justify-content-center text-center" 
                 style="height: 100%;">
                <img style="display: block; width: 100px; margin: 20px auto;" src="/asset/img/no-holidays.png" />
                <h5 style="color: hsl(0,0%,45%); font-weight: bold;">No more holidays scheduled for this month.</h5>
            </div>`;
                    }

                    $("#holidayListCard").html(holidaysHTML);
                },
                error: function () {
                    console.error("Error fetching holiday data.");
                }
            });
        }

        function populate_department_leaves(selectedMonth, selectedYear) {
            $.ajax({
                type: "POST",
                url: 'leave_admin_dashboard.aspx/populate_leaves_details_based_months',
                data: JSON.stringify({ from: "department_leaves", selectedMonth: selectedMonth, selectedYear: selectedYear }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    const data = JSON.parse(response.d);
                    const departmentLeaves = data.departmentLeaves || [];

                    let departmentMap = {};
                    departmentLeaves.forEach(item => {
                        if (!departmentMap[item.department_name]) {
                            departmentMap[item.department_name] = [];
                        }
                        departmentMap[item.department_name].push(item);
                    });

                    let html = "";
                    if (Object.keys(departmentMap).length > 0) {
                        html += `<div class="accordion" id="departmentAccordion">`;

                        Object.keys(departmentMap).forEach((dept, index) => {
                            let employees = departmentMap[dept].filter(emp => emp.leave_status === "Approved");
                            let employeeCount = employees.length;
                            let employeeLabel = employeeCount === 1 ? "Employee" : "Employees";

                            let employeesHtml = employeeCount > 0
                                ? employees.map(emp => `
                            <div class="leave-entry" style="margin-bottom: 10px;">
                                <div class="leave-header" style="display: flex; align-items: start;">
                                    <strong>${emp.emp_name} -</strong>
                                    <div class="leave-details" style="display: flex; flex-direction: column; margin-left: 10px;">
                                        <div>Leave type: ${emp.leave_type}</div>
                                        <div>From: ${emp.start_date} (${emp.start_date_breakdown})</div>
                                        <div>To: ${emp.end_date} (${emp.end_date_breakdown})</div>
                                    </div>
                                </div>
                            </div>
                        `).join("")
                                : `<p>No employees are on leave.</p>`;

                            html += `
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="heading${index}">
                                <button class="accordion-button collapsed custom-accordion-button" type="button" 
                                        data-bs-toggle="collapse" data-bs-target="#collapse${index}" 
                                        aria-expanded="false" aria-controls="collapse${index}">
                                    ${dept} (${employeeCount} ${employeeLabel})
                                </button>
                            </h2>
                            <div id="collapse${index}" class="accordion-collapse collapse" 
                                 aria-labelledby="heading${index}" data-bs-parent="#departmentAccordion">
                                <div class="accordion-body">
                                    ${employeesHtml}
                                </div>
                            </div>
                        </div>`;
                        });

                        html += `</div>`;
                    } else {
                        html = "<p>No department leaves found for this month.</p>";
                    }

                    $("#department_leaves").html(html);
                },
                error: function (error) {
                    console.error("Error fetching department leaves:", error);
                }
            });
        }

        function populate_leave_types(selectedMonth, selectedYear) {
            $.ajax({
                type: "POST",
                url: 'leave_admin_dashboard.aspx/populate_leaves_details_based_months',
                data: JSON.stringify({ from: "leave_types", selectedMonth: selectedMonth, selectedYear: selectedYear }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    const data = JSON.parse(response.d);
                    const leaveTypeCounts = data.leaveTypeCounts || [];
                    let leaveCounts = {};

                    leaveTypeCounts.forEach(item => {
                        if (!leaveCounts[item.leave_type]) {
                            leaveCounts[item.leave_type] = 0;
                        }
                        leaveCounts[item.leave_type] += parseFloat(item.requested_days);
                    });

                    let html = "";
                    if (Object.keys(leaveCounts).length > 0) {
                        for (const [leaveType, count] of Object.entries(leaveCounts)) {
                            html += `<div class="leave-count">
                        <strong>${leaveType}</strong>: ${count} days
                    </div><hr>`;
                        }
                    } else {
                        html = "<p>No leave data found for this month.</p>";
                    }

                    $("#leave_types_leaves").html(html);
                },
                error: function (error) {
                    console.error("Error fetching leave types:", error);
                }
            });
        }

    </script>--%>
</body>

</html>


