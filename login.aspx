<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="hrms.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <title>Login</title>

    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            position: relative;
            width: 420px;
        }

        .card {
            width: 100%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            margin: auto;
        }

        .info-box {
            position: absolute;
            top: 0;
            right: -350px;
            width: 300px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #fdfdfd;
            text-align: center;
        }

        .image-container {
            margin-top: 30px;
            text-align: center;
        }

            .image-container img {
                max-width: 100%;
                height: auto;
                max-height: 80px;
            }


        .input-group {
            margin-bottom: 20px;
        }

            .input-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
            }

            .input-group input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100%;
                box-sizing: border-box;
            }

        .input-container {
            position: relative;
        }

            .input-container .btn {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
            }

        .btn-shadow {
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }

        .link {
            font-size: 12px;
            text-decoration: none;
        }

        .link-secondary {
            color: #6c757d;
        }

            .link-secondary:hover {
                text-decoration: underline;
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
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-start mt-5">
        <div class="card">
            <h4 class="card-title text-center my-3 font-weight-bold">Sign In</h4>
            <p class="text-muted text-center">Please login to access the dashboard.</p>
            <div class="form-group mt-3">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="e.g. jane.doe@acme.com" />
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Use alphanumeric characters" />
                    <div class="input-container">
                        <button type="button" class="btn" style="box-shadow: none;" id="toggle-password">
                            <i class="fa fa-eye" id="password-icon"></i>
                        </button>
                    </div>
                </div>
                <button onclick="login_info()" class="btn btn-secondary btn-shadow w-100 mt-4 mb-4" style="background-color: hsl(8,77%,56%)">
                    <i class="fa-solid fa-lock mr-1"></i>
                    Secure Sign-in
                </button>
                <div class="text-center mt-3">
                    <small>
                        <a onclick="window.location.href = 'forgot-password.aspx'" class="link link-secondary" style="color: hsl(8,77%,56%);">Forgot password?</a>
                    </small>
                </div>
            </div>
        </div>

        <div id="right-after-card" style="width: 500px; left: 100%; background-color: transparent; border: none; box-shadow: none" class="info-box">
            <div id="alert-message" class="alert alert-danger alert-custom" role="alert"
                style="border-radius: 0; height: 65px; background-color: hsl(0,75%,97%); display: none; border-left: 5px solid #dc3545; align-items: center;">
                <strong style="display: inline-flex; align-items: center; height: 100%; margin-left: 0; padding-left: 0px;">
                    <i class="fa-sharp fa-solid fa-circle-exclamation mr-3"></i>
                </strong>
                <span style="color: black; line-height: 1.5;">Invalid username or password.</span>
                <button type="button" id="close_alert_message" style="margin-left: auto; padding-bottom: 1%; box-shadow: none; border: none; outline: none;" class="close mt-1">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
    </div>

    <div class="image-container">
        <img src="/asset/hrms_icon.jpg" alt="HRMS Icon" />
    </div>

    <script>
        $('#close_alert_message').click(function () {
            document.getElementById("alert-message").style.display = 'none';
            $('body').css('overflow', 'hidden');
        });

        document.getElementById('toggle-password').addEventListener('click', function () {
            const passwordField = document.getElementById('password');
            const passwordIcon = document.getElementById('password-icon');

            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                passwordIcon.classList.remove('fa-eye');
                passwordIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                passwordIcon.classList.remove('fa-eye-slash');
                passwordIcon.classList.add('fa-eye');
            }
        });

        function login_info() {
            var username = $("#username").val();
            var password = $("#password").val();
            if (username == "" || password == "") {
                $("#alert-message").show();
                document.getElementById("alert-message").style.display = 'flex';
                $('body').css('overflow', 'hidden');
                setTimeout(function () {
                    document.getElementById("alert-message").style.display = 'none';
                }, 2000);
            } else {
                $.ajax({
                    type: "POST",
                    url: 'login.aspx/login_info',
                    data: JSON.stringify({ username: username, password: password }),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (response) {
                        if (response.d == "true") {
                            sessionStorage.setItem('showAlert', 'true');
                            window.location.href = "dashboard.aspx";
                        } else {
                            $("#alert-message").show();
                            document.getElementById("alert-message").style.display = 'flex';
                            $('body').css('overflow', 'hidden');
                            setTimeout(function () {
                                document.getElementById("alert-message").style.display = 'none';
                            }, 2000);
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
        }

    </script>
</body>
</html>

