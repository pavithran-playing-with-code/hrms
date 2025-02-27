<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="header_navbar.ascx.cs" Inherits="hrms.header_navbar" %>

<style>
    .navbar {
        background-color: #fff !important;
    }

    .rounded-circle {
        border-radius: 50%;
        text-align: center;
        font-size: 14px;
        line-height: 40px;
    }

    .nav-item.dropdown .dropdown-menu {
        left: -35px;
        right: auto;
    }

    .dropdown-menu hr {
        width: 80%;
        margin-left: auto;
        margin-right: auto;
        border: 1px solid #ddd;
    }

    a:focus, a:active {
        background-color: transparent !important;
        outline: none !important;
    }

    .dropdown-menu .dropdown-item:hover {
        color: hsl(8, 77%, 56%);
        background-color: transparent;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light">

    <div class="d-flex align-items-center">
        <i class="fa fa-bars mr-2" id="toggleSidebar" onclick="sidebarToggle()"></i>
        <a class="navbar-brand" href="#">HRMS</a>
    </div>

    <div class="ml-auto">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fa fa-gear"></i></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fa-solid fa-bug"></i></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fa fa-globe"></i></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fa fa-bell"></i></a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                <div class="dropdown-menu" style="font-size: 15px;" aria-labelledby="profileDropdown">
                    <a class="dropdown-item" href="#">My Profile</a>
                    <a class="dropdown-item" href="login.aspx?changePassword">Change Password</a>
                    <hr />
                    <a class="dropdown-item" href="login.aspx">Logout</a>
                </div>
            </li>
        </ul>
    </div>
</nav>

<script>

    $(document).ready(function () {
        populate_profile_details();
    });

    function sidebarToggle() {
        var isToggled = $(".sidebar").hasClass("toggled");
        var hasActivePage = $("#leaveSubMenu .nav-link").hasClass("active-page");

        $("#sidebarContainer").toggleClass("toggled");
        $(".sidebar").toggleClass("toggled");
        
        if (!isToggled) {
            $("#leaveSubMenu").collapse('hide');
        } else {
            if (hasActivePage) {
                $("#leaveSubMenu").collapse('show');
            }
        }

        document.cookie = "toggle=" + (!isToggled ? "1" : "0") + "; path=/";
    }

    function populate_profile_details() {
        $.ajax({
            type: "POST",
            url: 'dashboard.aspx/populate_profile_details',
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

                const cleanedResponse = response.d.replace(/^"|"$/g, '').replace(/\\"/g, '"');
                const data = JSON.parse(cleanedResponse);

                if (data && data.length > 0) {
                    const profileDetails = data[0];
                    const profileDropdown = $('#profileDropdown');
                    const profileImage = profileDetails.profile_img;
                    const profileLetters = profileDetails.profile_letters;
                    const profileColor = profileDetails.profile_color;

                    let profileHTML = '';

                    if (profileImage) {
                        profileHTML = `<img src="${profileImage}" alt="Profile Picture" class="rounded-circle" style="width: 30px; height: 30px;"> ${profileDetails.emp_name}`;
                    } else {
                        profileHTML = `
                        <span class="rounded-circle d-inline-flex justify-content-center align-items-center" 
                              style="width: 30px; height: 30px; background-color: ${profileColor}; color: white; font-weight: bold;">
                              ${profileLetters}
                        </span> ${profileDetails.emp_name}`;
                    }

                    profileDropdown.html(profileHTML);
                }
            },
            error: function () {
                Swal.fire("Issue while populating profile details!");
            }
        });
    }

</script>
