<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgot-password.aspx.cs" Inherits="hrms.forgot_password" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>

    <title>Forgot Password</title>

    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            width: 420px;
        }

        .card {
            width: 100%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            margin-bottom: 10%;
        }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-start mt-5">
        <div class="card forgetpassword" id="forgetpassword">
            <h4 class="card-title text-center my-3 font-weight-bold">Forgot Password?</h4>
            <p class="text-muted text-center">Type in your email to reset the password</p>
            <form method="post">
                <input type="hidden" name="csrfmiddlewaretoken" />
                <div class="form-group mt-3">
                    <label for="email">Username</label>
                    <input type="text" name="email" id="email" class="form-control" placeholder="e.g. jane.doe@acme.com" autofocus="" required="" />
                </div>
                <button type="submit" class="btn btn-secondary btn-shadow w-100 mt-4 mb-4" style="background-color: hsl(8,77%,56%)">Send Link</button>
            </form>
        </div>
    </div>
    <script>

</script>
</body>
</html>
