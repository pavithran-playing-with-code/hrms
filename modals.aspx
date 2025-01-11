<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modals.aspx.cs" Inherits="hrms.modals" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modalcheck">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function populate_announncements_details(announcement_id) {
            $('#exampleModalLong').modal('show');

            $.ajax({
                type: "POST",
                url: 'dashboard.aspx/populate_announncements',
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {

                },
                error: function () {
                    Swal.fire("Issue while populate employee details!");
                }
            });
        }
    </script>
</body>
</html>
