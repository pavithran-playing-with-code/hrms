<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="quick_action.ascx.cs" Inherits="hrms.quick_action" %>

<style>
    .icon-item {
        width: 40px;
        height: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #ff3b38;
        border-radius: 50%;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, opacity 0.3s ease;
        margin-bottom: 5px;
    }

        .icon-item:hover {
            transform: scale(1.1);
        }

        .icon-item i {
            font-size: 1rem;
            color: white;
        }

    .quick-action {
        width: 55px;
        height: 55px;
        position: relative;
        z-index: 2;
    }

    .inner-icons {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
        padding: 20px;
        position: relative;
        z-index: 1;
    }

    .icon-items-container {
        display: none; 
        flex-direction: column;
        align-items: center;
        gap: 5px;
        transition: all 0.3s ease;
        opacity: 0;
        pointer-events: none;
        transform: translateY(50px);
    }

        .icon-items-container.open {
            opacity: 1;
            pointer-events: all;
            transform: translateY(0);
        }

    #quick-action-icon {
        transition: transform 0.3s ease;
    }

    .quick-action.open i {
        transform: rotate(45deg);
    }
</style>

<nav id="quickaction-navbar" style="background-color: transparent !important;" class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-primary p-0">
    <div class="inner-icons">
        <div class="icon-items-container">
            <div id="icon-item9" class="icon-item round" data-tooltip="Dashboard Charts">
                <a class="text-light" data-toggle="oh-modal-toggle" data-target="#objectDetailsModal">
                    <i class="fas fa-chart-line"></i>
                </a>
            </div>

            <div id="icon-item8" class="icon-item round" onclick="opencreateticketmodal()" data-tooltip="Create Ticket">
                <a class="text-light">
                    <i class="fas fa-ticket-alt"></i>
                </a>
            </div>

            <div id="icon-item7" class="icon-item round" data-tooltip="Create Asset Request">
                <a class="text-light">
                    <i class="fas fa-laptop"></i>
                </a>
            </div>

            <div id="icon-item6" class="icon-item round" data-tooltip="Create Reimbursement">
                <a class="text-light">
                    <i class="fas fa-money-check-alt"></i>
                </a>
            </div>

            <div id="icon-item5" class="icon-item round" data-tooltip="Create Work Type Request">
                <a class="text-light">
                    <i class="fas fa-briefcase"></i>
                </a>
            </div>

            <div id="icon-item4" class="icon-item round" data-tooltip="Create Shift Request">
                <a class="text-light">
                    <i class="fas fa-history"></i>
                </a>
            </div>

            <div id="icon-item3" class="icon-item round" onclick="open_createLeavemodal()" data-tooltip="Create Leave Request">
                <a class="text-light">
                    <i class="fas fa-calendar-plus"></i>
                </a>
            </div>

            <div id="icon-item2" class="icon-item round" data-tooltip="Create Attendance Request">
                <a class="text-light">
                    <i class="fas fa-user-check"></i>
                </a>
            </div>
        </div>
        <div id="icon-item1" class="icon-item round quick-action mt-1" data-tooltip="Quick Action" onclick="toggleIcons()">
            <i id="quick-action-icon" class="fas fa-plus" style="font-size: 1.25rem;"></i>
        </div>
    </div>
</nav>

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
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="leave_attachments">Attachments:</label>
                            <input type="file" name="attachments" class="form-control-file" id="leave_attachments" />
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
                        <label for="leave_description">Description:</label>
                        <textarea id="leave_description" class="form-control" rows="4" placeholder="Enter description here..."></textarea>
                    </div>
                    <div class="text-right">
                        <button onclick="save_Leave()" class="btn btn-primary ml-2" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Save</button>
                    </div>
                </div>
            </div>
        </div>
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
                        <label for="id_ticket_title">Title:</label>
                        <input type="text" name="title" class="form-control" id="id_ticket_title" placeholder="Title" maxlength="100" />
                    </div>
                    <div class="form-group">
                        <label for="id_ticket_description">Description:</label>
                        <textarea id="id_ticket_description" class="form-control"></textarea>
                    </div>
                    <div class="form-group d-flex flex-column">
                        <div class="d-flex align-items-center">
                            <label for="id_ticket_attachments" class="mr-2">Attachments:</label>
                            <input type="file" name="attachments" class="attachment_file" id="id_ticket_attachments" />
                        </div>
                        <div class="d-flex align-items-center row ml-1">
                            <div id="id_ticket_attachments_helper">
                                <input type="text" id="id_ticket_attachments_helper_value" hidden="hidden" />
                            </div>
                            <button type="button" style="width: 17%; position: relative; left: 16%; outline: none; background-color: #f6f6f6; border: 1px solid #000; color: #000; cursor: pointer; font-size: 14px; display: none;"
                                class="btn btn-danger btn-sm mt-2" id="remove_ticket_attachment_btn">
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

