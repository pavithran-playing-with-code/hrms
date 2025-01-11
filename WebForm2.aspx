<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="hrms.WebForm2" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
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

    <title>webform2</title>
    <style>
        .form-control.select2-hidden-accessible + .select2-container {
            width: 100% !important;
            height: calc(1.5em + .75rem + 2px) !important;
        }

        .select2-container--default .select2-selection--multiple {
            height: calc(1.5em + .75rem + 2px) !important;
            border: 1px solid #ced4da;
            border-radius: .25rem;
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
    </style>


</head>
<body>
    <div class="modal fade pt-5" id="createannouncementmodal" tabindex="-1" aria-labelledby="createannouncementmodalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg mx-auto" style="max-width: 45%; margin: 0 auto;">
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
                        <div class="text-right">
                            <button type="submit" class="btn btn-primary" style="width: 70px; height: 45px; background-color: hsl(8, 77%, 56%); color: hsl(0, 0%, 100%); border-radius: 0px !important; border: none; box-shadow: none; outline: none">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function () {
            $('#createannouncementmodal').modal('show');
            populatecreateannouncementmodal();
        });

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
    </script>
</body>
</html>
