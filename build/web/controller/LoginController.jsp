<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

<%@page import="lk.studentsmanage.models.UserModel"%>
<%@page import="lk.studentsmanage.utils.Values"%>
<%@page import="lk.studentsmanage.utils.RetrofitClient"%>
<%@page import="lk.studentsmanage.services.LoginAPI"%>
<%@page import="retrofit2.Response"%>
<%@page import="retrofit2.Call"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String actionLogIn = request.getParameter("action");

    if (actionLogIn.equals("login")) {

        System.out.println("Log in started.");

        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("password");

        UserModel user = new UserModel();

        user.setUserId(userName);
        user.setPassword(userPassword);

        LoginAPI loginApi = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(LoginAPI.class);

        Call<UserModel> login = loginApi.login(user);

        Response<UserModel> res = null;
        UserModel u = null;

        res = login.execute();
        u = res.body();

        if (u != null) {
            session.setAttribute("userData", u);
            session.setAttribute("save_status", "0");

            try {
                if (u.getUserRole().equals("admin")) {
                    response.sendRedirect("../adminDashboard.jsp");
                } else if (u.getUserRole().equals("operator")) {
                    response.sendRedirect("../operatorDashboard.jsp");
                } else if (u.getUserRole().equals("teacher") || u.getUserRole().equals("student")) {
                    response.sendRedirect("../homePage.jsp");
                } else {
                    System.out.println("use role is null. Login failed.");
                    response.sendRedirect("../index.jsp?status=failed");
                }
            } catch (Exception e) {
                System.out.println("use role is null. Login failed.");
                response.sendRedirect("../index.jsp?status=failed");

            }

        } else {
            System.out.println("Login failed.");
            response.sendRedirect("../index.jsp?status=failed");
        }

    } else if (actionLogIn.equals("signin")) {

        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("password");
        String role = request.getParameter("role");

        UserModel user = new UserModel();

        user.setUserId(userName);
        user.setPassword(userPassword);
        user.setUserRole(role);

        LoginAPI signinApi = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(LoginAPI.class);

        Call<UserModel> signin = null;

        if (role.equals("student")) {
            signin = signinApi.signInStudent(user);
        } else if (role.equals("teacher")) {
            signin = signinApi.signInTeacher(user);
        } else {
            signin = signinApi.signInOperator(user);
        }

        Response<UserModel> res = null;
        UserModel u = null;

        res = signin.execute();
        u = res.body();

        if (u != null) {
            session.setAttribute("userData", u);
            session.setAttribute("save_status", "0");

            try {
                if (u.getUserRole().equals("admin")) {
                    response.sendRedirect("../adminDashboard.jsp");
                } else if (u.getUserRole().equals("operator")) {
                    response.sendRedirect("../operatorDashboard.jsp");
                } else if (u.getUserRole().equals("teacher") || u.getUserRole().equals("student")) {
                    response.sendRedirect("../homePage.jsp");
                } else {
                    System.out.println("use role is null. Login failed.");
                    response.sendRedirect("../signInPage.jsp?status=failed");
                }
            } catch (Exception e) {
                System.out.println("exception e " + e);
                response.sendRedirect("../signInPage.jsp?status=failed");

            }

        } else {
            System.out.println("Signin failed.");
            response.sendRedirect("../signInPage.jsp?status=failed");
        }

    }


%>