<script>
    $(document).ready(function () {
        $('[data-tooltip]').each(function () {
            var tooltipText = $(this).attr('data-tooltip');
            $(this).attr('title', tooltipText);
        });

        $('[data-tooltip]').tooltip({
            placement: 'left',
            trigger: 'hover'
        });
    });

    document.getElementById('remove_ticket_attachment_btn').addEventListener('click', function () {
        $('#id_ticket_attachments').val('');
        document.getElementById('id_ticket_attachments_helper').style.display = 'none';
        document.getElementById('remove_ticket_attachment_btn').style.display = 'none';
    });

    document.getElementById('id_ticket_attachments').addEventListener('change', function () {
        const fileInput = this;
        debugger
        if (fileInput.files.length > 0) {
            document.getElementById('id_ticket_attachments_helper').style.display = 'none';
            document.getElementById('remove_ticket_attachment_btn').style.display = 'block';
        }
    });

    function opencreateticketmodal() {
        clearcreateticketmodalFields();
        document.getElementById('createticketmodalLabel').innerText = "Create Tickets.";
        $('#saveticketbtn').show();
        $('#editticketbtn').hide();
        $('#createticketmodal').modal('show');
        populate_ticket_type();
    }

    function clearcreateticketmodalFields() {
        $("#id_ticket_title").val("");
        $("#id_ticket_description").val("");
        $("#id_ticket_attachments").val("");
        $("#id_ticket_attachments_helper_value").val("");
        $("#id_ticket_attachments_hidden_value").val("");
        $("#ticket_type").val(null).trigger("change");
        $("#ticket_type_assignee").val("");
        $("#priority").val("high").trigger("change");
        $("#status").val("new").trigger("change");
        $("#remove_ticket_attachment_btn").hide();
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
                        if (response.d.includes("ExceptionMessage")) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.d,
                                confirmButtonText: 'Ok'
                            });
                            return;
                        }

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
        const id_ticket_title = $('#id_ticket_title').val();
        const id_ticket_description = $('#id_ticket_description').val();
        const ticket_type = $('#ticket_type').val();
        const priority = $('#priority').val();
        const status = $('#status').val();
        let attachments = '';
        const fileInput = document.getElementById('id_ticket_attachments');

        if (action == "edit" && document.getElementById('id_ticket_attachments_helper').style.display == "block") {
            attachments = $('#id_ticket_attachments_hidden_value').val();
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

        if ((!id_ticket_title) || (!id_ticket_description) || (!ticket_type) || (!priority) || (!status)) {
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
            data: JSON.stringify({ action: action, ticket_id: action === "edit" ? $('#edit_ticket_id').val() : null, id_ticket_title: id_ticket_title, id_ticket_description: id_ticket_description, attachments: attachments, ticket_type: ticket_type, priority: priority, status: status }),
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

                $('#createticketmodal').modal('hide');
                display_green_alert(response.d);
                document.dispatchEvent(new Event("callpopulatetickets"));
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

    function toggleIcons() {
        var container = document.querySelector(".icon-items-container");
        var quickAction = document.querySelector(".quick-action");

        if (container.classList.contains("open")) {
            container.classList.remove("open");
            setTimeout(() => {
                container.style.display = "none"; 
            }, 300); 
        } else {
            container.style.display = "flex"; 
            setTimeout(() => {
                container.classList.add("open");
            }, 10);
        }
    }

    function open_createLeavemodal() {
        $('#createLeavemodal').modal('show');
        populateLeaveTypes();
    }

    function populateLeaveTypes() {
        $.ajax({
            type: "POST",
            url: 'leave_configuration.aspx/populateLeaveTypes',
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

                const data = JSON.parse(response.d);
                const dropdown = $('#id_leave_type');
                dropdown.find('option:not(:first)').remove();

                data.forEach(item => {
                    dropdown.append(`<option value="${item.leave_type_id}">${item.leave_type}</option>`);
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
                        if (response.d.includes("ExceptionMessage")) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.d,
                                confirmButtonText: 'Ok'
                            });
                            return;
                        }

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
        const description = $('#leave_description').val();
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

        const fileInput = document.getElementById('leave_attachments');
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
                if (response.d.includes("ExceptionMessage")) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: response.d,
                        confirmButtonText: 'Ok'
                    });
                    return;
                }

                let data = response.d;
                data = JSON.parse(data);
                if (data === "success") {
                    $('#createLeavemodal').modal('hide');
                    clearLeaveRequestFields();
                    display_green_alert("The leave request has been saved successfully.");
                    document.dispatchEvent(new Event("leaveRequestSaved"));
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
        $('#leave_description').val('');
        $('#leave_attachments').val('');
    }

</script>
