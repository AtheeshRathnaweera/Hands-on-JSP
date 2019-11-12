<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

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
 

    if (actionClass.equals("addAClass")) {
        String grade = request.getParameter("classGrade");
        String name = request.getParameter("className");
        
        ClassModel tempClass = new ClassModel();
        
        tempClass.setGrade(Integer.parseInt(grade));
        tempClass.setName(name);
        
        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);
        
        Call<Boolean> save = classAPI.saveAClass(tempClass);

        Boolean ss = save.execute().body();

        if (ss) {
            response.sendRedirect("./studentDetails.jsp?grade="+grade+"&status=saved");
        } else {
            response.sendRedirect("./studentDetails.jsp?grade="+grade+"&status=notSaved");
        }
    
    }else if(actionClass.equals("addAStudent")){
        
        String classId = request.getParameter("classId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        
        StudentModel tempStudent = new StudentModel();
        
        tempStudent.setFirstName(firstName);
        tempStudent.setLastName(lastName);
        
        tempStudent.setCurrentClassId(Integer.parseInt(classId));
        
        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);
        
        Call<Boolean> save = classAPI.AddAStudent(tempStudent);

        Boolean ss = save.execute().body();

        if (ss) {
            response.sendRedirect("./studentDetails.jsp?grade=&status=saved");
        } else {
            response.sendRedirect("./studentDetails.jsp?grade=&status=notSaved");
        }
    
    }

%>

<%!
    public List<ClassModel> getAllClassesByGrade(int grade) {

        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<List<ClassModel>> classDataCall = classAPI.getAllClassesByGrade(grade);

        List<ClassModel> recClassData = new ArrayList<>();

        try {
            recClassData = classDataCall.execute().body();
            System.out.println("received class amount : " + recClassData.size());
        } catch (Exception e) {
            System.out.println("Exception in class Controller : " + e);
        }

        return recClassData;

    }

    public List<StudentModel> getAllStudentsOfAClass(int classId) {

        ClassAPI studentsAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<List<StudentModel>> studentDataCall = studentsAPI.getAllStudentsByClass(classId);

        List<StudentModel> recStudentsData = new ArrayList<>();

        try {
            recStudentsData = studentDataCall.execute().body();
            System.out.println("received student amount : " + recStudentsData.size());
        } catch (Exception e) {
            System.out.println("Exception in class Controller : " + e);
        }

        return recStudentsData;

    }

 


%>

