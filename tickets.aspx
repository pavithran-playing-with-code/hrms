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
                            <div class="col-md-5">
                                <div class="card p-3" style="height: 500px; display: flex; flex-direction: column;">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="m-0">Ticket Types</h5>
                                        <input type="text" id="newTicketType" class="form-control" placeholder="Enter Ticket type"
                                            style="width: 150px; min-width: 50%; flex-shrink: 1;" />
                                        <button id="create_ticket_type" class="btn btn-outline-custom ml-2"
                                            style="padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: hsl(8, 77%, 56%); color: white;"
                                            onclick="create_ticket_type()">
                                            Add
                                        </button>
                                    </div>
                                    <div class="card-text p-3 mt-1 mb-3" id="ticket_types_container" style="flex-grow: 1; overflow-y: auto; max-height: 80%;">
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
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

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
                    let ticket_types = response.d;
                    let html = "";
                    ticket_types.forEach((tt) => {
                        html += `<div class="d-flex align-items-center mb-4 ml-2 ticket_type_div_${tt.ticket_type_id}">
                                    <input type="text" id="ticket_type_${tt.ticket_type_id}" class="form-control" value="${tt.ticket_type}"
                                        style="width: 150px; min-width: 80%; flex-shrink: 1;" disabled="disabled" />

                                    <i class="fa-sharp fa-solid fa-pen-to-square ml-4 edit_icon" onclick="enablefield('${tt.ticket_type_id}')"></i>
                                    <i class="fa-solid fa-check ml-4 save_icon" onclick="edit_ticket_type('${tt.ticket_type_id}')" style="display: none;"></i>
                                    <i class="fa-solid fa-trash-can ml-3" onclick="delete_ticket_type('${tt.ticket_type_id}')"></i>
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

            if (!newTicketType) {
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
                data: JSON.stringify({ newTicketType: newTicketType }),
                contentType: 'application/json',
                dataType: 'json',
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

        function enablefield(ticket_type_id) {
            $("#ticket_type_" + ticket_type_id).prop("disabled", false);
            $(".ticket_type_div_" + ticket_type_id + " .edit_icon").hide();
            $(".ticket_type_div_" + ticket_type_id + " .save_icon").show();
        }

        function edit_ticket_type(ticket_type_id) {
            const newTicketType = $("#ticket_type_" + ticket_type_id).val();

            if (!newTicketType) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill the ticket type field before proceeding.",
                    icon: "warning"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: "tickets.aspx/edit_ticket_type",
                data: JSON.stringify({ ticket_type_id: ticket_type_id, newTicketType: newTicketType }),
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
    </script>
</body>
</html>
