<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="hrms.testing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>testing</title>
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
            max-width: 400px;
            margin-top: 50px;
        }

        .card {
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .timer {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div id="login-section">
                <h4 class="text-center">Sign In</h4>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" class="form-control" placeholder="Enter username" />
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" class="form-control" placeholder="Enter password" />
                </div>
                <button onclick="login_info()" class="btn btn-primary w-100">Login</button>
                <p class="text-center mt-3">
                    <a href="#" onclick="showOTPForm()">Login via OTP</a>
                </p>
            </div>

            <div id="otp-section" style="display: none;">
                <h4 class="text-center">Login via OTP</h4>
                <div class="form-group">
                    <label for="otp-input">Enter Email or Mobile</label>
                    <input type="text" id="otp-input" class="form-control" placeholder="Email or Mobile" />
                </div>
                <button onclick="sendOTP()" class="btn btn-primary w-100">Send OTP</button>
                <button onclick="showLoginForm()" class="btn btn-secondary w-100 mt-2">Back to Login</button>

                <div id="otp-entry-section" style="display: none;">
                    <label class="mt-3" for="entered-otp">Enter OTP</label>
                    <input type="text" id="entered-otp" class="form-control" placeholder="Enter OTP" />
                    <small class="timer" id="otp-timer"></small>
                    <button onclick="verifyOTP()" class="btn btn-success w-100 mt-2">Login</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let otpTimer;
        let countdown = 120; // 2 minutes
        let generatedOTP = "123456"; // Simulated OTP (Replace with actual backend OTP logic)

        function showOTPForm() {
            $("#login-section").hide();
            $("#otp-section").show();
        }

        function showLoginForm() {
            $("#otp-section").hide();
            $("#login-section").show();
        }

        function sendOTP() {
            let userInput = $("#otp-input").val().trim();
            if (userInput === "") {
                Swal.fire("Error!", "Please enter your email or mobile number.", "error");
                return;
            }

            Swal.fire("Success!", "OTP sent successfully!", "success");
            $("#otp-entry-section").show();
            startOTPTimer();
        }

        function startOTPTimer() {
            clearInterval(otpTimer);
            countdown = 120;
            $("#otp-timer").text(`Time left: ${countdown}s`);

            otpTimer = setInterval(() => {
                countdown--;
                $("#otp-timer").text(`Time left: ${countdown}s`);

                if (countdown <= 0) {
                    clearInterval(otpTimer);
                    $("#entered-otp").val("");
                    $("#otp-entry-section").hide();
                    Swal.fire("Time Expired!", "OTP expired, please request a new one.", "warning");
                }
            }, 1000);
        }

        function verifyOTP() {
            let enteredOTP = $("#entered-otp").val().trim();
            if (enteredOTP === generatedOTP) {
                Swal.fire("Success!", "Logged in successfully!", "success").then(() => {
                    window.location.href = "dashboard.aspx"; // Redirect to the dashboard
                });
            } else {
                Swal.fire("Error!", "Invalid OTP. Please try again.", "error");
            }
        }

        function login_info() {
            let username = $("#username").val().trim();
            let password = $("#password").val().trim();

            if (username === "" || password === "") {
                Swal.fire("Error!", "Invalid username or password.", "error");
            } else {
                Swal.fire("Success!", "Logged in successfully!", "success").then(() => {
                    window.location.href = "dashboard.aspx";
                });
            }
        }
    </script>
</body>
</html>
