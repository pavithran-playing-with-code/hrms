<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="leave_dashboard.aspx.cs" Inherits="hrms.leave_dashboard" %>

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
    <title>Leave Dashboard</title>
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
                                        <th>End Date</th>
                                        <th>Request Days</th>
                                        <th>Leave Clash</th>
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

    <script>
        $(document).ready(function () {
            populateleaves();
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        let leaveData = []; // Array to store all leave requests

        function populateleaves() {
            $.ajax({
                type: "POST",
                url: 'leave_dashboard.aspx/populateleaves',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\r\n|\r|\n/g, '');
                    leaveData = JSON.parse(cleanedResponse);

                    if ($.fn.DataTable.isDataTable('#LeavesTable')) {
                        $('#LeavesTable').DataTable().clear().destroy();
                    }

                    $('#LeavesTable').DataTable({
                        data: leaveData,
                        "ordering": false,
                        columns: [
                            { data: 'leave_id', visible: false },
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
                                data: null,
                                render: function (data) {
                                    return `<span>need to work</span>`;
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
    <button class="btn btn-success btn-sm approve-btn p-1" style="width:80px; border-radius:0;" onclick="approveleave(${row.leave_id})">
    <i class="fas fa-check-circle"></i> Approve</button>
    <button class="btn btn-danger btn-sm remove-btn p-1" style="width:80px; border-radius:0;" onclick="rejectleave(${row.leave_id})">
    <i class="fas fa-times-circle"></i> Reject</button>
</div>`;
                                }
                            }
                        ],
                        headerCallback: function (thead, data, start, end, display) {
                            $('th', thead).addClass('text-center');
                        },
                        createdRow: function (row, data, dataIndex) {
                            $('td', row).addClass('text-center');
                            $(row).find("td:nth-child(1)").removeClass('text-center');
                        },
                        language: {
                            emptyTable: `<div style="text-align: center;">
            <img src="/asset/no-announcements.png" alt="No data available" style="max-width: 200px; margin-top: 20px;">
            <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
         </div>`
                        }
                    });

                }
            });
        }

        $('#LeavesTable').on('click', 'tr', function () {
            const table = $('#LeavesTable').DataTable();
            const rowData = table.row(this).data();
            if (!rowData) return;

            const rows = table.rows().data().toArray();
            let carouselItems = '';

            rows.forEach((data, index) => {
                const activeClass = data.leave_id === rowData.leave_id ? 'active' : '';

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
                     <div class="col-sm-6 style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">Leave Type:</span><br>
                         <span style="font-size: 1rem;">${data.leave_type}</span>
                     </div>
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">Requested Days:</span><br> 
                         <span style="font-size: 1rem;">${data.requested_days}</span>
                     </div>
                 </div>
                 <div class="row" style="width: 100%; justify-content: flex-start;">
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">Start Date:</span><br> 
                         <span style="font-size: 1rem;">${data.start_date}</span>
                     </div>
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">Start Date Breakdown:</span><br> 
                         <span style="font-size: 1rem;">${data.start_date_breakdown}</span>
                     </div>
                 </div>
                 <div class="row" style="width: 100%; justify-content: flex-start;">
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">End Date:</span><br> 
                         <span style="font-size: 1rem;">${data.end_date}</span>
                     </div>
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">End Date Breakdown:</span><br> 
                         <span style="font-size: 1rem;">${data.end_date_breakdown}</span>
                     </div>
                 </div>
                 <div class="row mt-3" style="width: 100%; justify-content: flex-start;">
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">Created Date:</span><br> 
                         <span style="font-size: 1rem;">${data.created_time}</span>
                     </div>
                     <div class="col-sm-6" style="padding: 10px; text-align: left;">
                         <span style="color: gray; font-size: 1rem;">Created By:</span><br> 
                         <span style="font-size: 1rem;">${data.emp_name}</span>
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
     </div>

 `;
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

    </script>
</body>
</html>
