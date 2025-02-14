<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="leave_configuration.aspx.cs" Inherits="hrms.leave_configuration" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Leave Configuration</title>

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

        .dropdown-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
            margin-left: 30px;
            margin-right: 30px;
        }


        #leave_approval_levels .dropdown-row {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        #leave_approval_levels .dropdown-group {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            margin-left: 10px;
            max-width: 400px;
        }

        #leave_types .dropdown-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            gap: 20px;
        }

        #leave_types .dropdown-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 10px 20px;
        }

        .form-label {
            margin: 0;
            font-weight: bold;
            white-space: nowrap;
            font-size: 0.95rem;
            color: #555;
        }

        #leavePriorityTable td, #leavePriorityTable th {
            padding: 20px 150px;
            max-width: 150px;
            font-size: 1.5rem;
            white-space: nowrap;
        }

        #leavePriorityTable th {
            background-color: hsl(8, 77%, 56%);
            color: white;
        }

        .info-icon-container {
            position: relative;
            display: inline-block;
        }

        .info-text {
            visibility: hidden;
            opacity: 0;
            position: absolute;
            top: -50%;
            right: 100%;
            margin-right: 40px;
            padding: 10px 25px;
            background-color: white;
            color: black;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            white-space: nowrap;
            transition: visibility 0s, opacity 0.3s ease-in-out;
            transform: scale(0.9);
        }

        .info-icon-container:hover .info-text {
            visibility: visible;
            opacity: 1;
            transform: scale(1.2);
        }

        .editable.editing {
            outline: 2px dashed burlywood;
            background-color: lightcyan;
            animation: growShrink 0.5s ease-in-out;
            transition: transform 0.3s ease;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        @keyframes growShrink {
            0% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.1);
            }

            100% {
                transform: scale(1);
            }
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
            <div class="mt-3">
                <div class="d-flex align-items-center justify-content-between bg-light p-3 ml-3 mr-3">
                    <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.2rem;" class="m-0">Leave Approval Levels</h1>
                </div>
                <div id="leave_approval_levels" class="dropdown-card mt-1 d-flex flex-column align-items-center">
                </div>

                <div class="d-flex align-items-center justify-content-between bg-light p-3 ml-3 mr-3">
                    <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.2rem;" class="m-0">Leave Types</h1>
                </div>
                <div id="leave_types" class="dropdown-card mt-1">
                    <div class="onlyhighaccesslvl">
                        <div class="dropdown-row">
                            <div class="dropdown-group mt-3">
                                <label for="newLeaveType" class="form-label">Add New Leave Type:</label>
                                <input type="text" id="newLeaveType" class="form-control" placeholder="Enter leave type" />
                            </div>
                            <div class="dropdown-group mt-3">
                                <label for="max_leaves" class="form-label">Add New Leave Type:</label>
                                <input type="text" id="max_leaves" class="form-control" placeholder="Enter max leaves" />
                            </div>
                            <div class="dropdown-group mt-3">
                                <button id="addLeaveType" class="btn btn-outline-custom"
                                    style="padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: hsl(8, 77%, 56%); color: white;" onclick="addLeaveType()">
                                    Add
                                </button>
                            </div>
                        </div>
                        <div class="dropdown-row mt-3" style="display: flex; justify-content: center; align-items: center;">
                            <div class="dropdown-group info-icon-container m-0">
                                <div class="info-text">Drag the rows to change priority levels.</div>
                                <i class="fas fa-info-circle info-icon" style="font-size: 20px; color: #17a2b8; cursor: pointer;"></i>
                            </div>
                            <div class="dropdown-group">
                                <button id="editLeavePriority" class="btn btn-outline-custom"
                                    style="padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: gray; color: white;"
                                    onclick="editLeavePriority()">
                                    Edit
                                </button>
                            </div>
                            <div class="dropdown-group">
                                <button id="saveLeavePriority" class="btn btn-outline-custom"
                                    style="display: none; padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: cornflowerblue; color: white;"
                                    onclick="saveLeavePriority()">
                                    Save
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="dropdown-row mt-3">
                        <table id="leavePriorityTable" class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Leave Type</th>
                                    <th>Priority</th>
                                    <th>Max Leaves</th>
                                    <th class="onlyhighaccesslvl">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div id="Quickaction-container">
                    <uc:Quick_action runat="server" />
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

            getDepartmentsAndLeaveApprovals();
            populateLeaveTypes();

            $("#leavePriorityTable tbody").sortable({
                disabled: true,
                update: function (event, ui) {
                    let priorityData = [];
                    $("#leavePriorityTable tbody tr").each(function (index) {
                        const leaveType = $(this).find('td:first').text();
                        const priority = index + 1;
                        priorityData.push({ leaveType, priority });
                        $(this).find('td:nth-child(2)').text(priority);
                    });
                }
            });
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        function getDepartmentsAndLeaveApprovals() {
            $.ajax({
                type: "POST",
                url: 'leave_configuration.aspx/getDepartmentsAndLeaveApprovals',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    const data = JSON.parse(response.d);
                    const container = $("#leave_approval_levels");
                    container.empty();

                    data.forEach(department => {
                        const { DepartmentName, Employees, LeaveApproval } = department;
                        const employeeOptions = Employees.map(emp => `<option value="${emp.EmployeeId}">${emp.EmployeeName}</option>`).join("");

                        const departmentHtml = `
                <div class="dropdown-row mt-3 mb-3 w-100" id="department-${department.DepartmentId}">
                    <div class="dropdown-group">
                        <label class="form-label">Department:</label>
                        <input value="${DepartmentName}" disabled="disabled" class="form-control" />
                    </div>
                    <div class="dropdown-group">
                        <label class="form-label">Level 1:</label>
                        <select class="dropdown form-control level_1" ${LeaveApproval.Level1 ? "disabled" : ""}>
                            <option disabled selected>Select Employee</option>
                            ${employeeOptions}
                        </select>
                    </div>
                    <div class="dropdown-group">
                        <label class="form-label">Level 2:</label>
                        <select class="dropdown form-control level_2" ${LeaveApproval.Level2 ? "disabled" : ""}>
                            <option disabled selected>Select Employee</option>
                            ${employeeOptions}
                        </select>
                    </div>
                    <div class="dropdown-group">
                        <label class="form-label">Level 3:</label>
                        <select class="dropdown form-control level_3" ${LeaveApproval.Level3 ? "disabled" : ""}>
                            <option disabled selected>Select Employee</option>
                            ${employeeOptions}
                        </select>
                    </div>
                    <div class="dropdown-group d-flex justify-content-center onlyhighaccesslvl">
                        <button class="btn btn-outline-custom save-btn"
                            style="padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: hsl(8, 77%, 56%); color: white; display: ${LeaveApproval.Level1 || LeaveApproval.Level2 || LeaveApproval.Level3 ? "none" : "block"};"
                            onclick="saveLeaveApprovalLevels(${department.DepartmentId})">
                            Save
                        </button>
                        <button class="btn btn-outline-custom edit-btn"
                            style="padding: 8px 20px; border-radius: 20px; font-weight: bold; background-color: hsl(8, 77%, 56%); color: white; display: ${LeaveApproval.Level1 || LeaveApproval.Level2 || LeaveApproval.Level3 ? "block" : "none"};"
                            onclick="enableEditing(${department.DepartmentId})">
                            Edit
                        </button>
                    </div>
                </div>`;

                        container.append(departmentHtml);

                        if (LeaveApproval.Level1 || LeaveApproval.Level2 || LeaveApproval.Level3) {
                            const dropdowns = container.find(`#department-${department.DepartmentId} .dropdown`);
                            dropdowns.eq(0).val(LeaveApproval.Level1).prop("disabled", true);
                            dropdowns.eq(1).val(LeaveApproval.Level2).prop("disabled", true);
                            dropdowns.eq(2).val(LeaveApproval.Level3).prop("disabled", true);
                        }
                    });
                    if ($("#emp_access_lvl").val() != "true") {
                        document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                            element.setAttribute('style', 'display: none !important;');
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

        function enableEditing(departmentId) {
            const container = $(`#department-${departmentId}`);
            container.find(".dropdown").prop("disabled", false);
            container.find(".save-btn").show();
            container.find(".edit-btn").hide();
        }

        function saveLeaveApprovalLevels(departmentId) {
            const container = $(`#department-${departmentId}`);
            const level_1 = container.find(".level_1").val();
            const level_2 = container.find(".level_2").val();
            const level_3 = container.find(".level_3").val();

            if (!level_1 || !level_2 || !level_3) {
                Swal.fire({
                    title: "Error!",
                    text: "All levels must be selected before saving.",
                    icon: "error"
                });
                return;
            }

            const data = {
                departmentId: departmentId,
                level_1: level_1,
                level_2: level_2,
                level_3: level_3
            };

            $.ajax({
                type: "POST",
                url: 'leave_configuration.aspx/SaveLeaveApprovalLevels',
                data: JSON.stringify(data),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);
                    if (data === "success") {
                        getDepartmentsAndLeaveApprovals();
                        display_green_alert("Leave approval levels saved successfully.");
                    } else {
                        Swal.fire({
                            title: "Failure!",
                            text: "Leave approval could not be saved. Please try again.",
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

            container.find(".dropdown").prop("disabled", true);
            container.find(".save-btn").hide();
            container.find(".edit-btn").show();
        }

        function populateLeaveTypes() {
            $.ajax({
                type: "POST",
                url: 'leave_configuration.aspx/populateLeaveTypes',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    const data = JSON.parse(response.d);
                    const tbody = $('#leavePriorityTable tbody');
                    tbody.empty();

                    data.forEach(item => {
                        const row = `
                <tr data-id="${item.leave_type_id}">
                    <td class="editable">${item.leave_type}</td>
                    <td>${item.priority_level}</td>
                    <td class="editable">${item.max_leave}</td>
                    <td class="onlyhighaccesslvl">
                        <button class="btn btn-warning edit-btn" onclick="editRow(this)">Edit</button>
                        <button class="btn btn-success save-btn" style="display: none; background-color: cornflowerblue; border:none; outline:none" onclick="saveRow(this)">Save</button>
                        <button class="btn btn-danger" onclick="removeleavetype(${item.leave_type_id})">Remove</button>
                    </td>
                </tr>`;
                        tbody.append(row);
                    });
                    if ($("#emp_access_lvl").val() != "true") {
                        document.querySelectorAll('.onlyhighaccesslvl').forEach(function (element) {
                            element.setAttribute('style', 'display: none !important;');
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

        function addLeaveType() {
            const newLeaveType = $('#newLeaveType').val();
            const max_leaves = $('#max_leaves').val();
            const priority = $("#leavePriorityTable tbody tr").length + 1;

            if (!newLeaveType) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please enter leave type.",
                    icon: "warning"
                });
                return;
            }
            else if (!max_leaves) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please enter max leaves.",
                    icon: "warning"
                });
                return;
            }

            const data = {
                leave_type: newLeaveType,
                priority_level: priority,
                max_leave: max_leaves
            };

            $.ajax({
                type: "POST",
                url: 'leave_configuration.aspx/add_leave_types',
                data: JSON.stringify(data),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let data = response.d;
                    data = JSON.parse(data);
                    if (data === "success") {
                        $('#newLeaveType').val('');
                        $('#max_leaves').val('');
                        populateLeaveTypes();
                        display_green_alert("New leave type has been created successfully.");
                    } else if (data === "duplicate") {
                        Swal.fire({
                            title: "Duplicate Request!",
                            text: "Leave type already exists.",
                            icon: "warning"
                        });
                    } else {
                        Swal.fire({
                            title: "Failure!",
                            text: "Leave type could not be created. Please try again.",
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

        function editRow(button) {
            const row = $(button).closest('tr');
            row.find('.editable').each(function () {
                $(this).attr('contenteditable', 'true');
                $(this).addClass('editing');
            });

            row.find('.edit-btn').hide();
            row.find('.save-btn').show();
        }

        function saveRow(button) {
            const row = $(button).closest('tr');
            const leave_type_id = row.data('id');
            const leave_type = row.find('td:nth-child(1)').text();
            const max_leaves = row.find('td:nth-child(3)').text();
            $.ajax({
                type: "POST",
                url: 'leave_configuration.aspx/updateleavetypes',
                data: JSON.stringify({ leave_type_id: leave_type_id, leave_type: leave_type, max_leaves: max_leaves }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    if (response.d == "success") {
                        display_green_alert("Edited successfully.");
                    } else if (response.d === "duplicate") {
                        Swal.fire({
                            title: "Duplicate Request!",
                            text: "Leave type already exists.",
                            icon: "warning"
                        });
                    }
                    else {
                        Swal.fire("Issue while editing");
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
            row.find('.editable').each(function () {
                $(this).removeAttr('contenteditable');
                $(this).removeClass('editing');
            });
            row.find('.edit-btn').show();
            row.find('.save-btn').hide();
            populateLeaveTypes();
        }


        function editLeavePriority() {
            $("#leavePriorityTable tbody").sortable("option", "disabled", false);
            $("#saveLeavePriority").css("display", "block");
        };

        function saveLeavePriority() {
            const priorityData = [];
            $("#leavePriorityTable tbody tr").each(function (index) {
                const leave_type_id = $(this).data('id');
                const priority = index + 1;
                priorityData.push({ leave_type_id: leave_type_id, priority: priority });
            });

            $.ajax({
                type: "POST",
                url: 'leave_configuration.aspx/saveLeavePriority',
                data: JSON.stringify({ priorityData: priorityData }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    if (response.d == "success") {
                        display_green_alert("Priority saved successfully.");
                    } else {
                        Swal.fire("Issue while saving priority");
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

            $("#leavePriorityTable tbody").sortable("option", "disabled", true);
            $("#saveLeavePriority").css("display", "none");
        }


        function removeleavetype(leave_type_id) {
            Swal.fire({
                title: "Are you sure?",
                text: "Do you want to remove this leave type?",
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
                        url: 'leave_configuration.aspx/removeleavetype',
                        data: JSON.stringify({ leave_type_id: leave_type_id }),
                        contentType: 'application/json',
                        dataType: 'json',
                        success: function (response) {
                            if (JSON.parse(response.d) == "success") {
                                populateLeaveTypes();
                                display_green_alert("Leave type has been removed successfully.");
                            } else {
                                Swal.fire("issue while removing leave type");
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

    </script>

</body>
</html>
