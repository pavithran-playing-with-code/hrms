<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="all_emp_leave_request.aspx.cs" Inherits="hrms.all_emp_leave_request" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Employees Leave Requests</title>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedcolumns/4.2.2/css/fixedColumns.dataTables.min.css" />

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
    <script src="https://cdn.datatables.net/fixedcolumns/4.2.2/js/dataTables.fixedColumns.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

    <style>
        #Quickaction-container {
            position: absolute;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
        }

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

        .card-body {
            overflow-x: auto;
            padding: 0;
        }

        .table.table-striped.table-bordered th,
        .table.table-striped.table-bordered td {
            border-color: white !important;
        }

        .table.table-striped.table-bordered {
            border-color: white !important;
        }

        #LeavesTable th {
            white-space: nowrap;
        }

        #LeavesTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
        }

            #LeavesTable td button {
                margin-right: 5px;
                margin-bottom: 5px;
                white-space: nowrap;
            }

        #LeavesTable_length select {
            border: 1px solid #aaa;
            background-color: transparent;
            padding: 4px;
        }

        #LeavesTable_filter input {
            border: 1px solid #aaa;
            border-radius: 3px;
            padding: 5px;
            background-color: transparent;
            margin-left: 3px;
        }

        .createLeavefields input, select {
            border-radius: 0px !important;
        }

        .createLeavefields .form-group label {
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .createLeavefields .form-group select[multiple] {
            height: 40px;
            scrollbar-width: thin;
        }

        .createLeavefields label {
            font-size: 0.85rem;
            padding-bottom: 5px !important;
            display: block;
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
    </style>
</head>
<body style="background-color: #f8f9fa">
    <input type="hidden" id="Leave_id" name="Leave_id" />
    <input type="hidden" id="id_attachments_hidden_value" name="id_attachments_hidden_value" />

    <div id="greenAlert" style="display: none; align-items: center;" class="alert alert-success alert-dismissible fade alert-custom" role="alert">
        <strong><i class="fa-sharp fa-solid fa-circle-exclamation ml-1 mr-3"></i></strong><span id="greenAlertmessage"></span>
    </div>
    <div class="main-container">
        <div id="sidebarContainer" class="left-navbar">
            <uc:LeftNavBar runat="server" />
        </div>
        <div id="content-container" class="content-container">
            <div class="header-container">
                <uc:HeaderNavBar runat="server" />
            </div>
            <div class="d-flex align-items-center justify-content-between bg-light p-3 mt-4 ml-3 mr-3">
                <h1 style="font-size: 2rem; font-weight: 700 !important;" class="ml-1">Leave Requests</h1>
                <div id="bulkActionsContainer" class="d-flex" style="gap: 10px;">
                    <button class="btn btn-success" style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;" onclick="approveleave(null)">Bulk Approve</button>
                    <button class="btn btn-danger" style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;" onclick="rejectleave(null)">Bulk Reject</button>
                    <button class="btn btn-primary" style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;" onclick="exportData()">Export</button>
                </div>
                <div id="dataTableControls" class="d-flex align-items-center mr-2 mt-3" style="gap: 20px;"></div>
            </div>
            <div class="mt-2">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card ml-3 mr-3">
                        <div class="card-body p-3">
                            <table id="LeavesTable" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Leave ID</th>
                                        <th>
                                            <input type="checkbox" id="selectAll" onclick="toggleSelectAll()" /></th>
                                        <th>Employee</th>
                                        <th>Leave Type</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Request Days</th>
                                        <th>Leave Clash</th>
                                        <th>Status</th>
                                        <th>Reason</th>
                                        <th>Attachment</th>
                                        <th>Approval</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div id="Quickaction-container">
                <uc:Quick_action runat="server" />
            </div>
        </div>
    </div>

    <div class="modal fade pt-5" id="createLeavemodal" tabindex="-1" aria-labelledby="createLeavemodalLabel">
        <div class="modal-dialog modal-dialog-centered modal-lg mx-auto" style="max-width: 41%; margin: 0 auto;">
            <div class="modal-content" style="border-radius: 0px !important; width: 100%;">
                <div class="modal-header" style="padding: 1.50rem 1.70rem 1rem; height: 30px; background-color: transparent; border-bottom: none;">
                    <h2 class="modal-title" id="createLeavemodalLabel" style="font: normal 80%/1.4 sans-serif; font-size: 1.10rem; font-weight: 600; color: #4f4a4a;">Create Leave</h2>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body createLeavefields">
                    <div class="mx-2 mb-2" style="color: hsl(0, 0%, 11%); font-weight: 500; background-color: hsl(0,0%,100%); border: 1px solid hsl(213,22%,84%); padding: 1.2rem;">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="id_leave_type">Leave Type:</label>
                                <select name="leave_type" class="form-control select2" id="id_leave_type">
                                    <option value="" disabled="disabled" selected="selected">Select Leave Type</option>
                                    <option value="1">Sick Leave</option>
                                    <option value="2">Casual Leave</option>
                                    <option value="3">Earned Leave</option>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="id_attachments">Attachments:</label>
                                <input type="file" name="attachments" class="form-control-file" id="id_attachments" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="id_start_date">Start Date:</label>
                                <input type="date" name="start_date" class="form-control" id="id_start_date" />
                            </div>
                            <div class="form-group col-md-6">
                                <label for="id_start_day_breakdown">Start Day Breakdown:</label>
                                <select name="start_day_breakdown" class="form-control" id="id_start_day_breakdown">
                                    <option value="Full">Full Day</option>
                                    <option value="First Half">First Half</option>
                                    <option value="Second Half">Second Half</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="id_end_date">End Date:</label>
                                <input type="date" name="end_date" class="form-control" id="id_end_date" />
                            </div>
                            <div class="form-group col-md-6">
                                <label for="id_end_day_breakdown">End Day Breakdown:</label>
                                <select name="end_day_breakdown" class="form-control" id="id_end_day_breakdown">
                                    <option value="Full">Full Day</option>
                                    <option value="First Half">First Half</option>
                                    <option value="Second Half">Second Half</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="id_description">Description:</label>
                            <textarea id="id_description" class="form-control" rows="4" placeholder="Enter description here..."></textarea>
                        </div>
                        <div class="text-right">
                            <button onclick="save_Leave()" class="btn btn-primary ml-2" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="detailsModal" tabindex="-1" role="dialog" aria-labelledby="detailsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div id="leaveCarousel" class="carousel slide" data-interval="false">
                    <div class="carousel-inner" id="carouselContent">
                    </div>
                    <a class="carousel-control-prev" href="#leaveCarousel" role="button" data-slide="prev" style="position: absolute; left: -90px;">
                        <span style="color: #333; font-size: 0.6rem;" class="carousel-control-prev-icon bg-white rounded-circle d-flex align-items-center justify-content-center p-3" style="color: white;" aria-hidden="true">
                            <i class="fa-solid fa-less-than"></i>
                        </span>
                    </a>
                    <a class="carousel-control-next" href="#leaveCarousel" role="button" data-slide="next" style="position: absolute; right: -90px;">
                        <span style="color: #333; font-size: 0.6rem;" class="carousel-control-next-icon bg-white rounded-circle d-flex align-items-center justify-content-center p-3" aria-hidden="true">
                            <i class="fa-solid fa-greater-than"></i>
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="descriptionModal" tabindex="-1" role="dialog" aria-labelledby="descriptionModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header mt-1 pb-2" style="background-color: transparent; border-bottom: none;">
                    <h5 class="modal-title ml-1" id="descriptionModalLabel">Full Description</h5>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="card mx-auto p-2 mb-4" style="max-width: 800px; border: 1px solid lightgrey; border-radius: 10px; box-shadow: 2px 2px 2px grey;">
                        <div class="card-body">
                            <spam class="card-text" id="fullDescriptionContent"></spam>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="clashLeaveModal" tabindex="-1" aria-labelledby="clashLeaveModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header mt-1 pb-2" style="background-color: transparent; border-bottom: none; flex-direction: column; align-items: flex-start;">
                    <span id="clashLeaveModalHeader"></span>
                    <button type="button" style="margin-top: 3px; margin-right: 5px; border: none; outline: none; position: absolute; top: 10px; right: 10px;" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            populateleaves();
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        function toggleSelectAll() {
            const isChecked = $('#selectAll').is(':checked');
            $('.leave-checkbox').prop('checked', isChecked);
            $('.leave-checkbox').each(function () {
                const row = $(this).closest('tr');

                if (isChecked) {
                    row.css('background-color', 'hsl(8, 77%, 90%)');
                } else {
                    row.css('background-color', '#f8f9fa');
                }
            });
        }

        function toggleBulkActions() {
            const allCheckboxes = $('.leave-checkbox');
            const isAllChecked = allCheckboxes.length === allCheckboxes.filter(':checked').length;
            $('#selectAll').prop('checked', isAllChecked);

            allCheckboxes.each(function () {
                const row = $(this).closest('tr');

                if ($(this).is(':checked')) {
                    row.css('background-color', 'hsl(8, 77%, 90%)');
                } else {
                    row.css('background-color', '#f8f9fa');
                }
            });
        }

        function populateleaves() {
            $.ajax({
                type: "POST",
                url: 'all_emp_leave_request.aspx/populateleaves',
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
                    cleanedResponse = cleanedResponse.replace(/\r\n|\r|\n/g, '');
                    leaveData = JSON.parse(cleanedResponse);

                    if ($.fn.DataTable.isDataTable('#LeavesTable')) {
                        $('#LeavesTable').DataTable().clear().destroy();
                    }

                    $('#LeavesTable').DataTable({
                        data: leaveData,
                        scrollX: true,
                        scrollCollapse: true,
                        fixedColumns: {
                            rightColumns: 1
                        },
                        columnDefs: [
                            { orderable: false, targets: 1 }
                        ],
                        dom: "<'row'<'col-sm-6'l><'col-sm-6'f>>tp",
                        initComplete: function () {
                            $('#LeavesTable_length').detach().appendTo('#dataTableControls');
                            $('#LeavesTable_filter').detach().appendTo('#dataTableControls');
                        },
                        columns: [
                            { data: 'leave_id', visible: false },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    return `<input type="checkbox" class="leave-checkbox" value="${data.leave_id}" onclick="toggleBulkActions()">`;
                                }
                            },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    var profileHTML;
                                    var profileImg = data.profile_img;
                                    var profileColor = data.profile_color;
                                    var profileLetters = data.profile_letters;
                                    var empName = data.emp_name;

                                    if (profileImg != "") {
                                        profileHTML = `<div style='display: flex; align-items: center;'>
                                                    <img src='${profileImg}' alt='Profile Picture' class='rounded-circle' style='width: 40px; height: 40px;'>
                                                    <div style='margin-left: 15px;'>
                                                        <div>${empName}</div>
                                                        <div>${data.department_name} / ${data.job_position_name}</div>
                                                    </div>
                                                </div>`;
                                    } else {
                                        profileHTML = `<div style='display: flex; align-items: center;'>
                                                    <span class='rounded-circle d-inline-flex justify-content-center align-items-center' style='width: 40px; height: 40px; background-color: ${profileColor}; color: white; font-weight: bold;'>
                                                    ${profileLetters}</span>
                                                    <div style='margin-left: 15px;'>
                                                        <div>${empName}</div>
                                                        <div>${data.department_name} / ${data.job_position_name}</div>
                                                    </div>
                                                </div>`;
                                    }

                                    return profileHTML;
                                }
                            },
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
                                data: 'clashLeaveIds',
                                render: function (data) {
                                    let clashCount = data.trim() === "" ? 0 : data.split(',').filter(id => id.trim() !== "").length;
                                    return `<div style="display: flex; align-items: center; justify-content: center; gap: 8px;">
                                <i class="fa-solid fa-users" style="font-size: 30px;"></i> 
                                <div style="margin-top:-25px; margin-right:-20px; width: 20px; height: 20px; border-radius: 50%; background-color: hsl(8,61%,50%); color: white; font-size: 12px; font-weight: bold;">
                                   ${clashCount}
                                </div>
                            </div>`;
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
                            },
                            {
                                data: 'leave_description',
                                render: function (data) {
                                    return `<a href="#" class="description-link" data-description='${data}'>View Description</a>`;
                                }
                            },
                            {
                                data: 'attachment',
                                render: function (data) {
                                    if (!data || data.trim() === "") {
                                        return "<span style='color:gray'>No attachments</span>";
                                    }
                                    const attachmentParts = data.split('/').pop().split('_');
                                    const originalFileName = attachmentParts.slice(2).join('_');
                                    return `<a href="${data}" target="_blank">${originalFileName}</a>`;
                                }
                            },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    if (row.leave_status === "Canceled") {
                                        return "";
                                    }
                                    let approveBtnDisabled = row.leave_status === "Approved" ? 'disabled' : '';
                                    let rejectBtnDisabled = row.leave_status === "Rejected" ? 'disabled' : '';
                                    return `
                            <div class="btn-group" role="group">
                                <button class="btn btn-success btn-sm approve-btn p-1" style="width:80px; border-radius:0;" onclick="approveleave(${row.leave_id})" ${approveBtnDisabled}>
                                <i class="fas fa-check-circle"></i> Approve</button>
                                <button class="btn btn-danger btn-sm remove-btn p-1" style="width:80px; border-radius:0;" onclick="rejectleave(${row.leave_id})" ${rejectBtnDisabled}>
                                <i class="fas fa-times-circle"></i> Reject</button>
                            </div>`;
                                }
                            }
                        ],
                        createdRow: function (row, data, dataIndex) {
                            $('td', row).addClass('text-center');
                            $(row).find("td:nth-child(2)").removeClass('text-center');
                        },
                        language: {
                            emptyTable: `<div style="text-align: center;">
            <img src="/asset/img/no-leave-requests.png" alt="No data available" style="max-width: 130px; margin-top: 70px; margin-bottom: 30px">
            <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
         </div>`
                        }
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

        $('#LeavesTable').on('click', 'td:nth-child(7)', function () {
            var table = $('#LeavesTable').DataTable();
            var rowData = table.row(this).data();
            var clashLeaveIds = rowData.clashLeaveIds.split(',');

            var clashLeaveModalHeader = "";
            if (!rowData.clashLeaveIds || rowData.clashLeaveIds.trim() === '') {
                const noDataHTML = `<div style="text-align: center;">
                                        <img src="/asset/img/no-leave-requests.png" alt="No data available" style="max-width: 130px; margin-top: 70px; margin-bottom: 30px">
                                        <p style="font-size: 16px; color: #555; margin-top: 10px;">No Leave Clashes Found</p>
                                    </div>`;
                clashLeaveModalHeader = `<h4 class="modal-title ml-2 font-weight-bold" id="clashLeaveModalLabel" style="color: hsl(8,77%,56%); font-size: 1.5rem; display: inline-block;">No Leave Clashes Found</h4>`;

                $('#clashLeaveModalHeader').html(clashLeaveModalHeader);
                $('#clashLeaveModal .modal-body').html(noDataHTML);
                $('#clashLeaveModal').modal('show');
                return;
            }

            if (clashLeaveIds.length > 0) {
                var clashRows = clashLeaveIds.map(function (leaveId) {
                    return table.rows().data().toArray().filter(function (row) {
                        return row.leave_id === leaveId;
                    })[0];
                });

                clashLeaveModalHeader = `<h4 class="modal-title ml-2 font-weight-bold" id="clashLeaveModalLabel" style="color: hsl(8,77%,56%); font-size: 1.5rem; display: inline-block;">
                                          Leave Clash Due to <span style="color: black; font-size: 1.2rem;">Overlapping Job Positions</span></h4>`;
                $('#clashLeaveModalHeader').html(clashLeaveModalHeader);

                var profileHTML = rowData.profile_img
                    ? `<div style='display: flex; align-items: center;'>
                            <img src='${rowData.profile_img}' alt='Profile Picture' class='rounded-circle' style='width: 25px; height: 25px;'> 
                            <div style='margin-left: 10px;'>
                                <div>${rowData.emp_name}</div>
                                <div style="color:#888">${rowData.department_name} / ${rowData.job_position_name}</div>
                            </div>
                        </div>`
                    : `<div style='display: flex; align-items: center;'>
                            <span class='rounded-circle d-inline-flex justify-content-center align-items-center' style='width: 25px; height: 25px; background-color: ${rowData.profile_color}; color: white;'> 
                            ${rowData.profile_letters}</span>
                            <div style='margin-left: 10px;'>
                                <div>${rowData.emp_name}</div>
                                <div style="color:#888">${rowData.department_name} / ${rowData.job_position_name}</div>
                            </div>
                        </div>`;

                let modalContent = `
                <div style="max-width: 100%; overflow-x: auto;">
                    <table style="width: 100%; border-collapse: collapse; margin-bottom: 15px;">
                        <thead>
                            <tr style="border-bottom: 1px solid gray; color: gray;">
                                <th style="padding: 8px; text-align: left;">Employee</th>
                                <th style="padding: 8px; text-align: left;">Leave</th>
                                <th style="padding: 8px; text-align: left;">Start Date</th>
                                <th style="padding: 8px; text-align: left;">Start Date Breakdown</th>
                                <th style="padding: 8px; text-align: left;">End Date</th>
                                <th style="padding: 8px; text-align: left;">End Date Breakdown</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="padding: 8px; font-size: 1vw;">
                                  ${profileHTML}
                                </td>
                                <td style="padding: 8px; font-size: 1vw;">${rowData.leave_type}</td>
                                <td style="padding: 8px; font-size: 1vw;">${rowData.start_date}</td>
                                <td style="padding: 8px; font-size: 1vw;">${rowData.start_date_breakdown}</td>
                                <td style="padding: 8px; font-size: 1vw;">${rowData.end_date}</td>
                                <td style="padding: 8px; font-size: 1vw; max-width: 200px; overflow: hidden; text-overflow: ellipsis;">${rowData.end_date_breakdown}</td>
                            </tr>`;

                clashRows.forEach(function (row) {
                    profileHTML = row.profile_img
                        ? `<div style='display: flex; align-items: center;'>
                            <img src='${row.profile_img}' alt='Profile Picture' class='rounded-circle' style='width: 25px; height: 25px;'> 
                            <div style='margin-left: 10px;'>
                                <div>${row.emp_name}</div>
                                <div style="color:#888">${row.department_name} / ${row.job_position_name}</div>
                            </div>
                        </div>`
                        : `<div style='display: flex; align-items: center;'>
                            <span class='rounded-circle d-inline-flex justify-content-center align-items-center' style='width: 25px; height: 25px; background-color: ${row.profile_color}; color: white;'> 
                            ${row.profile_letters}</span>
                            <div style='margin-left: 10px;'>
                                <div>${row.emp_name}</div>
                                <div style="color:#888">${row.department_name} / ${row.job_position_name}</div>
                            </div>
                        </div>`;
                    modalContent += `
                <tr>
                    <td style="padding: 8px; font-size: 1vw;">
                       ${profileHTML}
                    </td>
                    <td style="padding: 8px; font-size: 1vw; white-space: nowrap;">${row.leave_type}</td>
                    <td style="padding: 8px; font-size: 1vw; white-space: nowrap;">${row.start_date}</td>
                    <td style="padding: 8px; font-size: 1vw;">${row.start_date_breakdown}</td>
                    <td style="padding: 8px; font-size: 1vw; white-space: nowrap;">${row.end_date}</td>
                    <td style="padding: 8px; font-size: 1vw; max-width: 200px; overflow: hidden; text-overflow: ellipsis;">${row.end_date_breakdown}</td>
                </tr>
            `;
                });

                modalContent += '</tbody></table></div>';

                $('#clashLeaveModal .modal-body').html(modalContent);
                $('#clashLeaveModal').modal('show');
            }
        });



        $('#LeavesTable').on('click', 'td:nth-child(2), td:nth-child(3), td:nth-child(4), td:nth-child(5), td:nth-child(6), td:nth-child(8)', function () {
            const table = $('#LeavesTable').DataTable();
            const rowData = table.row(this).data();
            if (!rowData) return;

            const rows = table.rows().data().toArray();
            let carouselItems = '';

            rows.forEach((data, index) => {
                const activeClass = data.leave_id === rowData.leave_id ? 'active' : '';

                var clashLeaveIds = data.clashLeaveIds;
                let clashCount = clashLeaveIds.trim() === "" ? 0 : clashLeaveIds.split(',').filter(id => id.trim() !== "").length;

                const profileHTML = data.profile_img
                    ? `<div style='display: flex; align-items: center;'>
            <img src='${data.profile_img}' alt='Profile Picture' class='rounded-circle' style='width: 60px; height: 60px;'> 
            <div style='margin-left: 20px;'>
                <div style="font-weight: bold; font-size: 1.2rem;">${data.emp_name}</div>
                <div style="font-size: 1rem;">${data.department_name} / ${data.job_position_name}</div>
            </div>
        </div>`
                    : `<div style='display: flex; align-items: center;'>
            <span class='rounded-circle d-inline-flex justify-content-center align-items-center' style='width: 60px; height: 60px; background-color: ${data.profile_color}; color: white; font-weight: bold; font-size: 1.5rem;'> 
            ${data.profile_letters}</span>
            <div style='margin-left: 20px;'>
                <div style="font-weight: bold; font-size: 1.5rem;">${data.emp_name}</div>
                <div style="font-size: 1.2rem;color:#4d4a4a">${data.department_name} / ${data.job_position_name}</div>
            </div>
        </div>`;

                carouselItems += `
        <div class="carousel-item ${activeClass}">
            <div class="modal-header ml-3 mt-2" style="border:none; justify-content: center">
                <h5 class="modal-title">Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="d-flex justify-content-center align-items-center mb-3">
                    ${profileHTML}  
                </div>
                 <div class="leave_details" style="margin-left:12%; display: flex; flex-direction: column; align-items: flex-start; text-align: left; width: 100%;">
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
                    <div class="row mt-3" style="width: 100%; justify-content: flex-start;">
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Created Date:</span><br /> 
                            <span style="font-size: 1rem;">${data.created_time}</span>
                        </div>
                        <div class="col-sm-6" style="padding: 10px; text-align: left;">
                            <span style="color: gray; font-size: 1rem;">Leave Clash Count:</span><br /> 
                            <span style="font-size: 1rem;">${clashCount}</span>
                        </div>
                    </div>
                    <div class="mt-3 ml-4" style="text-align: center;">
                        <button class="btn btn-link description-link" data-description="${data.leave_description}" data-leave-type="${data.leave_type}">
                            View Description
                        </button>
                        <button class="btn btn-link attachment-link" onclick="window.open('${data.attachment}', '_blank')">
                            View Attachment
                        </button>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-center" style="border:none">
               <button style="width:100px; height:40px; border-radius:0;" class="btn btn-success btn-sm" onclick="approveleave(${data.leave_id})">
                   <i class="fas fa-check-circle"></i> Approve
               </button>
               <button style="width:100px; height:40px; border-radius:0;" class="btn btn-danger btn-sm" onclick="rejectleave(${data.leave_id})">
                   <i class="fas fa-times-circle"></i> Reject
               </button>
           </div>
        </div>`;
            });

            $('#carouselContent').html(carouselItems);
            $('#detailsModal').modal('show');
        });

        $(document).on('click', '.description-link', function (e) {
            e.preventDefault();
            const heading = $(this).data('leave-type');
            const description = $(this).data('description');
            $('#descriptionModalLabel').text(heading);
            $('#fullDescriptionContent').html(description);
            $('#descriptionModal').modal('show');
        });

        function approveleave(leaveId = null) {
            const isBulk = !leaveId;
            const selectedCheckboxes = document.querySelectorAll('.leave-checkbox:checked');
            const leaveIds = isBulk
                ? Array.from(selectedCheckboxes).map((checkbox) => checkbox.value)
                : [leaveId];

            if (isBulk && leaveIds.length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No Requests Selected',
                    text: 'Please select at least one leave request to proceed.',
                    confirmButtonText: 'Ok',
                    confirmButtonColor: '#3085d6'
                });
                return;
            }

            Swal.fire({
                title: 'Are you sure?',
                text: `Do you want to approve ${isBulk ? "all selected" : "this"} leave request${isBulk ? "s" : ""}?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, approve it!',
                cancelButtonText: 'No, cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: 'all_emp_leave_request.aspx/approveLeave',
                        data: JSON.stringify({ leaveIds: leaveIds }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            if (response.d === "Success") {
                                display_green_alert(`The leave request${isBulk ? "s" : ""} have been approved successfully.`);
                                populateleaves();
                                document.getElementById("selectAll").checked = false;
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: response.d,
                                    confirmButtonText: 'Ok'
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: `An error occurred: ${error}. Response: ${xhr.responseText}`,
                                confirmButtonText: 'Ok'
                            });
                        }
                    });
                }
            });
        }

        function rejectleave(leaveId = null) {
            const isBulk = !leaveId;
            const selectedCheckboxes = document.querySelectorAll('.leave-checkbox:checked');
            const leaveIds = isBulk
                ? Array.from(selectedCheckboxes).map((checkbox) => checkbox.value)
                : [leaveId];

            if (isBulk && leaveIds.length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No Requests Selected',
                    text: 'Please select at least one leave request to proceed.',
                    confirmButtonText: 'Ok',
                    confirmButtonColor: '#3085d6'
                });
                return;
            }

            Swal.fire({
                title: 'Reason to reject',
                input: 'textarea',
                inputPlaceholder: 'Enter rejection reason...',
                showCancelButton: true,
                confirmButtonText: 'Reject',
                cancelButtonText: 'Cancel',
                confirmButtonColor: '#FF6F61',
                preConfirm: (reason) => {
                    if (!reason) {
                        Swal.showValidationMessage('Please enter a rejection reason');
                    } else {
                        return reason;
                    }
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    const rejectionReason = result.value;

                    $.ajax({
                        type: "POST",
                        url: 'all_emp_leave_request.aspx/rejectLeave',
                        data: JSON.stringify({ leaveIds: leaveIds, rejectionReason: rejectionReason }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            if (response.d === "Success") {
                                display_green_alert(`The leave request${isBulk ? "s" : ""} have been rejected successfully.`);
                                populateleaves();
                                document.getElementById("selectAll").checked = false;
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: response.d,
                                    confirmButtonText: 'Ok'
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: `An error occurred: ${error}. Response: ${xhr.responseText}`,
                                confirmButtonText: 'Ok'
                            });
                        }
                    });
                }
            });
        }

        function exportData() {
            const selectedCheckboxes = document.querySelectorAll('.leave-checkbox:checked');
            const selectedData = [];

            if (selectedCheckboxes.length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'No Requests Selected',
                    text: 'Please select at least one leave request to export.',
                    confirmButtonText: 'Ok',
                    confirmButtonColor: '#3085d6'
                });
                return;
            }

            selectedCheckboxes.forEach((checkbox) => {
                const rowData = $('#LeavesTable').DataTable().row($(checkbox).closest('tr')).data();
                selectedData.push({
                    "Employee Name": rowData.emp_name,
                    "Department": rowData.department_name,
                    "Job Position": rowData.job_position_name,
                    "Leave Type": rowData.leave_type,
                    "Start Date": rowData.start_date,
                    "Start Date": rowData.start_date_breakdown,
                    "End Date": rowData.end_date,
                    "End Date": rowData.end_date_breakdown,
                    "Requested Days": rowData.requested_days,
                    "Leave Status": rowData.leave_status,
                    "Description": rowData.leave_description
                });
            });

            const ws = XLSX.utils.json_to_sheet(selectedData);
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "Leave Requests");

            XLSX.writeFile(wb, "LeaveRequests.xlsx");
        }


    </script>
</body>
</html>
