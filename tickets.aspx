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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <style>
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

        #Quickaction-container {
            position: absolute;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
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

    <input type="hidden" id="edited_ticket_id" name="edited_ticket_id" />
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
                    onclick="opencreateTicketsmodal()" title="Create Tickets">
                    <i class="fa fa-plus"></i>&nbsp;Create
         
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card-body p-3">
                        <table id="TicketssTable" class="table table-striped table-bordered" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Tickets ID</th>
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Department</th>
                                    <th>Job Position</th>
                                    <th>Heading</th>
                                    <th>Posted On</th>
                                    <th>Expire Date</th>
                                    <th>Description</th>
                                    <th>Attachments</th>
                                    <th>Comments</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div id="createTicketTypes">
                        <div class="onlyhighaccesslvl">
                            <div>
                                <div class="card p-3" style="height: 500px; display: flex; flex-direction: column;">
                                    <div class="d-flex mb-3">
                                        <h5 class="m-0">Ticket Types</h5>
                                    </div>

                                    <div class="d-flex flex-column align-items-center p-2 mb-3 mt-2">
                                        <div class="d-flex justify-content-between w-100 px-2 mb-2">
                                            <div class="text-center w-25">
                                                <label for="newTicketType"><strong>Leave Type</strong></label>
                                            </div>
                                            <div class="text-center w-75">
                                                <label><strong>Assignee</strong></label>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center w-100 px-2">
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
            </div>
        </div>
        <div id="Quickaction-container">
            <uc:Quick_action runat="server" />
        </div>
    </div>
    <script>
        $(document).ready(function () {
            /* if ($("#emp_access_lvl").val() != "true") {
                 document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                     element.style.display = 'none';
                 });
             }*/

            populate_ticket_type();
            populatecreateannouncementmodal("department", null, null);
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
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
                    $('#id_department').select2({
                        placeholder: "Department",
                        allowClear: true,
                        closeOnSelect: false,
                        width: "100%",
                    });
                    $('#id_job_position').select2({
                        placeholder: "Job Position",
                        allowClear: true,
                        closeOnSelect: false,
                        width: "100%",
                    });
                    $('#id_employees').select2({
                        placeholder: "Employee",
                        allowClear: true,
                        closeOnSelect: false,
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

                    let html = "";
                    ticket_types.forEach((tt) => {
                        html += `<div class="d-flex align-items-center mb-4 ml-2 ticket_type_div_${tt.ticket_type_id}" style="width: 95%;">
                                     <div class="d-flex flex-grow-1 ml-4">
                                         <input type="text" class="form-control mx-1" value="${tt.ticket_type}" disabled="disabled" style="width: 25%;" />
                                         <input type="text" class="form-control mx-1" value="${tt.department_name}" disabled="disabled" style="width: 25%;" />
                                         <input type="text" class="form-control mx-1" value="${tt.job_position_name}" disabled="disabled" style="width: 25%;" />
                                         <input type="text" class="form-control mx-1" value="${tt.emp_name}" disabled="disabled" style="width: 25%;" />
                                     </div>
                                     <div class="d-flex align-items-center ml-2">
                                         <i class="fa-sharp fa-solid fa-pen-to-square edit_icon" style="cursor: pointer;"
                                         onclick="enableeditbtn('${tt.ticket_type_id}', '${tt.ticket_type}', '${tt.departments}', '${tt.job_positions}', '${tt.assignee}')"></i>
                                         <i class="fa-solid fa-x close_icon ml-3" style="display: none; cursor: pointer;"
                                         onclick="disableeditbtn('${tt.ticket_type_id}')"></i>
                                         <i class="fa-solid fa-trash-can ml-3" style="cursor: pointer;" onclick="delete_ticket_type('${tt.ticket_type_id}')"></i>
                                     </div>
                                 </div>`;
                    });


                    $("#ticket_types_container").html(html);

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
            $("#edited_ticket_id").val(ticket_type_id);
            $("#newTicketType").val(ticket_type);
            const departments = edited_departments.split(',');
            populatecreateannouncementmodal('department', null, null, function () {
                $('#id_department').val(departments).trigger('change');

                populatecreateannouncementmodal('job_position', departments, departments, function () {
                    const jobPositions = edited_jobPositions.split(',');
                    $('#id_job_position').val(jobPositions).trigger('change');

                    populatecreateannouncementmodal('employees', jobPositions, departments, function () {
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
            const ticket_type_id = $("#edited_ticket_id").val();
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

        function delete_ticket_type(ticket_type_id) {
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
                        url: "tickets.aspx/delete_ticket_type",
                        data: JSON.stringify({ ticket_type_id: ticket_type_id }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            display_green_alert(response.d);
                            populate_ticket_type();
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
            $("#edited_ticket_id").val('');
            $("#newTicketType").val('');
            $('#id_employees').val(null).trigger('change');
            $('#id_department').val(null).trigger('change');
            $('#id_job_position').val(null).trigger('change');
        }

    </script>
</body>
</html>
