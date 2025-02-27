<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="all_employees.aspx.cs" Inherits="hrms.all_employees" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Employee</title>

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
            position: fixed;
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
            overflow: auto;
            margin-left: 20px;
            margin-right: 20px;
        }

        .card-body {
            overflow-x: auto;
            padding: 0;
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

        #employeesTable_length select {
            border: 1px solid #aaa;
            background-color: transparent;
            padding: 4px;
        }

        #employeesTable_filter input {
            border: 1px solid #aaa;
            border-radius: 3px;
            padding: 5px;
            background-color: transparent;
            margin-left: 3px;
        }

        #employeesTable th {
            white-space: nowrap;
        }

        #employeesTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
            background-color: #f8f9fa !important;
        }

        #employeesTable tr.deactivated-row td {
            background-color: hsl(8, 77%, 90%) !important;
        }

        #employeesTable td button {
            margin-right: 5px;
            margin-bottom: 5px;
            white-space: nowrap;
        }

        .createemployeefields .form-control,
        .createemployeefields select,
        .createemployeefields textarea,
        .createemployeefields input[type="file"],
        .createemployeefields button {
            border-radius: 0 !important;
        }


        .form-group {
            flex: 1;
            min-width: 150px;
        }

        .select2-container--default .select2-selection--single {
            height: 38px !important;
            border: 1px solid #ced4da;
            border-radius: 0;
            padding: 6px 12px;
            display: flex;
            align-items: center;
            overflow: hidden;
            flex-wrap: nowrap;
        }

            .select2-container--default .select2-selection--single .select2-selection__rendered {
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                overflow-x: hidden;
                white-space: nowrap;
                width: 100%;
            }

            .select2-container--default .select2-selection--single .select2-selection__choice {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: gray !important;
            color: white !important;
        }

        .select2-selection__placeholder {
            color: #6c757d !important;
            font-weight: 400;
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
    <input type="hidden" id="employee_id" name="employee_id" />

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
                <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.5rem;" class="m-0">Employees</h1>
                <div id="dataTableControls" class="d-flex align-items-center ml-auto mr-4 mt-2" style="gap: 20px;"></div>
                <button id="createemployee" class="btn btn-outline-custom"
                    style="outline: none; border-radius: 0; border: 1px solid hsl(8, 77%, 56%); background-color: hsl(8, 77%, 56%); color: white;"
                    onclick="opencreateemployeemodal()" title="Create employee">
                    <i class="fa fa-plus"></i>&nbsp;Create
               
                </button>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 20px; margin-right: 20px">
                    <div class="card-body p-3">
                        <table id="employeesTable" class="table table-striped table-bordered" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>employee ID</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Blood Group</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>Date of Birth</th>
                                    <th>Location</th>
                                    <th>Department</th>
                                    <th>Job Position</th>
                                    <th>Carrer Level</th>
                                    <th>Access Level</th>
                                    <th>Working</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal fade pt-5" id="createemployeemodal" tabindex="-1" aria-labelledby="createemployeemodalLabel">
                    <div class="modal-dialog modal-dialog-centered modal-lg mx-auto" style="max-width: 41%; margin: 0 auto;">
                        <div class="modal-content" style="border-radius: 0px !important; width: 100%;">
                            <div class="modal-header" style="padding: 1.50rem 1.70rem 1rem; height: 30px; background-color: transparent; border-bottom: none;">
                                <h2 class="modal-title" id="createemployeemodalLabel" style="font: normal 80%/1.4 sans-serif; font-size: 1.10rem; font-weight: 600; color: #4f4a4a;"></h2>
                                <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body createemployeefields">
                                <div class="mx-2 mb-2 p-4" style="color: hsl(0, 0%, 11%); font-weight: 500; background-color: hsl(0,0%,100%); border: 1px solid hsl(213,22%,84%);">
                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="first_name">First Name:</label>
                                            <input type="text" name="first_name" class="form-control" id="first_name" placeholder="First Name" maxlength="100" />
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="last_name">Last Name:</label>
                                            <input type="text" name="last_name" class="form-control" id="last_name" placeholder="Last Name" maxlength="100" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="dob">Date of Birth:</label>
                                            <input type="date" name="dob" class="form-control" id="dob" />
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="blood_group">Blood Group:</label>
                                            <input type="text" name="email" class="form-control" id="blood_group" placeholder="Blood Group" maxlength="100" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="phone_number">Phone Number:</label>
                                            <input type="number" name="phone_number" class="form-control" id="phone_number" placeholder="Phone Number" maxlength="100" />
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="location">Location:</label>
                                            <input name="location" class="form-control" id="location" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="email">Email:</label>
                                            <input type="text" name="email" class="form-control" id="email" placeholder="Email" maxlength="100" />
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="account_password">Password:</label>
                                            <input type="text" name="email" class="form-control" id="account_password" placeholder="Password" maxlength="100" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="id_department">Department:</label>
                                            <select name="id_department" class="form-control select2" id="id_department"></select>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="id_job_position">Job Position:</label>
                                            <select name="id_job_position" class="form-control select2" id="id_job_position"></select>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="carrer_level">Career Level:</label>
                                            <select name="carrer_level" class="form-control select2" id="carrer_level">
                                                <option value="Experienced">Experienced</option>
                                                <option value="Fresher">Fresher</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="access_level">Access Level:</label>
                                            <select name="access_level" class="form-control select2" id="access_level">
                                                <option value="high">High</option>
                                                <option value="medium">Medium</option>
                                                <option value="low">Low</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group text-right">
                                        <button onclick="insertEmployee()" id="addemployeebtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Add</button>
                                        <button onclick="updateEmployee()" id="updateEmployeebtn" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Edit</button>
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

    <script>
        $(document).ready(function () {
            populateemployees();
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        function populateemployees() {
            $.ajax({
                type: "POST",
                url: 'all_employees.aspx/populateemployees',
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

                    if ($.fn.DataTable.isDataTable('#employeesTable')) {
                        $('#employeesTable').DataTable().clear().destroy();
                    }

                    $('#employeesTable').DataTable({
                        data: data,
                        scrollX: true,
                        scrollCollapse: true,
                        fixedColumns: {
                            rightColumns: 1
                        },
                        dom: "<'row'<'col-sm-6'l><'col-sm-6'f>>tp",
                        initComplete: function () {
                            $('#dataTableControls').empty();
                            $('#employeesTable_length').detach().appendTo('#dataTableControls');
                            $('#employeesTable_filter').detach().appendTo('#dataTableControls');
                        },
                        order: [[6, 'desc']],
                        columns: [
                            { data: 'emp_id', visible: false },
                            { data: 'first_name' },
                            { data: 'last_name' },
                            { data: 'blood_group' },
                            { data: 'phone_number' },
                            { data: 'email' },
                            {
                                data: 'dob',
                                render: function (data) {
                                    const dateParts = data.split(' ')[0].split('-');
                                    const postedDate = `${dateParts[0]}-${dateParts[1]}-${dateParts[2]}`;
                                    return `<span>${postedDate}</span>`;
                                }
                            },
                            { data: 'location' },
                            { data: 'department' },
                            { data: 'job_position' },
                            { data: 'career_level' },
                            { data: 'access_level' },
                            {
                                data: 'is_active',
                                render: function (data, type, row) {
                                    if (data === "Y") {
                                        return `<span style="color: green; font-weight: bold;">Active</span>`;
                                    } else {
                                        return `<span style="color: red; font-weight: bold;">Deactive</span>`;
                                    }
                                }
                            },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    if (row.is_active === "Y") {
                                        return `
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-secondary btn-sm publish-btn" onclick="deactive_delete_emp('${row.emp_id}', 'deactivate', 'N')">Deactivate</button>
                                            <button class="btn btn-warning btn-sm edit-btn" onclick="editEmployee('${row.emp_id}')">Edit</button>
                                            <button class="btn btn-danger btn-sm delete-btn" onclick="deactive_delete_emp(${row.emp_id}, 'delete', '')">Delete</button>
                                        </div>`;
                                    } else {
                                        return `
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-primary btn-sm republish-btn" onclick="deactive_delete_emp('${row.emp_id}', 'activate', 'Y')">Activate</button>
                                            <button class="btn btn-warning btn-sm edit-btn" onclick="editEmployee('${row.emp_id}')">Edit</button>
                                            <button class="btn btn-danger btn-sm delete-btn" onclick="deactive_delete_emp('${row.emp_id}', 'delete', '')">Delete</button>
                                        </div>`;
                                    }
                                }
                            }

                        ],
                        headerCallback: function (thead, data, start, end, display) {
                            $('th', thead).addClass('text-center');
                        },
                        createdRow: function (row, data, dataIndex) {
                            if (data.is_active === "N") {

                                $(row).addClass("deactivated-row");
                            }
                            else {
                                $(row).removeClass("deactivated-row");
                            }

                            $('td', row).addClass('text-center');
                        },
                        language: {
                            emptyTable: `<div style="text-align: center;">
                         <img src="/asset/img/no-employees.png" alt="No data available" style="max-width: 200px; margin-top: 20px;">
                         <p style="font-size: 16px; color: #555; margin-top: 10px;">No data available</p>
                                         </div>`
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

        function opencreateemployeemodal() {
            clearfields();
            populatecreateannouncementmodal("department", null, null);
            populatecreateannouncementmodal("job_position", null, null);
            $('#addemployeebtn').show();
            $('#updateEmployeebtn').hide();
            $('#createemployeemodal').modal('show');
            document.getElementById('createemployeemodalLabel').innerText = "Create Announcement.";
        }

        function clearfields() {
            document.getElementById("employee_id").value = "";
            document.getElementById("first_name").value = "";
            document.getElementById("last_name").value = "";
            document.getElementById("blood_group").value = "";
            document.getElementById("phone_number").value = "";
            document.getElementById("email").value = "";
            document.getElementById("account_password").value = "";
            document.getElementById("dob").value = "";
            $('#id_department').val(null).trigger('change');
            $('#id_job_position').val(null).trigger('change');
            document.getElementById("carrer_level").selectedIndex = 0;
            document.getElementById("access_level").selectedIndex = 0;
        }

        function populatecreateannouncementmodal(dropdowntype, value, departmentValues, callback) {
            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populatecreateannouncementmodal',
                data: JSON.stringify({ dropdowntype: dropdowntype, value: value, departmentValues: departmentValues }),
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

        function populateDropdown(selector, items, isEditing = false) {
            const dropdown = $(selector);
            dropdown.empty();

            if (items.length > 0) {
                const filteredItems = items.filter(item => item.id !== "All");

                filteredItems.forEach(item => {
                    dropdown.append(new Option(item.name, item.id));
                });
            }

            if (!isEditing) {
                dropdown.val(null).trigger('change');
            }
        }

        $('#id_department').on('change', function () {
            const selectedDepartments = $(this).val() ? [$(this).val()] : [];
            if (selectedDepartments != "") {
                populatecreateannouncementmodal("job_position", selectedDepartments, null);
            }
        });

        function insertEmployee() {
            const firstName = $('#first_name').val();
            const lastName = $('#last_name').val();
            const blood_group = $('#blood_group').val();
            const phoneNumber = $('#phone_number').val();
            const email = $('#email').val();
            const account_password = $('#account_password').val();
            const dob = $('#dob').val();
            const location = $('#location').val();
            const department = $('#id_department').val();
            const jobPosition = $('#id_job_position').val();
            const careerLevel = $('#carrer_level').val();
            const accessLevel = $('#access_level').val();

            if (!firstName || !lastName || !blood_group || !phoneNumber || !email || !account_password || !dob || !department || !jobPosition || !careerLevel || !accessLevel) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill in all the required fields.",
                    icon: "warning"
                });
                return;
            }

            const data = {
                firstName: firstName,
                lastName: lastName,
                blood_group: blood_group,
                phoneNumber: phoneNumber,
                email: email,
                account_password: account_password,
                dob: dob,
                location: location,
                department: department,
                jobPosition: jobPosition,
                careerLevel: careerLevel,
                accessLevel: accessLevel
            };

            $.ajax({
                type: "POST",
                url: "all_employees.aspx/insertEmployee",
                data: JSON.stringify(data),
                contentType: "application/json",
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

                    display_green_alert(response.d);
                    clearfields();
                    $('#createemployeemodal').modal('hide');
                    populateemployees();
                    Swal.fire({
                        title: "Success!",
                        text: "Employee added successfully.",
                        icon: "success"
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

        function editEmployee(emp_id) {
            if (!emp_id) {
                Swal.fire({
                    title: "Error!",
                    text: "Employee ID is missing.",
                    icon: "error"
                });
                return;
            }

            $.ajax({
                type: "POST",
                url: "all_employees.aspx/getEmployeeById",
                data: JSON.stringify({ emp_id: emp_id }),
                contentType: "application/json",
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

                    const employee = JSON.parse(response.d);

                    $('#first_name').val(employee.firstName);
                    $('#last_name').val(employee.lastName);
                    $('#blood_group').val(employee.blood_group);
                    $('#phone_number').val(employee.phoneNumber);
                    $('#email').val(employee.email);
                    $('#account_password').val(employee.account_password);
                    let dob = employee.dob ? employee.dob.split(" ")[0].split("-").reverse().join("-") : "";
                    $('#dob').val(dob);
                    $('#location').val(employee.location);
                    $('#carrer_level').val(employee.careerLevel);
                    $('#access_level').val(employee.accessLevel);

                    populatecreateannouncementmodal('department', null, null, function () {
                        $('#id_department').val(employee.department).trigger('change');
                    });

                    populatecreateannouncementmodal('job_position', Array.isArray(employee.department) ? employee.department : [employee.department], null, function () {
                        $('#id_job_position').val(employee.jobPosition).trigger('change');
                    }, true);

                    $('#employee_id').val(emp_id);
                    $('#addemployeebtn').hide();
                    $('#updateEmployeebtn').show();
                    $('#createemployeemodal').modal('show');
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        title: "Error!",
                        text: `Failed to load employee details: ${error}. Response: ${xhr.responseText}`,
                        icon: "error"
                    });
                }
            });
        }

        function updateEmployee() {
            const emp_id = $('#employee_id').val();
            const firstName = $('#first_name').val();
            const lastName = $('#last_name').val();
            const blood_group = $('#blood_group').val();
            const phoneNumber = $('#phone_number').val();
            const email = $('#email').val();
            const account_password = $('#account_password').val();
            const dob = $('#dob').val();
            const location = $('#location').val();
            const department = $('#id_department').val();
            const jobPosition = $('#id_job_position').val();
            const careerLevel = $('#carrer_level').val();
            const accessLevel = $('#access_level').val();

            if (!firstName || !lastName || !blood_group || !phoneNumber || !email || !account_password || !dob || !department || !jobPosition || !careerLevel || !accessLevel) {
                Swal.fire({
                    title: "Missing Fields",
                    text: "Please fill in all the required fields.",
                    icon: "warning"
                });
                return;
            }

            const data = {
                emp_id: emp_id,
                firstName: firstName,
                lastName: lastName,
                blood_group: blood_group,
                phoneNumber: phoneNumber,
                email: email,
                account_password: account_password,
                dob: dob,
                location: location,
                department: department,
                jobPosition: jobPosition,
                careerLevel: careerLevel,
                accessLevel: accessLevel
            };

            $.ajax({
                type: "POST",
                url: "all_employees.aspx/updateEmployee",
                data: JSON.stringify(data),
                contentType: "application/json",
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

                    display_green_alert(response.d);
                    clearfields();
                    $('#createemployeemodal').modal('hide');
                    populateemployees();
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

        function deactive_delete_emp(emp_id, action, is_active) {
            var alert_text = "";
            if (action == "deactivate") {
                alert_text = "Do you want to deactivate this employee?";
            }
            else if (action == "activate") {
                alert_text = "Do you want to activate this employee?";
            }
            else if (action == "delete") {
                alert_text = "Do you want to delete this employee?";
            }

            Swal.fire({
                title: "Are you sure?",
                text: alert_text,
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes",
                cancelButtonText: "Cancel"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: 'all_employees.aspx/deactive_delete_emp',
                        data: JSON.stringify({ emp_id: emp_id, action: action, is_active: is_active }),
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
                            populateemployees();
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
