<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="policies.aspx.cs" Inherits="hrms.policies" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Policies</title>

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
            margin-left: 20px;
            margin-right: 20px;
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
    <input type="hidden" id="policy_id" name="policy_id" />

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
            <div class="d-flex align-items-center justify-content-between bg-light p-3 mt-4 ml-4 mr-4">
                <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.5rem;" class="m-0">Policies</h1>
                <button id="createPolicies" class="btn btn-outline-custom onlyhighaccesslvl" style="outline: none; border: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;"
                    onclick="opencreatepolicymodal()" data-toggle="modal" data-target="#createpolicymodal" title="Create">
                    <i class="fa fa-plus"></i>&nbsp;Create
               
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="row mt-3 ml-2 mr-2" id="policyContainer"></div>
                </div>
                <%-- createpolicymodal --%>
                <div class="modal fade pt-5" id="createpolicymodal" tabindex="-1" role="dialog" aria-labelledby="createpolicymodalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" style="max-width: 40%; margin: 0 auto;">
                        <div class="modal-content" style="border-radius: 0px !important; width: 100%;">
                            <div class="modal-header" style="padding: 1.50rem 1.70rem 1rem; height: 30px; background-color: transparent; border-bottom: none;">
                                <h2 class="modal-title" id="createpolicymodalLabel" style="font: normal 80%/1.4 sans-serif; font-size: 1.10rem; font-weight: 600; color: #4f4a4a;">Create Policy</h2>
                                <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body createannouncementfields">
                                <div class="mx-2 mb-2" style="color: hsl(0, 0%, 11%); font-weight: 500; background-color: hsl(0,0%,100%); border: 1px solid hsl(213,22%,84%); padding: 1.2rem;">
                                    <div class="form-group">
                                        <label for="policy_name">Policy:</label>
                                        <input type="text" name="title" class="form-control" id="policy_name" placeholder="Title" maxlength="100" />
                                    </div>
                                    <div class="form-group">
                                        <label for="id_description">Description:</label>
                                        <textarea id="id_description" class="form-control"></textarea>
                                    </div>
                                    <div class="text-right">
                                        <button onclick="createpolicy()" id="createpolicybtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">save</button>
                                        <button onclick="editpolicy()" id="editpolicybtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">edit</button>
                                    </div>
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
            if ($("#emp_access_lvl").val() != "true") {
                document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                    element.style.display = 'none';
                });
            }

            populatepolicies();

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

        function populatepolicies() {
            $.ajax({
                type: "POST",
                url: "policies.aspx/populatepolicies",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
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
                    let policies = response.d;
                    let html = "";
                    policies.forEach((p, i) => {
                        if (i % 4 === 0) html += '<div class="w-100"></div>';
                        html += `<div class="col-md-3 policy_${p.policy_id}" style="margin-bottom:35px;">
                                    <div class="card p-3" style="height: 500px; display: flex; flex-direction: column;">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="m-0"><span style="color: green; font-size:0.5rem"><i class="fa-solid fa-circle mr-2"></i></span>${p.policy_name}</h5>
                                            <div class="onlyhighaccesslvl">
                                                <i class="fa-sharp fa-solid fa-pen-to-square m-0" style="cursor: pointer;" onclick="openeditpolicy(${p.policy_id}, '${p.policy_name}', '${encodeURIComponent(p.description)}')"></i>
                                                <i class="fa-solid fa-trash-can m-0 ml-2" style="cursor: pointer;" onclick="deletepolicy(${p.policy_id})"></i>
                                            </div>
                                        </div>
                                        <span class="card-text mb-3" style="flex-grow: 1; overflow-y: auto; max-height: 80%;">${p.description}</span>
                                        <button onclick="viewPolicy('${p.policy_name}', '${encodeURIComponent(p.description)}')"
                                            style="margin-top: auto; border: none; outline: none; width: 100%; height: 40px; border-radius: 0; background-color: hsl(8, 77%, 56%);" class="btn btn-success btn-sm">
                                            View policy</button>
                                    </div>
                                </div>`;
                    });
                    $("#policyContainer").html(html);

                    if ($("#emp_access_lvl").val() != "true") {
                        document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                            element.style.display = 'none';
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

        function viewPolicy(title, description) {
            $("#descriptionModalLabel").text(title);
            $("#fullDescriptionContent").html(decodeURIComponent(description));
            $("#descriptionModal").modal("show");
        }

        function opencreatepolicymodal() {
            $("#policy_name").val('');
            $('#id_description').summernote('code', '');
            $('#createpolicybtn').show();
            $('#editpolicybtn').hide();
        }

        function createpolicy() {
            const policy_name = $('#policy_name').val();
            const description = $('#id_description').summernote('code');

            if ((!policy_name) ||
                (!description || description === "<p><br></p>")) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill in all the required fields before proceeding.",
                    icon: "warning"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: 'policies.aspx/createpolicy',
                data: JSON.stringify({ policy_name: policy_name, description: description }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    $('#createpolicymodal').modal('hide');
                    display_green_alert(response.d);
                    populatepolicies();
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

        function openeditpolicy(policy_id, policy_name, description) {
            $("#policy_id").val(policy_id);
            $("#policy_name").val(policy_name);
            $('#id_description').summernote('code', decodeURIComponent(description));
            $('#createpolicybtn').hide();
            $('#editpolicybtn').show();
            $('#createpolicymodal').modal('show');
        }

        function editpolicy() {
            const policy_id = $("#policy_id").val();
            const policy_name = $('#policy_name').val();
            const description = $('#id_description').summernote('code');

            if ((!policy_name) ||
                (!description || description === "<p><br></p>")) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill in all the required fields before proceeding.",
                    icon: "warning"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: "policies.aspx/editpolicy",
                data: JSON.stringify({ policy_id: policy_id, policy_name: policy_name, description: description }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    display_green_alert(response.d);
                    $('#createpolicymodal').modal('hide');
                    populatepolicies();
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

        function deletepolicy(policy_id) {
            Swal.fire({
                title: "Are you sure?",
                text: "This policy will be permanently deleted!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "Yes, delete it!"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: "policies.aspx/deletepolicy",
                        data: JSON.stringify({ policy_id: policy_id }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            display_green_alert(response.d);
                            populatepolicies();
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
