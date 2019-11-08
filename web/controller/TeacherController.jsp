<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

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
    public TeacherModel getTeacherDetails(String nic) {

        TeacherAPI teacherAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(TeacherAPI.class);

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

    public Long getTeacherUsersCount() {

        TeacherAPI teacherAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(TeacherAPI.class);
        Call<ArrayList<Long>> teacherCountCall = teacherAPI.getTeacherUsersCount();

        ArrayList<Long> results = new ArrayList<>();
        Long tCount = null;

        try {
            results = teacherCountCall.execute().body();

            System.out.println("result : " + results.toString() + "  " + results.get(0));
            tCount = results.get(0);

        } catch (Exception e) {
            System.out.println("Exception in Teacher controller : " + e);

        }

        return tCount;

    }


%>

