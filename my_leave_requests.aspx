<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_leave_requests.aspx.cs" Inherits="hrms.my_leave_requests" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Leave Request</title>

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

    <style>
        #Quickaction-container {
            position: fixed;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
            cursor: pointer;
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

        #LeavesTable th {
            white-space: nowrap;
        }

        #LeavesTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
            background-color: #f8f9fa !important;
        }

            #LeavesTable td button {
                margin-right: 5px;
                margin-bottom: 5px;
                white-space: nowrap;
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
    <input type="hidden" id="emp_access_lvl" name="emp_access_lvl" runat="server" />
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
            <div class="d-flex align-items-center justify-content-between bg-light p-3 mt-4 ml-3 mr-4">
                <h1 style="font-size: 2rem; font-weight: 700 !important;" class="m-0">Leave Requests</h1>
                <div id="dataTableControls" class="d-flex align-items-center ml-auto mr-4 mt-2" style="gap: 20px;"></div>
                <button id="createLeave" class="btn btn-outline-custom"
                    style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;"
                    onclick="$('#createLeavemodal').modal('show');" title="Create Leave">
                    <i class="fa fa-plus"></i>&nbsp;Create
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card ml-3 mr-3">
                        <div class="card-body p-3">
                            <table id="LeavesTable" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Leave ID</th>
                                        <th>Employee</th>
                                        <th>Leave Type</th>
                                        <th>Start Date</th>
                                        <th>Start Day Breakdown</th>
                                        <th>End Date</th>
                                        <th>End Day Breakdown</th>
                                        <th>Request Days</th>
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
                    <div class="row mt-5 mx-1 mb-5">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-light text-dark" style="font-weight: bold;">
                                    Leave Balance
                                </div>
                                <div class="card-body p-3">
                                    <table id="LeaveBalanceTable" class="table table-striped table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>Leave Type</th>
                                                <th>Max Leaves</th>
                                                <th>Balance Leave</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-light text-dark" style="font-weight: bold;">
                                    Leave History
                                </div>
                                <div class="card-body p-3">
                                    <table id="LeaveHistoryTable" class="table table-striped table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>Leave ID</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                                <th>Leave Type</th>
                                                <th>Reason</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="Quickaction-container">
                <uc:Quick_action runat="server" />
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

    <script>
        $(document).ready(function () {
            populateleaves();
            GetLeaveBalanceandLeaveHistory();
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        document.addEventListener("leaveRequestSaved", function () {
            populateleaves();
        });

        function populateleaves() {
            $.ajax({
                type: "POST",
                url: 'my_leave_requests.aspx/populateleaves',
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
                        dom: "<'row'<'col-sm-6'l><'col-sm-6'f>>tp",
                        initComplete: function () {
                            $('#dataTableControls').empty();
                            $('#LeavesTable_length').detach().appendTo('#dataTableControls');
                            $('#LeavesTable_filter').detach().appendTo('#dataTableControls');
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
                            { data: 'start_date_breakdown' },
                            {
                                data: 'end_date',
                                render: function (data) {
                                    const dateParts = data.split(' ')[0].split('-');
                                    const end_date = `${dateParts[1]}-${dateParts[0]}-${dateParts[2]}`;
                                    return `<span>${end_date}</span>`;
                                }
                            },
                            { data: 'end_date_breakdown' },
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
                                    return `
            <div class="btn-group" role="group">
                <button class="btn btn-danger btn-sm delete-btn" style="width:80px" onclick="cancelleave(${row.leave_id})">Cancel</button>
            </div>`;
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

        function cancelleave(leave_id) {
            Swal.fire({
                title: "Are you sure?",
                text: "Do you want to cancel this leave request?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, delete it!",
                cancelButtonText: "Cancel"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: 'my_leave_requests.aspx/cancelleave',
                        data: JSON.stringify({ leave_requests_id: leave_id }),
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

                            if (JSON.parse(response.d) == "success") {
                                display_green_alert("The leave request has been canceled successfully.");
                                populateleaves();
                            } else {
                                Swal.fire("issue while canceling leave request");
                            }
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
            });
        }

        function GetLeaveBalanceandLeaveHistory() {
            $.ajax({
                type: "POST",
                url: 'my_leave_requests.aspx/GetLeaveBalanceandLeaveHistory',
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

                    const data = JSON.parse(response.d);

                    if ($.fn.DataTable.isDataTable('#LeaveBalanceTable')) {
                        $('#LeaveBalanceTable').DataTable().clear().destroy();
                    }

                    $('#LeaveBalanceTable').DataTable({
                        data: data.LeaveBalance,
                        columns: [
                            { data: 'LeaveType' },
                            { data: 'MaxLeave' },
                            {
                                data: 'BalanceLeave',
                                render: function (data, type, row) {
                                    if (data <= 0) {
                                        return `<span style="color: red; font-weight: bold;">${data}</span>`;
                                    }
                                    return data;
                                }
                            }
                        ],
                        paging: false,
                        searching: false,
                        ordering: false,
                        info: false,
                        language: {
                            emptyTable: `<div style="text-align: center;">
   <img src="/asset/img/no-leave-requests.png" alt="No data available" style="max-width: 130px; margin-top: 70px; margin-bottom: 30px">
   <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
</div>`
                        }
                    });

                    if ($.fn.DataTable.isDataTable('#LeaveHistoryTable')) {
                        $('#LeaveHistoryTable').DataTable().clear().destroy();
                    }

                    $('#LeaveHistoryTable').DataTable({
                        data: data.LeaveHistory,
                        columns: [
                            { data: 'LeaveID' },
                            { data: 'StartDate' },
                            { data: 'EndDate' },
                            { data: 'LeaveType' },
                            { data: 'Reason' }
                        ],
                        paging: true,
                        searching: true,
                        ordering: true,
                        info: true,
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

    </script>
</body>
</html>
