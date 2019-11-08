<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="lk.studentsmanage.services.StudentAPI"%>
<%@page import="java.util.List"%>
<%@page import="lk.studentsmanage.models.StudentModel"%>
<%@page import="lk.studentsmanage.utils.Values"%>
<%@page import="lk.studentsmanage.utils.RetrofitClient"%>
<%@page import="retrofit2.Response"%>
<%@page import="retrofit2.Call"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%!
    public StudentModel getStudentDetails(String admissionNumber) {

        StudentAPI studentAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(StudentAPI.class);

        Call<StudentModel> studentDataCall = studentAPI.getStudentDetails(admissionNumber);

        StudentModel studentData = new StudentModel();

        try {

            studentData = studentDataCall.execute().body();

            System.out.println("received student : " + studentData.getFirstName());
        } catch (Exception e) {
            System.out.println("Exception in Student Controller : " + e);
        }

        return studentData;

    }

    public Long getStudentUsersCount() {

        StudentAPI studentAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(StudentAPI.class);
        Call<ArrayList<Long>> studentCountCall = studentAPI.getStudentUsersCount();

        ArrayList<Long> results = new ArrayList<>();
        Long sCount = null;

        try {
            results = studentCountCall.execute().body();

            System.out.println("result : " + results.toString()  +"  "+results.get(0));
            sCount = results.get(0);

        } catch (Exception e) {
            System.out.println("Exception in Student controller : " + e);

        }

        return sCount;

    }

%>

