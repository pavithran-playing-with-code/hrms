<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="announcements.aspx.cs" Inherits="hrms.announcements" %>

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
    <title>Announcement</title>
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

        #announcementsTable th {
            white-space: nowrap;
        }

        #announcementsTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
        }

            #announcementsTable td button {
                margin-right: 5px;
                margin-bottom: 5px;
                white-space: nowrap;
            }

        .createannouncementfields input, select {
            border-radius: 0px !important;
        }

        .createannouncementfields .form-group label {
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .createannouncementfields .form-group select[multiple] {
            height: 40px;
            scrollbar-width: thin;
        }

        .createannouncementfields label {
            font-size: 14px;
            padding-bottom: 5px !important;
            display: block;
        }

        .form-control.select2-hidden-accessible + .select2-container {
            width: 100% !important;
            height: calc(1.5em + .75rem + 2px) !important;
        }

        .select2-container--default .select2-selection--multiple {
            height: calc(1.5em + .75rem + 2px) !important;
            border: 1px solid #ced4da;
            border-radius: 0;
            padding: 0.375rem 0.75rem;
            display: flex;
            align-items: center;
        }

            .select2-container--default .select2-selection--multiple .select2-selection__rendered {
                line-height: 1.5 !important;
                overflow: hidden;
                padding: 0 !important;
            }

            .select2-container--default .select2-selection--multiple .select2-selection__placeholder {
                color: #6c757d;
                font-style: italic;
            }


        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: white;
            color: black;
        }

        .select2-container--default .select2-results__option:hover {
            background-color: #f1f1f1 !important;
            color: #333 !important;
        }

        .select2-container--default .select2-results__option[aria-selected=true] {
            background-color: #d6d6d6 !important;
            color: #333 !important;
        }

        .select2-selection__rendered .select2-selection__clear {
            margin-bottom: .25rem !important;
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
    <input type="hidden" id="announcement_id" name="announcement_id" />
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
                <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.5rem;" class="m-0">Announcements</h1>
                <button id="createAnnouncement" class="btn btn-outline-custom"
                    style="border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;"
                    onclick="opencreateannouncementmodal()" title="Create Announcement">
                    <i class="fa fa-plus"></i>&nbsp;Create
               
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card-body p-3">
                        <table id="announcementsTable" class="table table-striped table-bordered" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Announcement ID</th>
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Department</th>
                                    <th>Job Position</th>
                                    <th>Heading</th>
                                    <th>Description</th>
                                    <th>Attachments</th>
                                    <th>Posted On</th>
                                    <th>Expire Date</th>
                                    <th>Comments</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
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

    <div class="modal fade pt-5" id="createannouncementmodal" tabindex="-1" aria-labelledby="createannouncementmodalLabel">
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
                            <div class="row" style="margin-left: 40%">
                                <div>
                                    <label for="id_disable_comments" class="form-check-label ml-4">Disable Comments:</label>
                                </div>
                                <div>
                                    <input type="checkbox" name="disable_comments" class="form-check-input ml-3" id="id_diefwefsable_comments" />
                                </div>
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

    <script>
        $(document).ready(function () {
            populateannounncements();

            $('#id_description').summernote({
                height: 60,
                minHeight: null,
                maxHeight: null,
                focus: true,
                toolbar: [
                    ['font', ['fontname']],
                    ['style', ['style']],
                    ['fontsize', ['fontsize']],
                    ['style', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript']],
                    ['color', ['color', 'backcolor']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']],
                    ['history', ['undo', 'redo']]
                ]
            });
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        function populateannounncements() {
            $.ajax({
                type: "POST",
                url: 'announcements.aspx/populateannounncements',
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

                    if ($.fn.DataTable.isDataTable('#announcementsTable')) {
                        $('#announcementsTable').DataTable().clear().destroy();
                    }

                    $('#announcementsTable').DataTable({
                        data: data,
                        "ordering": false,
                        order: [[9, 'desc']],
                        columns: [
                            { data: 'announcement_id', visible: false },
                            { data: 'emp_id', visible: false },
                            { data: 'emp_name' },
                            { data: 'department_name' },
                            { data: 'job_position_name' },
                            { data: 'Heading' },
                            {
                                data: 'announcement_description',
                                render: function (data) {
                                    return `<a href="#" class="description-link" data-description='${data}'>View Description</a>`;
                                }
                            },
                            {
                                data: 'attachments',
                                render: function (data) {
                                    const attachmentParts = data.split('/').pop().split('_');
                                    const originalFileName = attachmentParts.slice(2).join('_');
                                    return `<a href="${data}" target="_blank">${originalFileName}</a>`;
                                }
                            },
                            {
                                data: 'posted_on',
                                render: function (data) {
                                    if (data == "") {
                                        return `<span style="color: gray; font-weight: bold;">Not Published</span>`;
                                    }
                                    else {
                                        const dateParts = data.split(' ')[0].split('-');
                                        const postedDate = `${dateParts[0]}-${dateParts[1]}-${dateParts[2]}`;
                                        return `<span style="color: green; font-weight: bold;">${postedDate}</span>`;
                                    }
                                }
                            },
                            {
                                data: 'expire_date',
                                render: function (data) {
                                    const currentDate = new Date();

                                    const currentFormattedDate = currentDate.toISOString().split('T')[0];
                                    const dateParts = data.split(' ')[0].split('-');
                                    const expireFormattedDate = `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`;
                                    const expireDate = `${dateParts[0]}-${dateParts[1]}-${dateParts[2]}`;

                                    if (expireFormattedDate < currentFormattedDate) {
                                        return `<span style="color: red; font-weight: bold;">${expireDate}</span>`;
                                    } else {
                                        return `<span >${expireDate}</span>`;
                                    }
                                }
                            },
                            {
                                data: 'comments',
                                render: function (data) {
                                    const value = data === "True" ? "Disabled" : "Enabled";
                                    return `<span> ${value}<span />`;
                                }
                            },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    if (row.posted_on === "") {
                                        return `
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-primary btn-sm publish-btn" onclick="publishannouncement(${row.announcement_id})">Publish</button>
                                            <button class="btn btn-warning btn-sm edit-btn" onclick="editannouncement(${row.announcement_id})">Edit</button>
                                            <button class="btn btn-danger btn-sm delete-btn" onclick="deleteannouncement(${row.announcement_id})">Delete</button>
                                        </div>`;
                                    } else {
                                        return `
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-secondary btn-sm republish-btn" onclick="Republish(${row.announcement_id})">Republish</button>
                                            <button class="btn btn-warning btn-sm edit-btn" onclick="editannouncement(${row.announcement_id})">Edit</button>
                                            <button class="btn btn-danger btn-sm delete-btn" onclick="deleteannouncement(${row.announcement_id})">Delete</button>
                                        </div>`;
                                    }
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
                         <img src="/asset/img/no-announcements.png" alt="No data available" style="max-width: 200px; margin-top: 20px;">
                         <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
                                         </div>`
                        }
                    });

                    $('#announcementsTable').on('click', '.description-link', function (e) {
                        e.preventDefault();
                        const description = $(this).data('description');
                        const heading = $(this).closest('tr').find('td').eq(3).text();
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

        function opencreateannouncementmodal() {
            clearannouncementfields();
            populatecreateannouncementmodal("department", null, null);
            $("#announcement_id").val('');
            $('#publishannouncementbtn').show();
            $('#editannouncementbtn').hide();
            $('#createannouncementmodal').modal('show');
            document.getElementById('createannouncementmodalLabel').innerText = "Create Announcement.";

            const today = new Date();
            const localDate = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
            document.getElementById('id_expire_date').value = localDate;
        }

        function populatecreateannouncementmodal(dropdowntype, value, departmentValues, callback) {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populatecreateannouncementmodal',
                data: JSON.stringify({ dropdowntype: dropdowntype, value: value, departmentValues: departmentValues }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);
                    $('#id_employees, #id_department, #id_job_position').select2({
                        placeholder: "Select an option",
                        allowClear: true
                    });

                    if (dropdowntype === "department") {
                        populateDropdown("#id_department", data);
                    } else if (dropdowntype === "job_position") {
                        populateDropdown("#id_job_position", data);
                    } else if (dropdowntype === "employees") {
                        populateDropdown("#id_employees", data);
                    }

                    if (typeof callback === "function") {
                        callback();
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

        function populateDropdown(selector, items) {
            const dropdown = $(selector);
            $('#id_employees').empty();
            dropdown.empty();
            if (items.length > 0) {
                items.forEach(item => {
                    dropdown.append(new Option(item.name, item.id));
                });
                dropdown.trigger('change');
            }
        }

        $('#id_department').on('change', function () {
            const selectedDepartments = $(this).val();
            if (selectedDepartments != "") {
                populatecreateannouncementmodal("job_position", selectedDepartments, null);
            }
        });

        $('#id_job_position').on('change', function () {
            const selectedJobPositions = $(this).val();
            const selectedDepartments = $('#id_department').val();
            if (selectedJobPositions != "" && selectedDepartments != "") {
                populatecreateannouncementmodal("employees", selectedJobPositions, selectedDepartments);
            }
        });

        function UploadFiles(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.onload = function () {
                    const base64File = reader.result.split(',')[1];

                    $.ajax({
                        url: 'dashboard.aspx/UploadFiles',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ fileName: file.name, fileData: base64File }),
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

        async function publish_edit_save_announcement(action) {
            let data = {};
            var announcementId = $("#announcement_id").val();

            if (action == "publish_from_dashboard") {
                data = {
                    title: "",
                    description: "",
                    attachments: "",
                    expireDate: "",
                    department: [],
                    jobPosition: [],
                    employees: [],
                    notify: [],
                    disableComments: false,
                    action: action,
                    announcementId: announcementId
                };
            }
            else {
                const title = $('#id_title').val();
                const description = $('#id_description').summernote('code');
                const expireDate = $('#id_expire_date').val();
                const employees = $('#id_employees').val();
                const department = $('#id_department').val();
                const jobPosition = $('#id_job_position').val();
                const disableComments = $('#id_disable_comments').is(':checked');
                const notifyEmail = $('#toggle_notify_email').is(':checked');
                const notifyPhone = $('#toggle_notify_phone').is(':checked');
                let attachments = '';
                let notify = [];

                if (notifyEmail) notify.push('email');
                if (notifyPhone) notify.push('phone');

                const fileInput = document.getElementById('id_attachments');

                if (action == "edit" && document.getElementById('id_attachments_helper').style.display == "block") {
                    attachments = $('#id_attachments_hidden_value').val();
                } else {
                    if (fileInput.files.length > 0) {
                        try {
                            attachments = await UploadFiles(fileInput.files[0]);
                        } catch (error) {
                            Swal.fire({
                                title: "Error!",
                                text: "Failed to upload the attachment. Please try again.",
                                icon: "error"
                            });
                            return;
                        }
                    }
                }

                if ((!title) ||
                    (!description || description === "<p><br></p>") ||
                    (!expireDate) ||
                    (!employees || employees.length === 0) ||
                    (!department || department.length === 0) ||
                    (!jobPosition || jobPosition.length === 0)) {
                    Swal.fire({
                        title: "Missing Fields",
                        text: "Please fill in all the required fields before proceeding.",
                        icon: "warning"
                    });
                    return;
                }

                data = {
                    title: title,
                    description: description,
                    attachments: attachments,
                    expireDate: expireDate,
                    department: department,
                    jobPosition: jobPosition,
                    employees: employees,
                    notify: notify,
                    disableComments: disableComments,
                    action, action,
                    announcementId, announcementId
                };
            }

            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/publish_edit_save_announcement',
                data: JSON.stringify(data),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);
                    if (data == "success") {
                        clearannouncementfields();
                        $('#createannouncementmodal').modal('hide');
                        populateannounncements();

                        var alertMessage = "";
                        if (action == "edit") {
                            $('#announcement_info_modal').modal('hide');
                            alertMessage = "Announcement updated successfully.";
                        }
                        else if (action == "publish") {
                            alertMessage = "Announcement published successfully.";
                        } else if (action == "save") {
                            alertMessage = "Announcement saved successfully.";
                        }
                        display_green_alert(alertMessage);
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

        function publishannouncement(announcement_id) {
            Swal.fire({
                title: "Are you sure?",
                text: "Do you want to publish this announcement?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, publish it!",
                cancelButtonText: "Cancel"
            }).then((result) => {
                if (result.isConfirmed) {
                    $("#announcement_id").val(announcement_id);
                    publish_edit_save_announcement("publish_from_dashboard");
                    display_green_alert('Announcement published successfully.');
                }
            });
        }

        function Republish(announcement_id) {
            Swal.fire({
                title: 'Are you sure?',
                text: 'Do you want to republish this announcement?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, Republish!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: 'dashboard.aspx/Republish',
                        data: JSON.stringify({ announcement_id: announcement_id }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            let data = response.d;
                            data = JSON.parse(data);
                            if (data == "success") {
                                populateannounncements();
                                display_green_alert('Announcement created successfully.');
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

        function editannouncement(announcement_id) {
            $('#publishannouncementbtn').hide();
            $('#editannouncementbtn').show();
            $('#createannouncementmodal').modal('show');
            clearannouncementfields();
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/editannouncement',
                data: JSON.stringify({ announcement_id: announcement_id }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    $("#announcement_id").val(announcement_id);
                    document.getElementById("createannouncementmodalLabel").innerText = "Edit Announcement.";
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    if (data.length > 0) {
                        const announcement = data[0];

                        $('#id_title').val(announcement.Heading);
                        $('#id_description').summernote('code', announcement.announcement_description);

                        if (announcement.comments == "True") {
                            $('#id_disable_comments').prop('checked', true);
                        }

                        if (announcement.expire_date) {
                            const dateParts = announcement.expire_date.split(' ')[0].split('-');
                            const formattedDate = `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`;
                            $('#id_expire_date').val(formattedDate);
                        }

                        if (announcement.attachments) {
                            const attachmentParts = announcement.attachments.split('/').pop().split('_');
                            const originalFileName = attachmentParts.slice(2).join('_');
                            document.getElementById('id_attachments_helper').style.display = 'block';
                            document.getElementById('remove_attachment_btn').style.display = 'block';
                            document.getElementById('id_attachments_helper').innerHTML = `<span style="font-weight:400">Existing File: ${originalFileName}</span>`;
                            $('#id_attachments_helper_value').val(announcement.attachments);
                            $('#id_attachments_hidden_value').val(announcement.attachments);
                        }

                        const departments = announcement.departments.split(',');
                        populatecreateannouncementmodal('department', null, null, function () {
                            $('#id_department').val(departments).trigger('change');

                            populatecreateannouncementmodal('job_position', departments, departments, function () {
                                const jobPositions = announcement.job_positions.split(',');
                                $('#id_job_position').val(jobPositions).trigger('change');

                                populatecreateannouncementmodal('employees', jobPositions, departments, function () {
                                    const employees = announcement.viewable_by.split(',');
                                    $('#id_employees').val(employees).trigger('change');
                                });
                            });
                        });

                        const notifyValues = announcement.notify.split(',');

                        if (notifyValues.includes("email")) {
                            $('#toggle_notify_email').prop('checked', true);
                        } else {
                            $('#toggle_notify_email').prop('checked', false);
                        }

                        if (notifyValues.includes("phone")) {
                            $('#toggle_notify_phone').prop('checked', true);
                        } else {
                            $('#toggle_notify_phone').prop('checked', false);
                        }
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

        function deleteannouncement(announcement_id) {
            Swal.fire({
                title: "Are you sure?",
                text: "Do you want to delete this announcement?",
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
                        url: 'dashboard.aspx/deleteannouncement',
                        data: JSON.stringify({ announcement_id: announcement_id }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            let data = response.d;
                            data = JSON.parse(data);

                            if (data == "success") {
                                $('#announcement_info_modal').modal('hide');
                                populateannounncements();
                                display_green_alert('Announcement delelted successfully.');
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

        function clearannouncementfields() {
            document.getElementById('id_attachments_helper').style.display = 'none';
            $("#announcement_id").val('');
            $('#id_title').val('');
            $('#id_description').summernote('code', '');
            $('#id_attachments').val('');
            $('#id_employees').val(null).trigger('change');
            $('#id_department').val(null).trigger('change');
            $('#id_job_position').val(null).trigger('change');
            $('#id_disable_comments').prop('checked', false);
        }

    </script>
</body>
</html>
