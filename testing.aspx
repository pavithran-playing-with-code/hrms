<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
    <title>Testing</title>
    <style>
        #Quickaction-container {
            display: flex;
            position: fixed;
            right: -10px;
            bottom: 10px;
            user-select: none;
        }

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

        .card-body {
            overflow-x: auto;
            padding: 0;
        }

        #LeavesTable th {
            white-space: nowrap;
        }

        #LeavesTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
                <h1 style="font-size: 2rem; font-weight: 700 !important;" class="m-0">Leave Requests</h1>
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
                            <table id="leaveTable" class="table table-striped table-bordered" style="width: 100%">
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
                                        <th>Reason</th>
                                        <th>Attachment</th>
                                        <th>Status</th>
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
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        document.addEventListener('DOMContentLoaded', function () {
            var today = new Date().toISOString().split('T')[0];

            document.getElementById('id_start_date').setAttribute('min', today);
            document.getElementById('id_end_date').setAttribute('min', today);
        });

        document.getElementById('id_start_day_breakdown').addEventListener('change', function () {
            var startDate = document.getElementById('id_start_date').value;
            if (!startDate) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please select a start date first.',
                });
                document.getElementById('id_start_day_breakdown').value = 'Full';
                return;
            }
        });

        document.getElementById('id_end_day_breakdown').addEventListener('change', function () {
            var endDate = document.getElementById('id_end_date').value;
            if (!endDate) {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please select a end date first.',
                });
                document.getElementById('id_end_day_breakdown').value = 'Full';
                return;
            }
        });

        function populateleaves() {
            $.ajax({
                type: "POST",
                url: 'my_leave_requests.aspx/populateleaves',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    if ($.fn.DataTable.isDataTable('#leaveTable')) {
                        $('#leaveTable').DataTable().clear().destroy();
                    }

                    $('#leaveTable').DataTable({
                        data: data,
                        "ordering": false,
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
                                data: 'leave_description',
                                render: function (data) {
                                    return `<a href="#" class="description-link" data-description='${data}'>View Description</a>`;
                                }
                            },
                            {
                                data: 'attachment',
                                render: function (data) {
                                    const attachmentParts = data.split('/').pop().split('_');
                                    const originalFileName = attachmentParts.slice(2).join('_');
                                    return `<a href="${data}" target="_blank">${originalFileName}</a>`;
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
                                    return data === "True"
                                        ? `<span style="color: green;font-weight: bold;">Approved</span>`
                                        : `<span style="color: red;font-weight: bold;">Rejected</span>`;
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
                        <img src="/asset/no-announcements.png" alt="No data available" style="max-width: 200px; margin-top: 20px;">
                        <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
                     </div>`
                        }
                    });

                    $('#leaveTable').on('click', '.description-link', function (e) {
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

        function UploadFiles(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.onload = function () {
                    const base64File = reader.result.split(',')[1];

                    $.ajax({
                        url: 'dashboard.aspx/UploadFiles',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ fileName: file.name, fileData: base64File, where: "leave" }),
                        success: function (response) {
                            resolve(response.d);
                        },
                        error: function (xhr, status, error) {
                            reject(error);
                        }
                    });
                };
                reader.onerror = function () {
                    reject("Error reading file.");
                };
                reader.readAsDataURL(file);
            });
        }

        async function save_Leave() {
            const leaveType = $('#id_leave_type').val();
            const startDate = $('#id_start_date').val();
            const startDayBreakdown = $('#id_start_day_breakdown').val();
            const endDate = $('#id_end_date').val();
            const endDayBreakdown = $('#id_end_day_breakdown').val();
            const description = $('#id_description').val();
            let attachment = '';

            if (!startDate ||
                !endDate ||
                (startDate > endDate) ||
                (startDate === endDate && startDayBreakdown === "Second Half" && (endDayBreakdown === "Full" || endDayBreakdown === "First Half")) ||
                (startDate < endDate && endDayBreakdown === "Second Half")) {
                Swal.fire({
                    title: "Invalid Dates or Breakdown",
                    text: "Please ensure the start and end dates, along with the breakdown, are valid. End date cannot be 'Second Half' if it spans multiple days.",
                    icon: "warning"
                });
                return;
            }


            if (!leaveType || !startDate || !startDayBreakdown || !endDate || !endDayBreakdown || !description) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill in all the required fields before proceeding.",
                    icon: "warning"
                });
                return;
            }

            const fileInput = document.getElementById('id_attachments');
            if (fileInput.files.length > 0) {
                try {
                    attachment = await UploadFiles(fileInput.files[0]);
                } catch (error) {
                    Swal.fire({
                        title: "Error!",
                        text: "Failed to upload the attachment. Please try again.",
                        icon: "error"
                    });
                    return;
                }
            }

            const data = {
                leaveType: leaveType,
                startDate: startDate,
                startDayBreakdown: startDayBreakdown,
                endDate: endDate,
                endDayBreakdown: endDayBreakdown,
                description: description,
                attachment: attachment
            };

            $.ajax({
                type: "POST",
                url: 'my_leave_requests.aspx/save_Leave',
                data: JSON.stringify(data),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);
                    if (data === "success") {
                        $('#createLeavemodal').modal('hide');
                        clearLeaveRequestFields();
                        populateleaves();
                        display_green_alert("The leave request has been saved successfully.");
                    } else if (data === "duplicate") {
                        Swal.fire({
                            title: "Duplicate Request!",
                            text: "A leave request for the selected dates and breakdown already exists.",
                            icon: "warning"
                        });
                    } else {
                        Swal.fire({
                            title: "Failure!",
                            text: "The leave request could not be saved. Please try again.",
                            icon: "error"
                        });
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

        function clearLeaveRequestFields() {
            $('#id_leave_type').val(null).trigger('change');
            $('#id_start_date').val('');
            $('#id_start_day_breakdown').val('full');
            $('#id_end_date').val('');
            $('#id_end_day_breakdown').val('full');
            $('#id_description').val('');
            $('#id_attachments').val('');
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

    </script>
</body>
</html>
