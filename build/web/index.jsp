<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Index</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="assets/styles/indexPage.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/table-to-json@0.13.0/lib/jquery.tabletojson.min.js" integrity="sha256-AqDz23QC5g2yyhRaZcEGhMMZwQnp8fC6sCZpf+e7pnw=" crossorigin="anonymous"></script>

    </head>


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


                    <input type="hidden" name="action" value="login" > <!--Store the form action type-->


                    <div style="margin-top:4%;" class="actionButtons">
                        <button type="submit" id="logInButton">Login</button>
                        <label id="orText">
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

    String role = (String) ""+session.getAttribute("userRole");
    String userId = (String) ""+session.getAttribute("UserId");

    if (!role.equals("null") && !userId.equals("null")) {
        System.out.println("index : role and userid is not null");
        response.sendRedirect("homePage.jsp");
        return;
    }else{
        System.out.println("should login");
    }

%>

</html>
