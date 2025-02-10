<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="leave_admin_dashboard.aspx.cs" Inherits="hrms.leave_admin_dashboard" %>

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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.datatables.net/fixedcolumns/4.2.2/js/dataTables.fixedColumns.min.js"></script>

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
            overflow-x: hidden;
            margin-left: 20px;
            margin-right: 20px;
        }

        #Quickaction-container {
            position: absolute;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
        }

        * {
            scrollbar-width: thin;
        }

        .hovercards:hover {
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            transform: scale(1.05);
            transition: all 0.3s ease-in-out;
        }

        #monthPicker::-webkit-calendar-picker-indicator {
            margin-left: -10px;
        }

        .table.table-striped.table-bordered th,
        .table.table-striped.table-bordered td {
            border-color: white !important;
            white-space: nowrap;
        }

        .table.table-striped.table-bordered td {
            background-color: #f8f9fa;
        }


        #modaltable th, #modaltable td {
            border-color: white !important;
            white-space: nowrap;
        }

        #modaltable tbody td {
            background-color: #f8f9fa !important;
        }

        #modaltable {
            width: 100% !important;
            table-layout: fixed;
        }

        .modal-body {
            overflow-x: auto;
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
    <div id="greenAlert" style="display: none; align-items: center;" class="alert alert-success alert-dismissible fade alert-custom" role="alert">
        <strong><i class="fa-sharp fa-solid fa-circle-exclamation ml-1 mr-3"></i></strong><span id="greenAlertmessage"></span>
    </div>
    <input type="hidden" id="emp_access_lvl" name="emp_access_lvl" runat="server" />

    <div class="main-container">
        <div id="sidebarContainer" class="left-navbar">
            <uc:LeftNavBar runat="server" />
        </div>
        <div id="content-container" class="content-container">
            <div class="header-container">
                <uc:HeaderNavBar runat="server" />
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 35px; margin-top: 30px; margin-right: 65px">
                    <div class="row" id="dashboard" style="padding-bottom: 4.5rem;">
                        <div class="dashboard__left col-12 col-sm-12 col-md-12 col-lg-9">
                            <div class="row mb-5">
                                <div class="col-12 col-sm-12 col-md-6 col-lg-4">
                                    <div class="card hovercards leave-summary-card" data-status="Request to Approve">
                                        <div class="card-body" style="border-top: 5px solid hsl(216,18%,64%); cursor: pointer">
                                            <h6 class="card-title">Requests to Approve</h6>
                                            <h1 class="card-text" id="total_leave_request"></h1>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="card hovercards leave-summary-card" data-status="Approved">
                                        <div class="card-body" style="border-top: 5px solid hsl(148, 70%, 40%); cursor: pointer">
                                            <h6 class="card-title">Approved Leaves In This Month</h6>
                                            <h1 class="card-text" id="approved_leave_request"></h1>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="card hovercards leave-summary-card" data-status="Rejected">
                                        <div class="card-body" style="border-top: 5px solid hsl(37,90%,47%); cursor: pointer">
                                            <h6 class="card-title">Rejected Leaves In This Month</h6>
                                            <h1 class="card-text" id="rejected_leave_request"></h1>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-5">
                                <div class="col-12 col-sm-12 col-md-6 col-lg-4">
                                    <div class="card">
                                        <div class="card-header" style="background-color: white">
                                            <h6 class="card-title">On Leave</h6>
                                        </div>
                                        <div class="card-body d-flex flex-column align-items-center justify-content-center" id="onleave" style="max-height: 400px; overflow: auto;">
                                            <div class="mb-3 d-flex align-items-center">
                                                <span class="rounded-circle d-inline-flex justify-content-center align-items-center"
                                                    style="width: 40px; height: 40px; background-color: violet; color: white; font-weight: bold; font-size: 1rem;">BT
                                                </span>
                                                <div style="margin-left: 10px;">
                                                    <div style="font-weight: bold; font-size: 1rem;">Ben Tenison</div>
                                                    <div style="font-size: 1rem; color: #4d4a4a">IT / Senior Developer</div>
                                                </div>
                                            </div>
                                            <div class="mb-3 d-flex align-items-center">
                                                <span class="rounded-circle d-inline-flex justify-content-center align-items-center"
                                                    style="width: 40px; height: 40px; background-color: violet; color: white; font-weight: bold; font-size: 1rem;">BT
                                                </span>
                                                <div style="margin-left: 10px;">
                                                    <div style="font-weight: bold; font-size: 1rem;">Ben Tenison</div>
                                                    <div style="font-size: 1rem; color: #4d4a4a">IT / Senior Developer</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-md-12 col-lg-8">
                                    <div class="card">
                                        <div class="card-header d-flex justify-content-between align-items-center" style="background-color: white;">
                                            <h6 class="card-title">Employee Leaves</h6>
                                            <input type="month" id="monthPicker" class="form-control" style="width: 150px;" />
                                        </div>
                                        <div class="card-body" style="max-height: 500px; overflow: auto">
                                            <table id="LeavesTable" class="table table-striped table-bordered" style="width: 100%; height: 100%; border: none">
                                                <thead>
                                                    <tr>
                                                        <th>Leave ID</th>
                                                        <th>Employee</th>
                                                        <th>Leave Type</th>
                                                        <th>Start Date</th>
                                                        <th>End Date</th>
                                                        <th>Request Days</th>
                                                        <th>Status</th>
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
                        <div class="dashboard__right col-12 col-sm-12 col-md-12 col-lg-3">
                            <div class="card mb-4" style="background-color: orange">
                                <div class="card-header d-flex justify-content-center align-items-center " style="background-color: hsl(8,77%,56%); color: white">
                                    <h6 class="card-title mt-2" style="cursor: pointer;" onclick="window.location.href='leave_emp_dashboard.aspx'">View Personal Dashboard <i class="fa-solid fa-arrow-right"></i></h6>
                                </div>
                                <div class="card-body mt-1" style="background-color: orange; color: white">
                                    <div class="d-flex align-items-center">
                                        <div class="mr-3 ml-3 flex-shrink-0">
                                            <img style="width: 70px; height: 70px" src="/asset/img/holidays.png" />
                                        </div>
                                        <div class="d-flex flex-column justify-content-center" style="margin-top: -10px;">
                                            <span class="mt-2" style="font-size: 0.9rem; font-weight: 700; cursor: pointer;">Next Holiday</span>
                                            <h4 class="card-title mt-1" id="next_holiday" style="margin-bottom: 0px; word-wrap: break-word; white-space: normal;"></h4>
                                            <span class="mt-2" style="font-size: 0.8rem; font-weight: 600" id="next_holiday_date"></span>
                                        </div>
                                    </div>
                                </div>


                            </div>

                            <div class="card p-3 mb-4">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px">
                                    <h6 class="card-title ml-1">Holidays This Month</h6>
                                </div>
                                <hr />
                                <div class="card-body">
                                    <div class="holiday-body ml-3" id="holidayListCard" style="margin-top: -10px; height: 300px; overflow-y: auto; border: none;"></div>
                                </div>
                            </div>
                        </div>
                        <div id="Quickaction-container">
                            <uc:Quick_action runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="leaveModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Leave Details</h5>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="modaltable" class="table table-striped table-bordered" style="width: 100%; height: 100%; border: none">
                        <thead>
                            <tr>
                                <th>Leave ID</th>
                                <th>Employee</th>
                                <th>Leave Type</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Request Days</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
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

    <script>
        $(document).ready(function () {
            var today = new Date();
            const currentMonth = today.getMonth() + 1;
            const currentYear = today.getFullYear();

            $('#monthPicker').val(`${currentYear}-${String(currentMonth).padStart(2, '0')}`);

            populate_leave_details();
            nextHolidays(today.getMonth(), today.getFullYear());
            populate_leaves_based_months("leave_admin_dashboard", currentMonth, currentYear);
            HolidaysThisMonths();
        });

        $('#monthPicker').on('change', function () {
            const selectedDate = $(this).val().split('-');
            const selectedYear = selectedDate[0];
            const selectedMonth = selectedDate[1];
            populate_leaves_based_months("leave_admin_dashboard", selectedMonth, selectedYear);
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

    </script>

</body>

</html>

