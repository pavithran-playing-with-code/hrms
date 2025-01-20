<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

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
    <title>Announcements</title>
    <style>
        .card-body {
            overflow-x: auto;
            padding: 0;
        }

        #announcementsTable th {
            white-space: nowrap;
        }

        #announcementsTable td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

            #announcementsTable td button {
                margin-right: 5px;
                margin-bottom: 5px;
                white-space: nowrap;
            }
    </style>
</head>
<body style="background-color: #f8f9fa">

    <div class="container-fluid p-0">
        <div class="row no-gutters">
            <div class="col-md-3 col-lg-2 bg-light" style="min-height: 100vh;">
                <uc:LeftNavBar runat="server" ID="LeftNavBarControl" />
            </div>
            <div class="col-md-9 col-lg-10">
                <div>
                    <uc:HeaderNavBar runat="server" ID="HeaderNavBarControl" />
                </div>
                <div class="mt-4">
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h4 class="card-title mb-0">Announcements List</h4>
                                <button id="addAnnouncement" class="btn btn-outline-custom ms-auto"
                                    style="border: 1px solid hsl(8, 77%, 56%); background-color: transparent; color: hsl(8, 77%, 56%); padding: 0; width: 50px; height: 28px;"
                                    onclick="opencreateannouncementmodal()" title="Create Announcement">
                                    <i class="fa fa-plus m-0"></i>
                                </button>
                            </div>
                            <div class="card-body p-3">
                                <table id="announcementsTable" class="table table-striped table-bordered" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th>Announcement ID</th>
                                            <th>Employee ID</th>
                                            <th>Employee Name</th>
                                            <th>Department</th>
                                            <th>Job Position</th>
                                            <th>Heading</th>
                                            <th>Description</th>
                                            <th>Attachments</th>
                                            <th>Expire Date</th>
                                            <th>Comments</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
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

    <script>
        $(document).ready(function () {
            populateannounncements();
        });

        function opencreateannouncementmodal() {
            $.ajax({
                url: 'dashboard.aspx',
                success: function (data) {
                    // Check if the modal exists in the response
                    var tempDiv = $('<div>').html(data); // Create a temporary container
                    var modalContent = tempDiv.find('#createannouncementmodal'); // Extract the modal
                    debugger
                    if (modalContent.length) {
                        $('body').append(modalContent); // Append modal to body
                        $('#createannouncementmodal').modal('show'); // Show modal
                    } else {
                        console.error('Modal not found in the fetched content.');
                    }
                },
                error: function (error) {
                    console.error('Error loading modal:', error);
                }
            });
        }



        function populateannounncements() {
            $.ajax({
                type: "POST",
                url: 'announcements.aspx/populateannounncements',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    let cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                    cleanedResponse = cleanedResponse.replace(/\\"/g, '"');
                    const data = JSON.parse(cleanedResponse);

                    $('#announcementsTable').DataTable({
                        data: data,
                        order: [[8, 'desc']],
                        columns: [
                            { data: 'announcement_id', visible: false },
                            { data: 'emp_id', visible: false },
                            { data: 'emp_name' },
                            { data: 'department_name' },
                            { data: 'job_position_name' },
                            { data: 'Heading' },
                            {
                                data: 'announcement_description',
                                render: function (data) {
                                    return `<a href="#" class="description-link" data-description='${data}'>View Description</a>`;
                                }
                            },
                            {
                                data: 'attachments',
                                render: function (data) {
                                    const attachmentParts = data.split('/').pop().split('_');
                                    const originalFileName = attachmentParts.slice(2).join('_');
                                    return `<a href="${data}" target="_blank">${originalFileName}</a>`;
                                }
                            },
                            {
                                data: 'expire_date',
                                render: function (data) {
                                    const currentDate = new Date();

                                    const currentFormattedDate = currentDate.toISOString().split('T')[0];
                                    const dateParts = data.split(' ')[0].split('-');
                                    const expireFormattedDate = `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`;
                                    const expireDate = `${dateParts[1]}-${dateParts[0]}-${dateParts[2]}`;

                                    if (expireFormattedDate < currentFormattedDate) {
                                        return `<span style="color: red; font-weight: bold;">${expireDate}</span>`;
                                    } else {
                                        return `<span >${expireDate}</span>`;
                                    }
                                }
                            },
                            {
                                data: 'comments',
                                render: function (data) {
                                    const value = data === "True" ? "Disabled" : "Enabled";
                                    return `<span> ${value}<span />`;
                                }
                            },
                            {
                                data: null,
                                render: function (data, type, row) {
                                    return `
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-primary btn-sm publish-btn" data-id="${row.announcement_id}">Publish</button>
                                        <button class="btn btn-warning btn-sm edit-btn" data-id="${row.announcement_id}">Edit</button>
                                        <button class="btn btn-danger btn-sm delete-btn" data-id="${row.announcement_id}">Delete</button>
                                    </div>`;
                                }
                            }

                        ]
                    });

                    $('#announcementsTable').on('click', '.description-link', function (e) {
                        e.preventDefault();
                        const description = $(this).data('description');
                        const heading = $(this).closest('tr').find('td').eq(3).text();
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


    </script>
</body>
</html>
