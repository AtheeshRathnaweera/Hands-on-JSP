<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

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
            System.out.println("received teacher : "+teacherData.toString());

        } catch (Exception e) {
            System.out.println("Exception in teacher Controller : " + e);
        }

        return teacherData;

    }
   
%>

