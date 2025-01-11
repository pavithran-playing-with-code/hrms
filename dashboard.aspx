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
            animation: slideInFromRight 0.5s ease-out; /* Fast slide-in */
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
    </style>

</head>
<body style="background-color: #f8f9fa">
    <div id="greenAlert" style="display: none; align-items: center;" class="alert alert-success alert-dismissible fade alert-custom" role="alert">
        <strong><i class="fa-sharp fa-solid fa-circle-exclamation ml-1 mr-3"></i></strong>Success message here.
    </div>

    <input type="hidden" id="announcement_id" name="announcement_id" />
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
                    <%--code--%>
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
                                                class="btn btn-outline-custom ms-3" onclick="opencreateannouncementmodal()" title="Create Announcement">
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
                                        <div class="announcement-body" id="announcementListCard2" style="height: 300px; border: none;">
                                            <div id="empty_leave" style="padding-top: 30%">
                                                <p class="empty_message">
                                                    <img style="display: block; width: 70px; margin: 20px auto;" src="\asset\attendance.png" />
                                                    No employees have taken leave today.
                                                </p>
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
                                <i class="fa-solid fa-ellipsis-vertical"></i>
                            </div>
                            <span class="text-muted fw-bold d-block mt-2">
                                <small style="font-weight: bold;">Posted on <span class="dateformat_changer" id="posted_date"></span>
                                    at <span class="timeformat_changer" id="posted_time"></span></small>
                            </span>
                        </div>
                        <div class="card-body">
                            <spam class="card-text" id="announcement_description"></spam>
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
    <div class="modal fade pt-5" id="createannouncementmodal" tabindex="-1" aria-labelledby="createannouncementmodalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg mx-auto" style="max-width: 41%; margin: 0 auto;">
            <div class="modal-content" style="border-radius: 0px !important; width: 100%;">
                <div class="modal-header" style="padding: 1.50rem 1.70rem 1rem; height: 30px; background-color: transparent; border-bottom: none;">
                    <h2 class="modal-title" id="createannouncementmodalLabel" style="font: normal 80%/1.4 sans-serif; font-size: 1.10rem; font-weight: 600; color: #4f4a4a;">Create Announcements.</h2>
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
                        <div class="form-group">
                            <label for="id_attachments">Attachments:</label>
                            <input type="file" name="attachments" class="attachment_file ml-1 mt-2" id="id_attachments" />
                        </div>
                        <div class="form-group">
                            <label for="id_expire_date">Expire Date:</label>
                            <input type="date" name="expire_date" class="form-control" id="id_expire_date" />
                        </div>
                        <div class="form-group">
                            <label for="id_employees">Employees:</label>
                            <select name="employees" class="form-control select2" id="id_employees" multiple="multiple"></select>
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
                            <label for="id_disable_comments" class="form-check-label">Disable Comments:</label>
                            <input type="checkbox" name="disable_comments" class="form-check-input ml-2 mt-2" id="id_disable_comments" />
                        </div>
                        <div class="text-right">
                            <button onclick="saveannouncement()" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--  <div class="oh-404" style="position:revert; transform:none">
                        <img style="width: 80px;height: 80px; margin-bottom:20px"
                            src="{% static 'images/ui/no-announcement.svg' %}" class="oh-404__image"
                            alt="Page not found. 404." />
                        <h5 class="oh-404__subtitle">{% trans "No Announcements to show." %}</h5>
                    </div> --%>

    <script>
        $(document).ready(function () {
            if (sessionStorage.getItem('showAlert') === 'true') {
                display_login_alert();
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
            populate_announncements();
        });

        function opencreateannouncementmodal() {
            populatecreateannouncementmodal();
            $('#createannouncementmodal').modal('show');
            document.getElementById('id_expire_date').value = new Date().toISOString().split('T')[0];
        }

        function display_login_alert() {
            document.getElementById("greenAlert").style.display = 'flex';
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

        function populate_announncements() {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populate_announncements',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    if (Array.isArray(data) && data.length > 0) {
                        let announcementsHTML = '';
                        data.forEach(announcement => {
                            const announcement_id = announcement.announcement_id;
                            const profileImage = announcement.profile_img;
                            const profileLetters = announcement.profile_letters;
                            const profileColor = announcement.profile_color;
                            const heading = announcement.heading;

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
                        announcementsHTML = "";
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
            $('#announcement_info_modal').modal('show');

            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/openannouncementmodal',
                data: JSON.stringify({ announcement_id: announcement_id }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    const announcementList = JSON.parse(cleanedResponse);

                    if (announcementList.length > 0) {
                        const announcement = announcementList[0];

                        document.getElementById("heading").innerText = announcement.heading;
                        document.getElementById("viewed_by").innerText = announcement.viewed_by;
                        document.getElementById("posted_date").innerText = announcement.posted_date;
                        document.getElementById("posted_time").innerText = announcement.posted_time;
                        document.getElementById("announcement_description").innerText = announcement.announcement_description;
                        document.getElementById("comments_header").innerText = announcement.heading + " comments";
                        $("#announcement_id").val(announcement_id);
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

        function populatecreateannouncementmodal() {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populatecreateannouncementmodal',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);

                    $('#id_employees, #id_department, #id_job_position').select2({
                        placeholder: "Select an option",
                        allowClear: true
                    });

                    const employeesDropdown = $('#id_employees');
                    employeesDropdown.empty();
                    data.Employees.forEach(employee => {
                        employeesDropdown.append(new Option(employee, employee));
                    });

                    const departmentsDropdown = $('#id_department');
                    departmentsDropdown.empty();
                    data.Departments.forEach(department => {
                        departmentsDropdown.append(new Option(department.DepartmentName, department.DepartmentName));
                    });

                    const jobPositionDropdown = $('#id_job_position');
                    jobPositionDropdown.empty();
                    data.Departments.forEach(department => {
                        jobPositionDropdown.append(new Option(department.JobPosition, department.JobPosition));
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

        function saveannouncement() {
            const title = $('#id_title').val();
            const description = $('#id_description').val();
            const attachments = $('#id_attachments').val();
            const expireDate = $('#id_expire_date').val();
            const employees = $('#id_employees').val();
            const department = $('#id_department').val();
            const jobPosition = $('#id_job_position').val();
            const disableComments = $('#id_disable_comments').is(':checked');


            $('#id_title').val('');
            $('#id_description').summernote('code', '');
            $('#id_attachments').val('');
            $('#id_employees').val(null).trigger('change');
            $('#id_department').val(null).trigger('change');
            $('#id_job_position').val(null).trigger('change');
            $('#id_disable_comments').prop('checked', false);

            $('#createannouncementmodal').modal('hide');
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

