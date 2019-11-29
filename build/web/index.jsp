<%@page import="lk.studentsmanage.models.UserModel"%>
<!DOCTYPE html>

<html>
    <head>
        <title>School Management System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="assets/styles/indexPage.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


    </head>

    <% String status = "" + request.getParameter("status"); %>


    <body>

        <script>

            $(document).ready(function () {

            <%if (status.equals("failed")) {%>

                $("#notificationHolder").css("display", "block");
                $(".failedAlert").hide().fadeIn(400).delay(1700).fadeOut(800, function () {
                    $(".failedAlert").fadeOut(1000, 500);
                    $("#notificationHolder").css("display", "none");
                });
            <%}%>
                window.history.replaceState(null, null, window.location.pathname);

            });

        </script>

        <div class="notification" id="notificationHolder" style="display: none;">
            <div class="col-sm-3 failedAlert card m-2" style="float: right; background-color: green;"> 
                <div class="card-body">
                    <p style="color: white; font-size: 1.2em; margin: auto;">Login failed !</p> 
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
                        <label for="userName"><b>User ID</b></label>
                    </div>
                    <input type="text" placeholder="Enter Username" name="userName" required>

                    <div class="labelHolder">
                        <label for="password"><b>Password</b></label>
                    </div>
                    <input type="password" placeholder="Enter Password" name="password" id="password" required>


                    <input type="hidden" name="action" value="login" > <!--Store the form action type-->


                    <div style="margin-top:4%;" class="actionButtons">
                        <button type="submit" id="logInButton">Login</button>
                        <label id="orText" style="width: 100%; text-align: center;">
                            or 
                        </label>
                        <a href="signInPage.jsp"><button type="button" id="signInButton">SignIn from here</button></a>
                    </div>

                </div>


            </form> 
        </div>
    </body>

    <%
        String statusLogin = (String) request.getParameter("status");

        if (statusLogin != null) {
            if (statusLogin.equals("logout")) {
                session.removeAttribute("userRole");
                session.removeAttribute("userId");
                session.invalidate();
                return;

            }
        }

        UserModel userData = (UserModel) session.getAttribute("userData");

        if (userData != null) {
            if (userData.getUserRole() != null) {
                if (userData.getUserRole().equals("operator")) {
                    System.out.println("index : role and userid is not null");
                    response.sendRedirect("operatorDashboard.jsp");
                    return;
                } else if(userData.getUserRole().equals("admin")){
                    System.out.println("index : role and userid is not null");
                    response.sendRedirect("adminDashboard.jsp");
                    return;             
                }else {
                    System.out.println("index : role and userid is not null");
                    response.sendRedirect("homePage.jsp");
                    return;
                }
            } else {
                System.out.println("should login");
            }
        }


    %>

</html>
