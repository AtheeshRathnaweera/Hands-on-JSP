<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

<%@page import="lk.studentsmanage.models.StudentHistory"%>
<%@page import="lk.studentsmanage.models.UserModel"%>
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
    StudentAPI studentAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(StudentAPI.class);

    public StudentModel getStudentDetails(String admissionNumber) {

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

    public Long getAllStudentsCountOfTheSchool() {

        Call<Long> studentCountCall = studentAPI.getStudentCount();

        Long results = null;

        try {
            results = studentCountCall.execute().body();
            System.out.println("student : " + results);
        } catch (Exception e) {
            System.out.println("Exception in Student controller : " + e);

        }

        return results;

    }

    public List<StudentModel> getAllStudents() {

        Call<List<StudentModel>> studentCountCall = studentAPI.getAllStudents();

        List<StudentModel> results = new ArrayList<>();

        try {
            results = studentCountCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in Student controller : 71" + e);

        }

        return results;

    }

    public List<StudentHistory> getStudentHistory(String admissionNumber) {
        Call<List<StudentHistory>> studentCountCall = studentAPI.getStudentHistory(admissionNumber);

        List<StudentHistory> results = new ArrayList<>();

        try {
            results = studentCountCall.execute().body();

        } catch (Exception e) {
            System.out.println("Exception in Student controller : 88" + e);

        }

        return results;
    }

    public StudentHistory saveTheTermTestResults(StudentHistory recObject) {
        Call<StudentHistory> studentResultSaveCall = studentAPI.saveTermTestResults(recObject);

        StudentHistory result = null;

        try {
            result = studentResultSaveCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception in Student controller : 104" + e);

        }
        return result;

    }


%>

