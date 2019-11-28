<!DOCTYPE html>
<html>
    <head>
        <title>Sign In</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="assets/styles/indexPage.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/table-to-json@0.13.0/lib/jquery.tabletojson.min.js" integrity="sha256-AqDz23QC5g2yyhRaZcEGhMMZwQnp8fC6sCZpf+e7pnw=" crossorigin="anonymous"></script>

    </head>

    <script type="text/javascript">
        $(document).ready(function () {
 
            $('#password, #rePwInput').on('keyup', function () {
                if ($('#password').val() === $('#rePwInput').val()) {
                    $('#signInButton').html("SignIn").css('background-color', 'green').prop("disabled", false);
                } else {
                    $('#signInButton').html("Password mismatched.").css('background-color', 'red').prop("disabled", true);
                }


            });
        });
    </script>
    
    <body>

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
                    <input type="radio" name="role" value="student" checked> Student
                    <input type="radio" name="role" value="teacher" > Teacher
                    <input type="radio" name="role" value="teacher" > Operator


                    <input type="hidden" name="action" value="signin">


                    <div style="margin-top:4%;" class="actionButtons">
                        <button type="submit" id="signInButton">SignIn</button>
                       
                       
                    </div>

                </div>


            </form> 
        </div>
    </body>
</html>
