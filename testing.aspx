<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Testing</title>

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
                <div id="dataTableControls" class="d-flex align-items-center ml-auto mr-4 mt-2" style="gap: 20px;"></div>
                <button id="createAnnouncement" class="btn btn-outline-custom"
                    style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;"
                    onclick="opencreateannouncementmodal()" title="Create Announcement">
                    <i class="fa fa-plus"></i>&nbsp;Create
               
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card-body p-3">
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

    <script>
        $(document).ready(function () {
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

        function opencreateannouncementmodal() {
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
                        allowClear: true,
                        width: "100%",
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

    </script>
</body>
</html>
