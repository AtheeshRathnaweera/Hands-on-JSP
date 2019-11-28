<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

<%@page import="lk.studentsmanage.services.OperatorAPI"%>
<%@page import="lk.studentsmanage.models.UserModel"%>
<%@page import="lk.studentsmanage.services.AdminAPI"%>
<%@page import="lk.studentsmanage.models.OperatorModel"%>
<%@page import="lk.studentsmanage.models.TeacherModel"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="lk.studentsmanage.services.ClassAPI"%>
<%@page import="lk.studentsmanage.models.ClassModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="lk.studentsmanage.services.StudentAPI"%>
<%@page import="java.util.List"%>
<%@page import="lk.studentsmanage.models.StudentModel"%>
<%@page import="lk.studentsmanage.utils.Values"%>
<%@page import="lk.studentsmanage.utils.RetrofitClient"%>
<%@page import="retrofit2.Response"%>
<%@page import="retrofit2.Call"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%

    String actionClass = "" + request.getParameter("action");
    String classGrade = "" + request.getParameter("classGrade");
    String classId = "" + request.getParameter("classId");
    String className = "" + request.getParameter("className");

    if (actionClass.equals("addOperator")) {

        String nic = request.getParameter("nic");
        String fName = request.getParameter("firstName");
        String lName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String status = request.getParameter("status");
        String birthday = request.getParameter("birthday");
        String enrolledDate = request.getParameter("enrolledDate");

        OperatorModel tempOp = new OperatorModel(nic, fName, lName, birthday, address, enrolledDate, status);

        System.out.println("resut : " + tempOp.toString());

        OperatorAPI adminOpAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(OperatorAPI.class);

        Call<OperatorModel> save = adminOpAPI.addNewOperator(tempOp);

        OperatorModel ss = save.execute().body();

        if (ss != null) {
            session.setAttribute("save_status", "1");

            response.sendRedirect("../adminDashboard.jsp?status=savedOp");

        } else {
            session.setAttribute("save_status", "0");
            response.sendRedirect("../adminDashboard.jsp?status=savedOp");
        }

    } else if (actionClass.equals("accessOperator")) {
        String newStatus = "" + request.getParameter("status");
        String nic = ""+request.getParameter("nic");
        OperatorAPI adminOpAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(OperatorAPI.class);

        Call<Boolean> save = adminOpAPI.updateStatus(nic, newStatus);

        Boolean ss = save.execute().body();
        
        System.out.println("recccccccccc: status : "+newStatus+" nicc: "+nic);

        if (ss) {
            session.setAttribute("save_status", "1");
            response.sendRedirect("../adminDashboard.jsp?status=savedOp");

        } else {
            session.setAttribute("save_status", "0");
            response.sendRedirect("../adminDashboard.jsp?status=savedOp");
        }
    }

%>

<%!
    public List<UserModel> getAllStudentUsers() {
        AdminAPI adminAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(AdminAPI.class);
        Call<List<UserModel>> studentUsersCall = adminAPI.getAllStudentUsers();

        List<UserModel> recUsersData = new ArrayList<>();

        try {
            recUsersData = studentUsersCall.execute().body();
            System.out.println("received student users amount : " + recUsersData.size());
        } catch (Exception e) {
            System.out.println("Exception in admin Controller : 125" + e);
        }

        return recUsersData;

    }

    public List<UserModel> getAllTeacherUsers() {
        AdminAPI adminAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(AdminAPI.class);
        Call<List<UserModel>> teacherUsersCall = adminAPI.getAllTeacherUsers();

        List<UserModel> recUsersData = new ArrayList<>();

        try {
            recUsersData = teacherUsersCall.execute().body();
            System.out.println("received teacher users amount : " + recUsersData.size());
        } catch (Exception e) {
            System.out.println("Exception in admin Controller : 142" + e);
        }

        return recUsersData;

    }

    public List<OperatorModel> getAllOperators() {

        AdminAPI adminAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(AdminAPI.class);
        Call<List<OperatorModel>> operatorsCall = adminAPI.getAllOperators();

        List<OperatorModel> recUsersData = new ArrayList<>();

        try {
            recUsersData = operatorsCall.execute().body();
            System.out.println("received operators amount : " + recUsersData.size());
        } catch (Exception e) {
            System.out.println("Exception in operator Controller : 160" + e);
        }

        return recUsersData;

    }

    public Long getAllOperatorsCount() {

        AdminAPI adminAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(AdminAPI.class);

        Call<Long> adminDataCall = adminAPI.getAllOperatorsCount();

        Long countOp = null;

        try {
            countOp = adminDataCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in admin Controller : 125" + e);
        }

        return countOp;

    }

    public Long getAllTeachersCount() {

        AdminAPI adminAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(AdminAPI.class);

        Call<Long> adminDataCall = adminAPI.getAllTeacherUsersCount();

        Long countT = null;

        try {
            countT = adminDataCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in admin Controller : 143" + e);
        }

        return countT;

    }

    public Long getAllStudentsCount() {

        AdminAPI adminAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(AdminAPI.class);

        Call<Long> adminDataCall = adminAPI.getAllStudentUsersCount();

        Long countS = null;

        try {
            countS = adminDataCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in admiin Controller : 162" + e);
        }

        return countS;

    }


%>

