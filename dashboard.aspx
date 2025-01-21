<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="hrms.dashboard" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>

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

    <title>HRMS</title>

    <style>
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

        #addAnnouncement:focus {
            outline: none;
            box-shadow: none;
        }

        .createannouncementfields label {
            font-size: 14px;
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
    <input type="hidden" id="announcement_id" name="announcement_id" />
    <input type="hidden" id="id_attachments_hidden_value" name="id_attachments_hidden_value" />

    <div class="container-fluid p-0">
        <div class="row no-gutters">
            <div class="col-md-3 col-lg-2 bg-light" style="min-height: 100vh;">
                <uc:LeftNavBar runat="server" ID="LeftNavBarControl" />
            </div>
            <div class="col-md-9 col-lg-10">
                <div id="banner_container" style="position: relative; z-index: 1050;">
                    <div id="ad-banner" class="w-100 position-relative"
                        style="background-color: hsl(8, 77%, 56%); height: 40px; opacity: 1; transition: opacity 0.5s ease, height 0.5s ease; overflow: hidden;">
                        <div class="d-flex h-100 justify-content-center align-items-center gap-4">
                            <p class="text-white mb-0 mr-3">
                                Having any issues, feedback, or suggestions? We’d love to hear from you!
                   
                            </p>
                            <a class="btn btn-outline contact-now-btn" href="https://www.horilla.com/customer-feedback/" target="_blank"
                                style="font-size: 12px; padding: 0.4rem 0.6rem; border-radius: 10px; color: #E8E8E8; background-color: #e54f38; border: 2px solid #E8E8E8">Contact Now
                    </a>
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
                <div>
                    <uc:HeaderNavBar runat="server" ID="HeaderNavBarControl" />
                </div>
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
                                        <div class="announcement-body" id="announcementListCard" style="height: 300px; overflow-y: auto; border: none;"></div>
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

    <div class="modal fade" id="announcement_info_modal" tabindex="-1" role="dialog" aria-labelledby="announcement_info_modalTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header mt-1 pb-2" style="background-color: transparent; border-bottom: none;">
                    <h4 class="modal-title font-weight-bold " id="announcement_info_modalTitle">Announcement.</h4>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="card mx-auto p-4 mb-4" style="max-width: 800px; border: 1px solid lightgrey; border-radius: 10px; box-shadow: 2px 2px 2px grey;">
                        <div class="card-header mb-3" style="background-color: transparent; border-bottom: none;">
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center">
                                    <h5 class="card-title fw-bold mb-0 mr-2" id="heading"></h5>
                                    <div class="d-flex align-items-center border border-success rounded px-2 py-1 text-success" title="1 view" style="cursor: pointer; border-width: 2px !important;">
                                        <span class="mr-1" style="font-size: 0.9rem; font-weight: bold;" id="viewed_by">1</span>
                                        <i class="fa-regular fa-eye" style="font-size: 0.9rem;"></i>
                                    </div>
                                </div>
                                <button class="onlyhighaccesslvl" style="cursor: pointer; background-color: transparent; border: none; outline: none" title="Action" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                </button>
                                <div class="dropdown-menu" style="font-size: 15px;">
                                    <a class="dropdown-item" href="#" onclick="editannouncement()" style="color: black">Edit</a>
                                    <a class="dropdown-item" href="#" onclick="Republish()" style="color: black">Publish</a>
                                    <a class="dropdown-item" href="#" onclick="deleteannouncement()" style="color: red">Delete</a>
                                </div>
                            </div>
                            <span class="text-muted fw-bold d-block mt-2">
                                <small style="font-weight: bold;">Posted on <span class="dateformat_changer" id="posted_date"></span>
                                    at <span class="timeformat_changer" id="posted_time"></span></small>
                            </span>
                        </div>
                        <div class="card-body">
                            <spam class="card-text" id="announcement_description"></spam>
                            <spam id="attachment_container" class="mt-3 pt-3" style="display: none; margin-top: 10px; font-weight: bold; color: #6c757d!important;">
                                Attachment: 
                                <a id="attachment_link" href="#" target="_blank" class="attachment-link"></a>
                            </spam>
                        </div>
                        <div class="card-footer mt-2" style="background-color: transparent; border-top: none;">
                            <div class="d-flex align-items-center justify-content-between">
                                <button class="btn btn-light ml-auto comment-button" onclick="$('#commentModal').modal('show');" type="button" title="Comments">
                                    <i class="fa-regular fa-comment" style="color: red; font-size: 1.5rem;"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- commentModal --%>
    <div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 700px;">
            <div class="modal-content">
                <div class="modal-header" style="background-color: transparent; border-bottom: none;">
                    <h5 class="modal-title" id="comments_header"></h5>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="padding-top: 0;">
                    <div class="pb-3">
                        <div id="successAlert" class="alert alert-success alert-dismissible fade" role="alert"
                            style="display: none; position: absolute; top: -1px; right: 15px; z-index: 1050; width: 50%; border-left: 3px solid #155724; padding-left: 15px;">
                            <strong><i class="fa-sharp fa-solid fa-circle-exclamation mr-1"></i></strong><span id="comment_alert"></span>

                            <button type="button" style="box-shadow: none; border: none" class="close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <input type="text" name="comment" id="commentInput" onkeyup="toggleCommentButton(this);"
                            class="form-control" placeholder="Comment here" />
                        <button id="commentButton" onclick="populatecomments()" class="btn btn-secondary mt-2" style="display: none; background-color: hsl(8,77%,56%)">Comment</button>
                    </div>
                    <div id="announcement_comments" class="mt-3">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- createannouncementmodal --%>
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

    <script>
        $(document).ready(function () {
            if (sessionStorage.getItem('showAlert') === 'true') {
                display_green_alert('Login successful.');
                sessionStorage.removeItem('showAlert');
            };

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

            populate_emp_details();
            populate_emp_details();
            populateannounncements();
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        function toggleCommentButton(input) {
            const commentButton = document.getElementById('commentButton');
            if (input.value.trim() === "") {
                commentButton.style.display = "none";
            } else {
                commentButton.style.display = "block";
            }
        }

        function populate_emp_details() {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populate_emp_details',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    const data = JSON.parse(response.d);

                    $("#new_joining_today").text(data.newJoiningAfterToday || 0);
                    $("#new_joining_this_week").text(data.newJoiningThisWeek || 0);
                    $("#total_emp").text(data.totalEmpCount || 0);
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

        function populateannounncements() {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populateannounncements',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);
                    let announcementsHTML = '';


                    if (Array.isArray(data) && data.length > 0) {
                        data.forEach(announcement => {
                            const announcement_id = announcement.announcement_id;
                            const profileImage = announcement.profile_img;
                            const profileLetters = announcement.profile_letters;
                            const profileColor = announcement.profile_color;
                            const heading = announcement.heading;
                            const emp_access_lvl = announcement.emp_access_lvl;

                            if (emp_access_lvl != "true") {
                                document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                                    element.style.display = 'none';
                                });
                            }

                            let profileHTML = '';
                            if (profileImage) {
                                profileHTML = '<img src="' + profileImage + '" alt="Profile Picture" class="rounded-circle" style="width: 30px; height: 30px;">' +
                                    ' <span class="profile-name text-dark font-weight-bold">' + heading + '</span>';
                            } else {
                                profileHTML = '<span class="rounded-circle d-inline-flex justify-content-center align-items-center" ' +
                                    'style="width: 30px; height: 30px; background-color: ' + profileColor + '; color: white; font-weight: bold;">' +
                                    profileLetters + '</span>' +
                                    ' <span class="profile-name text-dark font-weight-bold">' + heading + '</span>';
                            }

                            announcementsHTML += '<div class="announcement-row pb-3" draggable="true" onclick="openannouncementmodal(' + announcement_id + ')">' +
                                '<div class="announcement-title">' +
                                '<a class="profile-link" style="text-decoration: none;">' +
                                '<div class="profile-avatar mr-1">' + profileHTML +
                                '</div></a></div></div>';

                        });

                    }
                    else {
                        announcementsHTML = '<div id="empty_announcement" style="padding-top: 10%">\
                            <div class="empty_announcement">\
                                <img style="display: block; width: 100px; margin: 20px auto;" src="/asset/no-announcements.png" />\
                                <h5 style="color: hsl(0,0%,45%); text-align: center;">No Announcements to show.</h5>\
                            </div>\
                        </div>';
                    }
                    $('#announcementListCard').html(announcementsHTML);
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

        function openannouncementmodal(announcement_id) {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/add_viewed_by',
                data: JSON.stringify({ announcement_id: announcement_id }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    $('#announcement_info_modal').modal('show');

                    $.ajax({
                        type: "POST",
                        url: 'dashboard.aspx/openannouncementmodal',
                        data: JSON.stringify({ announcement_id: announcement_id }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                            cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                            const announcementList = JSON.parse(cleanedResponse);

                            if (announcementList.length > 0) {
                                const announcement = announcementList[0];
                                $("#announcement_id").val(announcement_id);
                                document.getElementById("heading").innerText = announcement.heading;
                                document.getElementById("viewed_by").innerText = announcement.viewed_by;
                                document.getElementById("posted_date").innerText = announcement.posted_date;
                                document.getElementById("posted_time").innerText = announcement.posted_time;
                                document.getElementById("announcement_description").innerHTML = announcement.announcement_description;
                                document.getElementById("comments_header").innerText = announcement.heading + " comments";

                                if (announcement.attachments != "") {
                                    const attachmentLink = document.getElementById("attachment_link");
                                    attachmentLink.href = announcement.attachments;
                                    const attachmentParts = announcement.attachments.split('/').pop().split('_');
                                    const originalFileName = attachmentParts.slice(2).join('_');
                                    attachmentLink.innerText = originalFileName;
                                    document.getElementById("attachment_container").style.display = "block";
                                } else {
                                    const attachmentLink = document.getElementById("attachment_link");
                                    attachmentLink.href = "";
                                    attachmentLink.innerText = "";
                                    document.getElementById("attachment_container").style.display = "none";
                                }
                                if (announcement.comments == "False") {
                                    document.querySelector(".comment-button").style.display = 'none';
                                } else {
                                    document.querySelector(".comment-button").style.display = 'flex';
                                    populatecomments();
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

        document.getElementById('remove_attachment_btn').addEventListener('click', function () {
            document.getElementById('id_attachments_helper').style.display = 'none';
            document.getElementById('remove_attachment_btn').style.display = 'none';
        });

        document.getElementById('id_attachments').addEventListener('change', function () {
            const fileInput = this;
            if (fileInput.files.length > 0) {
                document.getElementById('id_attachments_helper').style.display = 'none';
                document.getElementById('remove_attachment_btn').style.display = 'block';
            }
        });

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

        function uploadAttachment(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.onload = function () {
                    const base64File = reader.result.split(',')[1];

                    $.ajax({
                        url: 'dashboard.aspx/UploadAttachment',
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
            var announcementId = $("#announcement_id").val();
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
                        attachments = await uploadAttachment(fileInput.files[0]);
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

            const data = {
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



        function Republish() {
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
                        data: JSON.stringify({ announcement_id: $("#announcement_id").val() }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            let data = response.d;
                            data = JSON.parse(data);
                            if (data == "success") {
                                $('#announcement_info_modal').modal('hide');
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

        function editannouncement() {
            $('#publishannouncementbtn').hide();
            $('#editannouncementbtn').show();
            $('#createannouncementmodal').modal('show');
            clearannouncementfields();
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/editannouncement',
                data: JSON.stringify({ announcement_id: $("#announcement_id").val() }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
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

        function deleteannouncement() {
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
                        data: JSON.stringify({ announcement_id: $("#announcement_id").val() }),
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
            $('#id_title').val('');
            $('#id_description').summernote('code', '');
            $('#id_attachments').val('');
            $('#id_employees').val(null).trigger('change');
            $('#id_department').val(null).trigger('change');
            $('#id_job_position').val(null).trigger('change');
            $('#id_disable_comments').prop('checked', false);
            $('#toggle_notify_email').prop('checked', false);
            $('#toggle_notify_phone').prop('checked', false);
        }

        $('#commentButton').click(function () {
            document.getElementById("comment_alert").innerText = "Your comment was submitted.";
            $('#successAlert').removeClass('fade show').css('display', 'none');
            $('#successAlert').fadeIn('slow').addClass('show').css('display', 'block');
        });

        function populatecomments() {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populatecomments',
                data: JSON.stringify({ announcement_id: $("#announcement_id").val(), commentInput: $("#commentInput").val() }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    commentButton.style.display = "none";
                    $("#commentInput").val("");

                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const commentsList = JSON.parse(cleanedResponse);
                    if (commentsList.length > 0) {
                        var commentsHtml = "";
                        const comments = commentsList[0];

                        commentsList.forEach(function (comment) {
                            let profileHTML = '';

                            if (comments.profile_img) {
                                profileHTML = `<img src="${comments.profile_img}" alt="Profile Picture" class="rounded-circle" style="width: 30px; height: 30px;"> ${comments.emp_name}`;
                            } else {
                                profileHTML = `<span class="rounded-circle d-inline-flex justify-content-center align-items-center" 
                                style="width: 30px; height: 30px; background-color: ${comments.profile_color}; color: white; font-weight: bold;">${comments.profile_letters}</span> ${comments.emp_name}`;
                            }

                            commentsHtml += `<div class="comment-card p-3 border-bottom" style="background-color: rgba(233,237,241,0.4);">
                                <div class="d-flex justify-content-between align-items-center ml-2" style="font-size: 16px; font-weight: 700 !important;">
                                    <span>${comment.announcement_comments}</span>
                                    <i class="fa-solid fa-x mr-2" style="cursor: pointer;" onclick="deletecomment(${comment.comment_id})"></i>
                                </div>

                                <div class="d-flex mt-3 ml-2">
                                    <div class="d-flex flex-column text-muted fw-bold d-block mt-2" style="min-width: 0; font-weight: 700 !important;">
                                        <span>By</span>
                                        <div class="profile mt-1">
                                            ${profileHTML}
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column text-end" style="margin-left: 100px;min-width: 0;">
                                        <span class="text-muted fw-bold d-block mt-2" style="font-weight: 700 !important;">Date &amp; Time</span>
                                        <span class="oh-timeoff-modal__stat-title mt-1">
                                            on <span class="dateformat_changer">${comment.posted_date}</span> at <span class="timeformat_changer">${comment.posted_time}</span>
                                        </span>
                                    </div>
                                </div>
                            </div>`;

                        });
                        document.getElementById("announcement_comments").innerHTML = commentsHtml;
                    }
                    else {
                        document.getElementById("announcement_comments").innerHTML = "<p>No comments yet.</p>";
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

        function deletecomment(comment_id) {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/deletecomment',
                data: JSON.stringify({ comment_id: comment_id }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    if (response == "false") {
                        Swal.fire("issue while deleting comment");
                    } else {
                        document.getElementById("comment_alert").innerText = "Your comment was deleted.";
                        $('#successAlert').removeClass('fade show').css('display', 'none');
                        $('#successAlert').fadeIn('slow').addClass('show').css('display', 'block');
                        populatecomments();
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

    </script>

</body>

</html>

