<!DOCTYPE html>
<html>
    <head>
        <title>Sign In</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="assets/styles/indexPage.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>

    <% String status = "" + request.getParameter("status"); %>

    <body>

        <script type="text/javascript">

            $(document).ready(function () {

            <%if (status.equals("failed")) {%>

                $("#notificationHolder").css("display", "block");
                $(".failedAlert").hide().fadeIn(400).delay(1700).fadeOut(800, function () {
                    $(".failedAlert").fadeOut(1000, 500);
                    $("#notificationHolder").css("display", "none");
                });
            <%}%>
                
                window.history.replaceState(null, null, window.location.pathname);

                $('#password, #rePwInput').on('keyup', function () {
                    if ($('#password').val() === $('#rePwInput').val()) {
                        $('#signInButton').html("SignIn").css('background-color', 'green').prop("disabled", false);
                    } else {
                        $('#signInButton').html("Password mismatched.").css('background-color', 'red').prop("disabled", true);
                    }


                });

            });

        </script>

        <div class="notification" id="notificationHolder" style="display: none;">
            <div class="col-sm-3 failedAlert card m-2" style="float: right; background-color: green;"> 
                <div class="card-body">
                    <p style="color: white; font-size: 1.2em; margin: auto;">SignIn failed !</p> 
                </div>
            </div>
        </div>

        <div class="content">

            <form action="controller/LoginController.jsp">

                <div class="imgcontainer">
                    <img src="assets/images/schoolManage.png" alt="Avatar" class="avatar">
                </div>

                <div class="container">
                    <div class="labelHolder">
                        <label for="userName"><b>Username</b></label>
                    </div>
                    <input type="text" placeholder="Enter Username" name="userName" required>

                    <div class="labelHolder">
                        <label for="password"><b>Password</b></label>
                    </div>
                    <input type="password" placeholder="Enter Password" name="password" id="password" required>

                    <div class="labelHolder">
                        <label for="rePassword" id="rePwLabel"><b>Reenter Password</b></label>
                    </div>
                    <input type="password" placeholder="Reenter Password" name="rePassword" id="rePwInput" required>

                    <div class="labelHolder">
                        <label for="roleType" id="roleType"><b>Select the role</b></label>
                    </div>
                    
                    <input class="col-sm-2" type="radio" name="role" value="student" checked> Student
                    <input class="col-sm-2" type="radio" name="role" value="teacher"> Teacher
                    <input class="col-sm-2" type="radio" name="role" value="operator"> Operator

                    <input type="hidden" name="action" value="signin">

                    <div style="margin-top:4%;" class="actionButtons">
                        <button type="submit" id="signInButton">SignIn</button>
                    </div>

                </div>


            </form> 
        </div>
    </body>
</html>
