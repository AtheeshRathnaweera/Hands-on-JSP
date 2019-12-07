<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

<%@page import="lk.studentsmanage.models.UserModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="lk.studentsmanage.services.TeacherAPI"%>
<%@page import="java.util.List"%>
<%@page import="lk.studentsmanage.models.TeacherModel"%>
<%@page import="lk.studentsmanage.utils.Values"%>
<%@page import="lk.studentsmanage.utils.RetrofitClient"%>
<%@page import="retrofit2.Response"%>
<%@page import="retrofit2.Call"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%!
    TeacherAPI teacherAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(TeacherAPI.class);

    public TeacherModel getTeacherDetails(String nic) {

        Call<TeacherModel> teacherDataCall = teacherAPI.getTeacherDetails(nic);

        TeacherModel teacherData = new TeacherModel();

        try {
            teacherData = teacherDataCall.execute().body();
            System.out.println("received teacher : " + teacherData.toString());
        } catch (Exception e) {
            System.out.println("Exception in teacher Controller : " + e);
        }

        return teacherData;

    }

    public Long getTeachersCountOfTheSchool() {

        Call<Long> teacherCountCall = teacherAPI.getTeachersCount();

        Long results = null;

        try {
            results = teacherCountCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in Teacher controller : getTeachersCount 51" + e);
        }

        return results;

    }

    public List<TeacherModel> getAllTeachers() {

        Call<List<TeacherModel>> allTeachersCall = teacherAPI.getAllTeachers();

        List<TeacherModel> results = new ArrayList<>();

        try {
            results = allTeachersCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in Teacher controller : getAllTeachers 67 " + e);
        }

        return results;
    }


%>

