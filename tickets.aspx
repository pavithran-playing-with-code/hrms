<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tickets.aspx.cs" Inherits="hrms.tickets" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Help Desk</title>

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

        #Quickaction-container {
            position: fixed;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
        }

        .table.dataTable thead th {
            background-color: white !important;
        }

        .table.table-striped.table-bordered th,
        .table.table-striped.table-bordered td {
            border-color: white !important;
        }

        .table.table-striped.table-bordered {
            border-color: white !important;
        }

        #TicketsTable_length select,
        #SuggestedTicketsTable_length select {
            border: 1px solid #aaa;
            background-color: transparent;
            padding: 4px;
        }

        #TicketsTable_filter input,
        #SuggestedTicketsTable_filter input {
            border: 1px solid #aaa;
            border-radius: 3px;
            padding: 5px;
            background-color: transparent;
            margin-left: 3px;
        }

        #TicketsTable th,
        #SuggestedTicketsTable th {
            white-space: nowrap;
        }

        #TicketsTable td,
        #SuggestedTicketsTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
            background-color: #f8f9fa !important;
        }

            #TicketsTable td button,
            #SuggestedTicketsTable td button {
                margin-right: 5px;
                margin-bottom: 5px;
                white-space: nowrap;
            }


        .form-group {
            flex: 1;
            min-width: 150px;
        }

        .select2-container--default .select2-selection--multiple {
            height: 38px !important;
            border: 1px solid #ced4da;
            border-radius: 5px;
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

        .createticketfields .form-control,
        .createticketfields select,
        .createticketfields textarea,
        .createticketfields input[type="file"],
        .createticketfields button {
            border-radius: 0 !important;
        }

        .active-tab {
            font-weight: bold;
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

        .hidden {
            display: none !important;
        }
    </style>
</head>
<body style="background-color: #f8f9fa">

    <input type="hidden" id="emp_access_lvl" name="emp_access_lvl" runat="server" />
    <input type="hidden" id="edit_ticket_id" name="edit_ticket_id" />
    <input type="hidden" id="edited_ticket_type_id" name="edited_ticket_type_id" />
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
                <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.5rem;" class="m-0">Tickets</h1>
                <div id="dataTableControls" class="d-flex align-items-center ml-auto mr-4 mt-2" style="gap: 20px;"></div>
                <button id="createTickets" class="btn btn-outline-custom"
                    style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;"
                    onclick="opencreateticketmodal()" title="Create Tickets">
                    <i class="fa fa-plus"></i>&nbsp;Create
         
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card mx-auto mb-5" style="border: 1px solid lightgrey; border-radius: 10px; box-shadow: 2px 2px 2px grey;">
                        <div class="card-header d-flex w-100 p-0 ticket_card_header" style="background-color: transparent;">
                            <div id="myTicketsTab" class="w-50 d-flex justify-content-center align-items-center fw-bold py-2 active-tab"
                                style="border-right: 1px solid gray; cursor: pointer;">
                                My Tickets
       
                            </div>
                            <div id="suggestedTicketsTab" class="w-50 d-flex justify-content-center align-items-center fw-bold py-2"
                                style="color: gray; cursor: pointer;">
                                Suggested Tickets
       
                            </div>
                        </div>
                        <div class="card-body">
                            <div id="TicketsTableContainer">
                                <table id="TicketsTable" class="table table-striped table-bordered" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Tickets ID</th>
                                            <th>Employee ID</th>
                                            <th>Employee Name</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Attachments</th>
                                            <th>Ticket Type</th>
                                            <th>Priority</th>
                                            <th>Status</th>
                                            <th>Status History</th>
                                            <th>Assignee</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div id="SuggestedTicketsTableContainer" style="display: none">
                                <table id="SuggestedTicketsTable" class="table table-striped table-bordered" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Tickets ID</th>
                                            <th>Employee ID</th>
                                            <th>Created By</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Attachments</th>
                                            <th>Ticket Type</th>
                                            <th>Priority</th>
                                            <th>Status</th>
                                            <th>Status History</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div id="createTicketTypes">
                        <div class="d-flex align-items-center justify-content-between bg-light p-2 mt-4 mb-4 mr-3">
                            <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.5rem;" class="m-0">Ticket Types</h1>
                        </div>
                        <div class="card p-3 mb-5" style="height: 500px; display: flex; flex-direction: column; border: 1px solid lightgrey; border-radius: 10px; box-shadow: 2px 2px 2px grey;">
                            <div class="d-flex flex-column align-items-center p-2 mb-3 mt-2">
                                <div class="d-flex justify-content-between w-100 px-2 mb-2">
                                    <div class="text-center w-25">
                                        <label for="newTicketType"><strong>Leave Type</strong></label>
                                    </div>
                                    <div class="text-center w-75">
                                        <label><strong>Assignee</strong></label>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between align-items-center w-100 px-2 onlyhighaccesslvl">
                                    <div class="form-group w-25">
                                        <input type="text" id="newTicketType" class="form-control" placeholder="Enter Ticket Type" />
                                    </div>
                                    <div class="d-flex w-75">
                                        <div class="form-group flex-grow-1 mx-1">
                                            <select name="department" class="form-control select2" id="id_department" multiple="multiple"></select>
                                        </div>
                                        <div class="form-group flex-grow-1 mx-1">
                                            <select name="job_position" class="form-control select2" id="id_job_position" multiple="multiple"></select>
                                        </div>
                                        <div class="form-group flex-grow-1 mx-1">
                                            <select name="employees" class="form-control select2" id="id_employees" multiple="multiple"></select>
                                        </div>
                                    </div>
                                    <div class="ml-2 d-flex align-items-center" style="margin-top: -15px;">
                                        <button id="create_ticket_type" class="btn btn-outline-custom"
                                            style="padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: hsl(8, 77%, 56%); color: white;"
                                            onclick="create_ticket_type()">
                                            Add
                                        </button>
                                        <button id="edit_ticket_type" class="btn btn-outline-custom"
                                            style="display: none; padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: hsl(8, 77%, 56%); color: white;"
                                            onclick="edit_ticket_type()">
                                            Save
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="card-text p-2 mt-1 mb-3" id="ticket_types_container" style="flex-grow: 1; overflow-y: auto; max-height: 80%;">
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

    <div class="modal fade pt-5" id="createticketmodal" tabindex="-1" aria-labelledby="createticketmodalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg mx-auto" style="max-width: 41%; margin: 0 auto;">
            <div class="modal-content" style="border-radius: 0px !important; width: 100%;">
                <div class="modal-header" style="padding: 1.50rem 1.70rem 1rem; height: 30px; background-color: transparent; border-bottom: none;">
                    <h2 class="modal-title" id="createticketmodalLabel" style="font: normal 80%/1.4 sans-serif; font-size: 1.10rem; font-weight: 600; color: #4f4a4a;"></h2>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body createticketfields">
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
                            <label for="ticket_type">Ticket Type:</label>
                            <select name="ticket_type" class="form-control select2" id="ticket_type"></select>
                        </div>
                        <div class="form-group">
                            <label for="ticket_type_assignee">Assignee:</label>
                            <input type="text" class="form-control" id="ticket_type_assignee" disabled="disabled" />
                        </div>
                        <div class="form-group">
                            <label for="priority">Priority:</label>
                            <select name="priority" class="form-control select2" id="priority">
                                <option value="1">High</option>
                                <option value="2">Medium</option>
                                <option value="3">Low</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select name="status" class="form-control select2" id="status">
                                <option value="New">New</option>
                                <option value="In Progress">In Progress</option>
                                <option value="Resolved">Resolved</option>
                                <option value="Hold">Hold</option>
                                <option value="Canceled">Cancel</option>
                            </select>
                        </div>
                        <div class="text-right">
                            <button onclick="create_edit_ticket('edit')" id="editticketbtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Edit</button>
                            <button onclick="create_edit_ticket('add')" id="saveticketbtn" class="btn btn-primary ml-2" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Save</button>
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

    <div class="modal fade" id="status_historyModal" tabindex="-1" role="dialog" aria-labelledby="status_historyModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header mt-1 pb-2" style="background-color: transparent; border-bottom: none;">
                    <h5 class="modal-title ml-1" id="status_historyModalLabel">Full status_history</h5>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="card mx-auto p-2 mb-4" style="max-width: 800px; border: 1px solid lightgrey; border-radius: 10px; box-shadow: 2px 2px 2px grey;">
                        <div class="card-body">
                            <spam class="card-text" id="fullstatus_historyContent"></spam>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            if ($("#emp_access_lvl").val() == "true") {
                document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                    element.classList.remove('hidden');
                });
            }
            else {
                document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                    element.classList.add('hidden');
                });
            }

            populatetickets();
            populate_suggested_tickets();

            $("#myTicketsTab").click(function () {
                $("#TicketsTableContainer").css("display", "block");
                $("#SuggestedTicketsTableContainer").css("display", "none");
                $("#myTicketsTab").addClass("active-tab").css("color", "black");
                $("#suggestedTicketsTab").removeClass("active-tab").css("color", "gray");
                $('#TicketsTable').DataTable().columns.adjust().draw();
            });

            $("#suggestedTicketsTab").click(function () {
                $("#TicketsTableContainer").css("display", "none");
                $("#SuggestedTicketsTableContainer").css("display", "block");
                $("#suggestedTicketsTab").addClass("active-tab").css("color", "black");
                $("#myTicketsTab").removeClass("active-tab").css("color", "gray");
                $('#SuggestedTicketsTable').DataTable().columns.adjust().draw();
            });

            populate_ticket_type();
            populatecreateticketmodal("department", null, null);
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        function opencreateticketmodal() {
            clearcreateticketmodalFields();
            document.getElementById('createticketmodalLabel').innerText = "Create Tickets.";
            $('#saveticketbtn').show();
            $('#editticketbtn').hide();
            $('#createticketmodal').modal('show');
        }

        document.getElementById('remove_attachment_btn').addEventListener('click', function () {
            $('#id_attachments').val('');
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

        function clearcreateticketmodalFields() {
            $("#id_title").val("");
            $("#id_description").val("");
            $("#id_attachments").val("");
            $("#id_attachments_helper_value").val("");
            $("#id_attachments_hidden_value").val("");
            $("#ticket_type").val(null).trigger("change");
            $("#ticket_type_assignee").val("");
            $("#priority").val("high").trigger("change");
            $("#status").val("new").trigger("change");
            $("#remove_attachment_btn").hide();
        }

        function populatetickets() {
            $.ajax({
                type: "POST",
                url: 'tickets.aspx/populatetickets',
                data: JSON.stringify({ from: "mytickets" }),
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

                    if ($.fn.DataTable.isDataTable('#TicketsTable')) {
                        $('#TicketsTable').DataTable().clear().destroy();
                    }

                    $('#TicketsTable').DataTable({
                        data: data,
                        scrollX: true,
                        scrollCollapse: true,
                        fixedColumns: {
                            rightColumns: 1
                        },
                        columns: [
                            { data: 'ticket_id', visible: false },
                            { data: 'emp_id', visible: false },
                            { data: 'emp_name' },
                            { data: 'title' },
                            {
                                data: 'ticket_description',
                                render: function (data) {
                                    return `<a href="#" class="description-link" data-description='${data}'>View Description</a>`;
                                }
                            },
                            {
                                data: 'attachments',
                                render: function (data) {
                                    if (!data || data.trim() === "") {
                                        return "<span style='color:gray'>No attachments</span>";
                                    }
                                    const attachmentParts = data.split('/').pop().split('_');
                                    const originalFileName = attachmentParts.slice(2).join('_');
                                    return `<a href="${data}" target="_blank">${originalFileName}</a>`;
                                }
                            },
                            { data: 'ticket_type' },
                            {
                                data: 'priority',
                                render: function (data) {
                                    if (data == "1") {
                                        return `<span>High</span>`;
                                    }
                                    else if (data == "2") {
                                        return `<span>Medium</span>`;
                                    }
                                    else if (data == "3") {
                                        return `<span>Low</span>`;
                                    }
                                    return `<span style="color: red;font-weight: bold;">Issue</span>`;
                                }
                            },
                            {
                                data: 'ticket_status',
                                render: function (data) {
                                    if (data == "New") {
                                        return `<span style="color: dodgerblue;font-weight: bold;">New</span>`;
                                    }
                                    else if (data == "In Progress") {
                                        return `<span style="color: orange;font-weight: bold;">In Progress</span>`;
                                    }
                                    else if (data == "Hold") {
                                        return `<span style="color: gray;font-weight: bold;">Hold</span>`;
                                    }
                                    else if (data == "Resolved") {
                                        return `<span style="color: green;font-weight: bold;">Resolved</span>`;
                                    }
                                    else if (data == "Canceled") {
                                        return `<span style="color: red;font-weight: bold;">Canceled</span>`;
                                    }
                                    return `<span style="color: red;font-weight: bold;">Issue</span>`;
                                }
                            },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    return `<a href="#" class="status_history" onclick="status_history('${row.ticket_id}')">View status history</a>`;
                                }
                            },
                            { data: 'assignee' },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    if (row.ticket_status === "New") {
                                        return `<div class="btn-group w-100" role="group">
                                                    <button class="btn btn-warning btn-sm edit-btn w-50"
                                                    onclick="open_edit_ticket('${row.ticket_id}', '${row.title}', '${encodeURIComponent(row.ticket_description)}', '${encodeURIComponent(row.attachments)}', 
                                                    '${row.ticket_type_id}', '${row.priority}', '${row.ticket_status}')">Edit</button>
                                                    <button class="btn btn-danger btn-sm delete-btn w-50" onclick="delete_ticket_and_type('${row.ticket_id}', 'tickets')">Delete</button>
                                                </div>`;
                                    } else {
                                        let statusText = row.ticket_status;
                                        let statusColor = "";

                                        switch (row.ticket_status) {
                                            case "In Progress":
                                                statusColor = "orange";
                                                break;
                                            case "Hold":
                                                statusColor = "gray";
                                                break;
                                            case "Resolved":
                                                statusColor = "green";
                                                break;
                                            case "Canceled":
                                                statusColor = "red";
                                                break;
                                            default:
                                                statusText = "Issue";
                                                statusColor = "red";
                                                break;
                                        }

                                        return `<span style="color: ${statusColor}; font-weight: bold;">${statusText}</span>`;
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
                  <img src="/asset/img/no-tickets.jpg" alt="No data available" style="max-width: 200px; margin-top: 20px;">
                  <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
                                  </div>`
                        }
                    });

                    $('#TicketsTable').on('click', '.description-link', function (e) {
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
                        data: JSON.stringify({ fileName: file.name, fileData: base64File, where: "tickets" }),
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

        async function create_edit_ticket(action) {
            const id_title = $('#id_title').val();
            const id_description = $('#id_description').val();
            const ticket_type = $('#ticket_type').val();
            const priority = $('#priority').val();
            const status = $('#status').val();
            let attachments = '';
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

            if ((!id_title) || (!id_description) || (!ticket_type) || (!priority) || (!status)) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill the ticket type field before proceeding.",
                    icon: "warning"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: 'tickets.aspx/create_edit_ticket',
                data: JSON.stringify({ action: action, ticket_id: action === "edit" ? $('#edit_ticket_id').val() : null, id_title: id_title, id_description: id_description, attachments: attachments, ticket_type: ticket_type, priority: priority, status: status }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    $('#createticketmodal').modal('hide');
                    display_green_alert(response.d);
                    populatetickets();
                    clearcreateticketmodalFields();
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

        function open_edit_ticket(ticket_id, title, description, attachments, ticket_type_id, priority, status) {
            clearcreateticketmodalFields();
            document.getElementById('createticketmodalLabel').innerText = "Edit Tickets.";
            $('#saveticketbtn').hide();
            $('#editticketbtn').show();
            $('#createticketmodal').modal('show');

            $("#edit_ticket_id").val(ticket_id);
            $("#id_title").val(title);
            $("#id_description").val(decodeURIComponent(description));

            var decoded_attachments = decodeURIComponent(attachments);
            if (decoded_attachments) {
                const attachmentParts = decoded_attachments.split('/').pop().split('_');
                const originalFileName = attachmentParts.slice(2).join('_');
                document.getElementById('id_attachments_helper').style.display = 'block';
                document.getElementById('remove_attachment_btn').style.display = 'block';
                document.getElementById('id_attachments_helper').innerHTML = `<span style="font-weight:400">Existing File: ${originalFileName}</span>`;
                $('#id_attachments_helper_value').val(decoded_attachments);
                $('#id_attachments_hidden_value').val(decoded_attachments);
            }

            $("#ticket_type").val(ticket_type_id).trigger("change");
            $("#priority").val(priority).trigger("change");
            $("#status").val(status).trigger("change");

        }

        function populate_suggested_tickets() {
            $.ajax({
                type: "POST",
                url: 'tickets.aspx/populatetickets',
                data: JSON.stringify({ from: "suggestedtickets" }),
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

                    if (data.length == 0) {
                        document.querySelectorAll('.ticket_card_header').forEach(function (element) {
                            element.classList.add('hidden');
                        });
                    }
                    else {
                        if ($.fn.DataTable.isDataTable('#SuggestedTicketsTable')) {
                            $('#SuggestedTicketsTable').DataTable().clear().destroy();
                        }

                        $('#SuggestedTicketsTable').DataTable({
                            data: data,
                            scrollX: true,
                            scrollCollapse: true,
                            fixedColumns: {
                                rightColumns: 1
                            },
                            columns: [
                                { data: 'ticket_id', visible: false },
                                { data: 'emp_id', visible: false },
                                { data: 'emp_name' },
                                { data: 'title' },
                                {
                                    data: 'ticket_description',
                                    render: function (data) {
                                        return `<a href="#" class="description-link" data-description='${data}'>View Description</a>`;
                                    }
                                },
                                {
                                    data: 'attachments',
                                    render: function (data) {
                                        if (!data || data.trim() === "") {
                                            return "<span style='color:gray'>No attachments</span>";
                                        }
                                        const attachmentParts = data.split('/').pop().split('_');
                                        const originalFileName = attachmentParts.slice(2).join('_');
                                        return `<a href="${data}" target="_blank">${originalFileName}</a>`;
                                    }
                                },
                                { data: 'ticket_type' },
                                {
                                    data: 'priority',
                                    render: function (data) {
                                        if (data == "1") {
                                            return `<span>High</span>`;
                                        }
                                        else if (data == "2") {
                                            return `<span>Medium</span>`;
                                        }
                                        else if (data == "3") {
                                            return `<span>Low</span>`;
                                        }
                                        return `<span style="color: red;font-weight: bold;">Issue</span>`;
                                    }
                                },
                                {
                                    data: 'ticket_status',
                                    render: function (data) {
                                        if (data == "New") {
                                            return `<span style="color: dodgerblue;font-weight: bold;">New</span>`;
                                        }
                                        else if (data == "In Progress") {
                                            return `<span style="color: orange;font-weight: bold;">In Progress</span>`;
                                        }
                                        else if (data == "Hold") {
                                            return `<span style="color: gray;font-weight: bold;">Hold</span>`;
                                        }
                                        else if (data == "Resolved") {
                                            return `<span style="color: green;font-weight: bold;">Resolved</span>`;
                                        }
                                        else if (data == "Canceled") {
                                            return `<span style="color: red;font-weight: bold;">Canceled</span>`;
                                        }
                                        return `<span style="color: red;font-weight: bold;">Issue</span>`;
                                    }
                                },
                                {
                                    data: null,
                                    render: function (data, type, row) {
                                        return `<a href="#" class="status_history" onclick="status_history('${row.ticket_id}')">View status history</a>`;
                                    }
                                },
                                {
                                    data: null,
                                    render: function (data, type, row) {
                                        let statusButtons = `
                            ${row.ticket_status !== "In Progress" ? `<button class="btn btn-sm btn-warning" onclick="updateTicketStatus('${row.ticket_id}', 'In Progress')">In Progress</button>` : ""}
                            ${row.ticket_status !== "Hold" ? `<button class="btn btn-sm btn-secondary" onclick="updateTicketStatus('${row.ticket_id}', 'Hold')">Hold</button>` : ""}
                            ${row.ticket_status !== "Resolved" ? `<button class="btn btn-sm btn-success" onclick="updateTicketStatus('${row.ticket_id}', 'Resolved')">Resolved</button>` : ""}
                            ${row.ticket_status !== "Canceled" ? `<button class="btn btn-sm btn-danger" onclick="updateTicketStatus('${row.ticket_id}', 'Canceled')">Canceled</button>` : ""}
                        `;

                                        return `<div class="btn-group w-100">
            <button class="btn btn-primary btn-sm w-100 status-btn" data-ticket-id="${row.ticket_id}">
                Change Status
            </button>
        </div>
        <div class="status-options d-none mt-2" id="status-options-${row.ticket_id}">
            ${statusButtons.trim() ? statusButtons : "<span class='text-muted'>No actions available</span>"}
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
<img src="/asset/img/no-tickets.jpg" alt="No data available" style="max-width: 200px; margin-top: 20px;">
<p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
                </div>`
                            }
                        });

                        $('#SuggestedTicketsTable').on('click', '.description-link', function (e) {
                            e.preventDefault();
                            const description = $(this).data('description');
                            const heading = $(this).closest('tr').find('td').eq(1).text();
                            $('#descriptionModalLabel').text(heading);
                            $('#fullDescriptionContent').html(description);
                            $('#descriptionModal').modal('show');
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

        function status_history(ticket_id) {
            $.ajax({
                type: "POST",
                url: "tickets.aspx/status_history",
                data: JSON.stringify({ ticket_id: ticket_id }),
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

                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    let status_history = JSON.parse(cleanedResponse);

                    let historyHtml = "";
                    if (status_history.length > 0) {
                        historyHtml += `<table class="table table-bordered text-center">
                                    <thead>
                                        <tr>
                                            <th>Status</th>
                                            <th>Updated By</th>
                                            <th>Updated Time</th>
                                        </tr>
                                    </thead>
                                    <tbody>`;
                        status_history.forEach(item => {
                            historyHtml += `<tr>
                                        <td>${item.status_update}</td>
                                        <td>${item.emp_name}</td>
                                        <td>${item.updated_time}</td>
                                    </tr>`;
                        });

                        historyHtml += `</tbody></table>`;
                    } else {
                        historyHtml = `<p class="text-center text-muted">No status history available</p>`;
                    }

                    $('#status_historyModalLabel').text("Status History");
                    $('#fullstatus_historyContent').html(historyHtml);
                    $('#status_historyModal').modal('show');
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

        $(document).on('click', '.status-btn', function () {
            let ticketId = $(this).data('ticket-id');
            $(`#status-options-${ticketId}`).toggleClass('d-none');
        });

        function updateTicketStatus(ticketId, status) {
            Swal.fire({
                title: "Are you sure?",
                html: `<span style="white-space: nowrap;">You are about to change the ticket status to "<strong>${status}</strong>".</span>`,
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, update it!",
                cancelButtonText: "Cancel"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: 'tickets.aspx/updateTicketStatus',
                        data: JSON.stringify({ ticketId: ticketId, status: status }),
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
                            display_green_alert(response.d);
                            populate_suggested_tickets();
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

        function populatecreateticketmodal(dropdowntype, value, departmentValues, callback) {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/PopulateCreateAnnouncementModal',
                data: JSON.stringify({ dropdowntype: dropdowntype, value: value, departmentValues: departmentValues }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);
                    $('#id_department').select2({
                        placeholder: "Department",
                        allowClear: true,
                        width: "100%",
                    });
                    $('#id_job_position').select2({
                        placeholder: "Job Position",
                        allowClear: true,
                        width: "100%",
                    });
                    $('#id_employees').select2({
                        placeholder: "Employee",
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
                populatecreateticketmodal("job_position", selectedDepartments, null);
            }
        });

        $('#id_job_position').on('change', function () {
            const selectedJobPositions = $(this).val();
            const selectedDepartments = $('#id_department').val();
            if (selectedJobPositions != "" && selectedDepartments != "") {
                populatecreateticketmodal("employees", selectedJobPositions, selectedDepartments);
            }
        });

        function populate_ticket_type() {
            $.ajax({
                type: "POST",
                url: "tickets.aspx/populate_ticket_type",
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
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    let ticket_types = JSON.parse(cleanedResponse);

                    let ticketTypeDropdown = $("#ticket_type");
                    ticketTypeDropdown.empty().append('<option selected="selected" disabled="disabled" value="">Select Ticket Type</option>');

                    let ticketTypeMap = {};

                    ticket_types.forEach((tt) => {
                        ticketTypeDropdown.append(`<option value="${tt.ticket_type_id}">${tt.ticket_type}</option>`);
                        ticketTypeMap[tt.ticket_type_id] = tt.emp_name;
                    });

                    ticketTypeDropdown.off("change").on("change", function () {
                        let selectedTicketTypeId = $(this).val();
                        let assigneeName = ticketTypeMap[selectedTicketTypeId] || "";
                        $("#ticket_type_assignee").val(assigneeName);
                    });

                    let html = "";
                    ticket_types.forEach((tt) => {
                        html += `<div class="d-flex align-items-center mb-4 ml-2 ticket_type_div_${tt.ticket_type_id}" style="width: 95%;">
                                     <div class="d-flex flex-grow-1 ml-4">
                                         <input type="text" class="form-control mx-1" value="${tt.ticket_type}" disabled="disabled" style="width: 25%;" />
                                         <input type="text" class="form-control mx-1" value="${tt.department_name}" disabled="disabled" style="width: 25%;" />
                                         <input type="text" class="form-control mx-1" value="${tt.job_position_name}" disabled="disabled" style="width: 25%;" />
                                         <input type="text" class="form-control mx-1" value="${tt.emp_name}" disabled="disabled" style="width: 25%;" />
                                     </div>
                                     <div class="d-flex align-items-center ml-2 onlyhighaccesslvl">
                                         <i class="fa-sharp fa-solid fa-pen-to-square edit_icon" style="cursor: pointer;"
                                         onclick="enableeditbtn('${tt.ticket_type_id}', '${tt.ticket_type}', '${tt.departments}', '${tt.job_positions}', '${tt.assignee}')"></i>
                                         <i class="fa-solid fa-x close_icon ml-3" style="display: none; cursor: pointer;"
                                         onclick="disableeditbtn('${tt.ticket_type_id}')"></i>
                                         <i class="fa-solid fa-trash-can ml-3" style="cursor: pointer;" onclick="delete_ticket_and_type('${tt.ticket_type_id}', 'ticket_types')"></i>
                                     </div>
                                 </div>`;
                    });

                    $("#ticket_types_container").html(html);

                    if ($("#emp_access_lvl").val() == "true") {
                        document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                            element.classList.remove('hidden');
                        });
                    }
                    else {
                        document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                            element.classList.add('hidden');
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

        function create_ticket_type() {
            const newTicketType = $('#newTicketType').val();
            const assignee = $('#id_employees').val();

            if ((!newTicketType) || (!assignee)) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill the ticket type field before proceeding.",
                    icon: "warning"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: 'tickets.aspx/create_ticket_type',
                data: JSON.stringify({ newTicketType: newTicketType, assignee: assignee }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    display_green_alert(response.d);
                    populate_ticket_type();
                    clearfields();
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

        function enableeditbtn(ticket_type_id, ticket_type, edited_departments, edited_jobPositions, edited_assignee) {
            $("#edited_ticket_type_id").val(ticket_type_id);
            $("#newTicketType").val(ticket_type);
            const departments = edited_departments.split(',');
            populatecreateticketmodal('department', null, null, function () {
                $('#id_department').val(departments).trigger('change');

                populatecreateticketmodal('job_position', departments, departments, function () {
                    const jobPositions = edited_jobPositions.split(',');
                    $('#id_job_position').val(jobPositions).trigger('change');

                    populatecreateticketmodal('employees', jobPositions, departments, function () {
                        const employees = edited_assignee.split(',');
                        $('#id_employees').val(employees).trigger('change');
                    });
                });
            });

            $("#create_ticket_type").hide();
            $("#edit_ticket_type").show();
            $(".ticket_type_div_" + ticket_type_id + " .edit_icon").hide();
            $(".ticket_type_div_" + ticket_type_id + " .close_icon").show();
        }

        function disableeditbtn(ticket_type_id) {
            $("#create_ticket_type").show();
            $("#edit_ticket_type").hide();
            $(".ticket_type_div_" + ticket_type_id + " .edit_icon").show();
            $(".ticket_type_div_" + ticket_type_id + " .close_icon").hide();
            clearfields();
        }

        function edit_ticket_type() {
            const ticket_type_id = $("#edited_ticket_type_id").val();
            const newTicketType = $("#newTicketType").val();
            const assignee = $('#id_employees').val();

            if ((!newTicketType) || (!assignee)) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill the fields before proceeding.",
                    icon: "warning"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: "tickets.aspx/edit_ticket_type",
                data: JSON.stringify({ ticket_type_id: ticket_type_id, newTicketType: newTicketType, assignee: assignee }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    display_green_alert(response.d);
                    populate_ticket_type();
                    clearfields();
                    $("#create_ticket_type").show();
                    $("#edit_ticket_type").hide();
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

        function delete_ticket_and_type(id, table) {
            Swal.fire({
                title: "Are you sure?",
                text: "This ticket type will be permanently deleted!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "Yes, delete it!"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: "tickets.aspx/delete_ticket_and_type",
                        data: JSON.stringify({ id: id, table: table }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            display_green_alert(response.d);
                            if (table == "tickets") {
                                populatetickets();
                            }
                            else if (table == "ticket_types") {
                                populate_ticket_type();
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

        function clearfields() {
            $("#edited_ticket_type_id").val('');
            $("#newTicketType").val('');
            $('#id_employees').val(null).trigger('change');
            $('#id_department').val(null).trigger('change');
            $('#id_job_position').val(null).trigger('change');
        }

    </script>
</body>
</html>
