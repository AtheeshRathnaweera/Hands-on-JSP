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

        System.out.println("student login status :  " + response.getStatus());

        res = login.execute();
        u = res.body();

        System.out.println("students login res : " + u.toString());

        if (u != null) {
            if (u.getUserRole() != null) {
                session.setAttribute("userId", u.getUserId());
                session.setAttribute("userRole", u.getUserRole());
                session.setAttribute("save_status","0");
                response.sendRedirect("../homePage.jsp");

            } else {
                System.out.println("Log in failed.");
                response.sendRedirect("../index.jsp?err=upinc");
            }
        } else {
            System.out.println("Login failed.");
            response.sendRedirect("../index.jsp?err=upinc");
        }

    } else if (actionLogIn.equals("signin")) {
        System.out.println("Signin started");

        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("password");
        String role = request.getParameter("role");

        UserModel user = new UserModel();

        user.setUserId(userName);
        user.setPassword(userPassword);
        user.setUserRole(role);

        System.out.println(user.toString());

        LoginAPI signinApi = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(LoginAPI.class);
        
        Call<UserModel> signin = null;

        if (role.equals("student")) {
            signin = signinApi.signInStudent(user);
        } else {
            signin = signinApi.signInTeacher(user);
        }

        Response<UserModel> res = null;
        UserModel u = null;

        System.out.println("signin status :  " + response.getStatus());

        res = signin.execute();
        u = res.body();

        if (u != null) {
            if (u.getUserRole() != null) {
                session.setAttribute("userId", u.getUserId());
                session.setAttribute("userRole", u.getUserRole());
                session.setAttribute("save_status","0");
                response.sendRedirect("../homePage.jsp");

            } else {
                System.out.println("Signin in failed.");
                response.sendRedirect("../index.jsp?err=upinc");
            }
        } else {
            System.out.println("Signin failed.");
            response.sendRedirect("../index.jsp?err=upinc");
        }

    }


%>

