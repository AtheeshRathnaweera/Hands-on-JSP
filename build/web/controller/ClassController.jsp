<%-- 
    Document   : LoginController
    Created on : Oct 12, 2019, 11:00:11 PM
    Author     : User
--%>

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

    if (actionClass.equals("addAClass")) {

        ClassModel tempClass = new ClassModel();

        tempClass.setGrade(Integer.parseInt(classGrade));
        tempClass.setName(className);

        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<Boolean> save = classAPI.saveAClass(tempClass);

        Boolean ss = save.execute().body();

        if (ss) {
            session.setAttribute("save_status", "1");

            response.sendRedirect("./studentDetails.jsp?grade=" + classGrade);

        } else {
            session.setAttribute("save_status", "0");
            response.sendRedirect("./studentDetails.jsp?grade=" + classGrade);
        }

    } else if (actionClass.equals("addAStudent")) {

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date birthDate = null;
        Date enrolledDate = null;

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String birthday = request.getParameter("bDate");
        String enrolledDateRec = request.getParameter("eDate");
        String admissionNumber = request.getParameter("admissionNumber");

        System.out.println(" b : " + birthday + "  e: " + enrolledDateRec);

        StudentModel tempStudent = new StudentModel();

        tempStudent.setAdmissionNumber(Long.parseLong(admissionNumber));
        tempStudent.setFirstName(firstName);
        tempStudent.setLastName(lastName);
        tempStudent.setAddress(address);

        String upBdate = "";

        try {
            birthDate = df.parse(birthday);
            enrolledDate = df.parse(enrolledDateRec);

        } catch (ParseException e) {
            e.printStackTrace();
        }

        tempStudent.setBday(birthday);
        tempStudent.setEnrolledDate(enrolledDateRec);
        tempStudent.setCurrentClassId(Integer.parseInt(classId));

        System.out.println("object : " + tempStudent.toString());

        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);
        Call<Boolean> save = classAPI.AddAStudent(tempStudent);
        Boolean ss = save.execute().body();

        if (ss) {
            response.sendRedirect("./studentDetails.jsp?grade=" + classGrade + "&class=" + classId + "&name=" + className + "&status=saved");

        } else {
            response.sendRedirect("./studentDetails.jsp?grade=" + classGrade + "&class=" + classId + "&name=" + className + "&status=notSaved");
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

    public TeacherModel getClassTeacher(int classId) {

        ClassAPI teacherAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<TeacherModel> teacherDataCall = teacherAPI.getClassTeacher(classId);

        TeacherModel recTeacherData = new TeacherModel();

        try {
            recTeacherData = teacherDataCall.execute().body();
            System.out.println("received teacher data : " + recTeacherData.toString());
        } catch (Exception e) {
            System.out.println("Exception in class Controller : " + e);
        }

        return recTeacherData;
    }


%>

