<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

<%@page import="retrofit2.Response"%>
<%@page import="retrofit2.Call"%>
<%@page import="Models.UserModel"%>
<%@page import="Services.LoginAPI"%>
<%@page import="Utils.Values"%>
<%@page import="Utils.RetrofitClient"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String action = request.getParameter("action");
    String userName = "not found";
    String userPassword = "not found";

    if (action.equals("login")) {

        System.out.println("Log in started.");

        userName = request.getParameter("userName");
        userPassword = request.getParameter("password");

        UserModel user = new UserModel();

        user.setUserName(userName);
        user.setUserPassword(userPassword);

        LoginAPI loginApi = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(LoginAPI.class);

        Call<UserModel> login = loginApi.login(user);

        Response<UserModel> res = null;
        UserModel u = null;

        try {
            res = login.execute();
            u = res.body();

            if (userName.equals("atheesh") && userPassword.equals("mahela")) {
                System.out.println("matched");
                response.sendRedirect("../homePage.html");
            } else {
                System.out.println("not matched");
                //request.setAttribute("errorMessage", "Invalid user or password");
                //request.getRequestDispatcher("../index.html").forward(request, response);

            }

        } catch (Exception e) {
            response.sendRedirect("../index.jsp?err=upinc");

        }

    }


%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

    </body>
</html>
