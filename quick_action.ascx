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
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
        transition: all 0.3s ease;
        opacity: 0;
        pointer-events: none;
        transform: translateY(50px);
        margin-top: 10px;
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

            <div id="icon-item8" class="icon-item round" data-tooltip="Create Ticket">
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

            <div id="icon-item3" class="icon-item round" onclick="$('#createLeavemodal').modal('show');" data-tooltip="Create Leave Request">
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
                                <option value="1">Sick Leave</option>
                                <option value="2">Casual Leave</option>
                                <option value="3">Earned Leave</option>
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

<script>
    function toggleIcons() {
        const container = document.querySelector('.icon-items-container');
        const quickActionButton = document.querySelector('.quick-action');

        container.classList.toggle('open');
        quickActionButton.classList.toggle('open');
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
