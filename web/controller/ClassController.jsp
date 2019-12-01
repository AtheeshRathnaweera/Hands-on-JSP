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

    String actionCl = "" + request.getParameter("action");
    String clGrade = "" + request.getParameter("classGrade");
    String clId = "" + request.getParameter("classId");
    String clName = "" + request.getParameter("className");

    if (actionCl.equals("addAClass")) {
        
        System.out.println("add a new class method started.");

        ClassModel tempClass = new ClassModel();

        tempClass.setGrade(Integer.parseInt(clGrade));
        tempClass.setName(clName);

        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<ClassModel> save = classAPI.saveAClass(tempClass);

        ClassModel ss = save.execute().body();

        if (ss != null) {
            session.setAttribute("save_status", "1");
            response.sendRedirect("../classPage.jsp?grade=" + clGrade+"&status=saved");

        } else {
            session.setAttribute("save_status", "0");
            response.sendRedirect("../classPage.jsp?grade=" + clGrade+"&status=saveFailed");
        }

    } else if (actionCl.equals("addAStudent")) {

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
        tempStudent.setCurrentClassId(Integer.parseInt(clId));

        System.out.println("object : " + tempStudent.toString());

        ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);
        Call<Boolean> save = classAPI.AddAStudent(tempStudent);
        Boolean ss = save.execute().body();

        if (ss) {
            response.sendRedirect("./studentDetails.jsp?grade=" + clGrade + "&class=" + clId + "&name=" + clName + "&status=saved");

        } else {
            response.sendRedirect("./studentDetails.jsp?grade=" + clGrade + "&class=" + clId + "&name=" + clName + "&status=notSaved");
        }

    }

%>

<%!
    ClassAPI classAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

    public Long getAllClassCount() {

        Call<Long> classAmountCall = classAPI.getAllCount();
        Long count = null;

        try {
            count = classAmountCall.execute().body();
            System.out.println("counttt: "+count);
        } catch (Exception e) {
            System.out.println("Exception occur in ClassController : getAllClassCount : 121 " + e);
        }

        return count;

    }

    public Long getClassAmountOfAGrade(int grade) {

        Call<Long> classAmountCall = classAPI.getClassAmountOfAGrade(grade);
        Long count = null;

        try {
            count = classAmountCall.execute().body();
        } catch (Exception e) {
            System.out.println("Exception occur in ClassController : getAllClassCount : 121 " + e);
        }

        return count;

    }

    public int getStudentAmountOfAClass(int classId) {

        System.out.println("getStudentAmountClass started.");

        Call<Long> classAmountCall = classAPI.getStudentAmountOfAClass(classId);
        Long count = null;

        try {
            count = classAmountCall.execute().body();
            System.out.println("amount of classes : "+count);
        } catch (Exception e) {
            System.out.println("Exception occur in ClassController : getAllClassCount : 121 " + e);
        }

        if(count == null){
            return 0;
        }

        return count.intValue();

    }

    public List<ClassModel> getAllClassesByGrade(int grade) {

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

    public List<TeacherModel> getClassTeacher(int classId) {

        ClassAPI teacherAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<List<TeacherModel>> teacherDataCall = teacherAPI.getClassTeacher(classId);

        List<TeacherModel> recTeacherData = new ArrayList<>();

        try {
            recTeacherData = teacherDataCall.execute().body();
            System.out.println("received teacher data : " + recTeacherData.toString());
        } catch (Exception e) {
            System.out.println("Exception in class Controller : " + e);
        }

        return recTeacherData;
    }

    public String getClassTeacherName(int classId) {
        ClassAPI teacherAPI = RetrofitClient.getRetrofitClient(Values.MAINURL).getRetrofit().create(ClassAPI.class);

        Call<List<TeacherModel>> teacherDataCall = teacherAPI.getClassTeacher(classId);

        List<TeacherModel> recTeacherData = new ArrayList<>();
        String result = "Not assigned";

        try {
            recTeacherData = teacherDataCall.execute().body();

            if (recTeacherData.size() != 0) {
                result = recTeacherData.get(0).getFirstName() + " " + recTeacherData.get(0).getLastName();

            }
            System.out.println("received teacher data : " + recTeacherData.toString());
            
        } catch (Exception e) {
            System.out.println("Exception in class Controller : " + e);
        }

        return result;

    }
%>

