package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import lk.studentsmanage.models.UserModel;
import java.text.SimpleDateFormat;
import lk.studentsmanage.models.StudentModel;
import lk.studentsmanage.models.UserModel;
import java.util.ArrayList;
import lk.studentsmanage.services.StudentAPI;
import java.util.List;
import lk.studentsmanage.models.StudentModel;
import lk.studentsmanage.utils.Values;
import lk.studentsmanage.utils.RetrofitClient;
import retrofit2.Response;
import retrofit2.Call;
import lk.studentsmanage.models.UserModel;
import java.util.ArrayList;
import lk.studentsmanage.services.TeacherAPI;
import java.util.List;
import lk.studentsmanage.models.TeacherModel;
import lk.studentsmanage.utils.Values;
import lk.studentsmanage.utils.RetrofitClient;
import retrofit2.Response;
import retrofit2.Call;
import lk.studentsmanage.services.OperatorAPI;
import lk.studentsmanage.models.UserModel;
import lk.studentsmanage.services.AdminAPI;
import lk.studentsmanage.models.OperatorModel;
import lk.studentsmanage.models.TeacherModel;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import lk.studentsmanage.services.ClassAPI;
import lk.studentsmanage.models.ClassModel;
import java.util.ArrayList;
import lk.studentsmanage.services.StudentAPI;
import java.util.List;
import lk.studentsmanage.models.StudentModel;
import lk.studentsmanage.utils.Values;
import lk.studentsmanage.utils.RetrofitClient;
import retrofit2.Response;
import retrofit2.Call;

public final class adminDashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


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
        Call<Long> studentCountCall = studentAPI.getStudentCount();

        Long results = null;
        Long sCount = null;

        try {
            results = studentCountCall.execute().body();

            

        } catch (Exception e) {
            System.out.println("Exception in Student controller : " + e);

        }

        return results;

    }

  



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
        Call<Long> teacherCountCall = teacherAPI.getTeacherCount();

        Long results = null;
        Long tCount = null;

        try {
            results = teacherCountCall.execute().body();

        } catch (Exception e) {
            System.out.println("Exception in Teacher controller : " + e);

        }

        return results;

    }

 




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



  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(3);
    _jspx_dependants.add("/controller/StudentController.jsp");
    _jspx_dependants.add("/controller/TeacherController.jsp");
    _jspx_dependants.add("/controller/AdminController.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");


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


      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>School Management</title>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("\n");
      out.write("        <!--        Bootstrap needs-->\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css\" integrity=\"sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm\" crossorigin=\"anonymous\">\n");
      out.write("\n");
      out.write("        <script src=\"https://code.jquery.com/jquery-3.2.1.slim.min.js\" integrity=\"sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js\" integrity=\"sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js\" integrity=\"sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <!--        Bootstrap needs-->\n");
      out.write("\n");
      out.write("\n");
      out.write("        <!-- Load an icon library to show a hamburger menu (bars) on small screens -->\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\">\n");
      out.write("\n");
      out.write("        <link href=\"assets/styles/topNavigation.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <style>\n");
      out.write("\n");
      out.write("            /* If the screen size is 601px wide or more, set the font-size of <div> to 80px */\n");
      out.write("            @media screen and (min-width:577.5px) {\n");
      out.write("                img.cardAvatar {\n");
      out.write("                    width: 100%;\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* If the screen size is 600px wide or less, set the font-size of <div> to 30px */\n");
      out.write("            @media screen and (max-width: 577px) {\n");
      out.write("                img.cardAvatar {\n");
      out.write("                    width: 10%;\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .dropdown-menu{\n");
      out.write("                right: 0;\n");
      out.write("                left: auto;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            /* Set black background color, white text and some padding */\n");
      out.write("            footer {\n");
      out.write("                background-color: #555;\n");
      out.write("                color: white;\n");
      out.write("                position:fixed;\n");
      out.write("                bottom:0;\n");
      out.write("                left:0;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #studentSearchInput, #teacherSearchInput, #operatorSearchInput {\n");
      out.write("                background-image: url('/css/searchicon.png'); /* Add a search icon to input */\n");
      out.write("                background-position: 10px 12px; /* Position the search icon */\n");
      out.write("                background-repeat: no-repeat; /* Do not repeat the icon image */\n");
      out.write("                width: 100%; /* Full-width */\n");
      out.write("                font-size: 16px; /* Increase font-size */\n");
      out.write("                padding: 12px 20px 12px 40px; /* Add some padding */\n");
      out.write("                border: 1px solid #ddd; /* Add a grey border */\n");
      out.write("                margin-bottom: 12px; /* Add some space below the input */\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #studentTable, #teacherTable, #operatorTable {\n");
      out.write("                border-collapse: collapse; /* Collapse borders */\n");
      out.write("                width: 100%; /* Full-width */\n");
      out.write("                border: 1px solid #ddd; /* Add a grey border */\n");
      out.write("                font-size: 18px; /* Increase font-size */\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #studentTable th, #studentTable td, #teacherTable th, #teacherTable td, #operatorTable th, #operatorTable td {\n");
      out.write("                text-align: left; /* Left-align text */\n");
      out.write("                padding: 12px; /* Add padding */\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #studentTable tr, #teacherTable tr, #operatorTable tr {\n");
      out.write("                /* Add a bottom border to all table rows */\n");
      out.write("                border-bottom: 1px solid #ddd;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            #studentTable tr.header,#teacherTable tr.header, #operatorTable tr.header, #operatorTable tr:hover, #teacherTable tr:hover, #studentTable tr:hover {\n");
      out.write("                /* Add a grey background color to the table header and on hover */\n");
      out.write("                background-color: #f1f1f1;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    ");
        UserModel userData = (UserModel) session.getAttribute("userData");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MMM-dd");
        String status = "" + request.getParameter("status");

        if (userData == null) {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        }

        List<UserModel> studentUsers = getAllStudentUsers();
        int studentUsersCount = studentUsers.size();

        List<UserModel> teacherUsers = getAllTeacherUsers();
        int teacherUsersCount = teacherUsers.size();

        List<OperatorModel> operators = getAllOperators();
        int operatorsCount = operators.size();

    
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            $(document).ready(function () {\n");
      out.write("            ");
if (status.equals("savedOp")) {
      out.write("\n");
      out.write("                jQuery(function () {\n");
      out.write("                    jQuery('#operator-settings').click();\n");
      out.write("                });\n");
      out.write("                window.history.replaceState(null, null, window.location.pathname);\n");
      out.write("            ");
} else {
      out.write("\n");
      out.write("                $(\"#student-settings\").css(\"background-color\", \"lightgrey\");\n");
      out.write("            ");
}
      out.write("\n");
      out.write("\n");
      out.write("                $('#student-settings').click(function () {\n");
      out.write("\n");
      out.write("                    $(\"#student-settings\").css(\"background-color\", \"lightgrey\");\n");
      out.write("                    $(\"#operator-settings\").css(\"background-color\", \"white\");\n");
      out.write("                    $(\"#teacher-settings\").css(\"background-color\", \"white\");\n");
      out.write("\n");
      out.write("                    $(\"#student-section\").css(\"display\", \"block\");\n");
      out.write("                    $(\"#teacher-section\").css(\"display\", \"none\");\n");
      out.write("                    $(\"#operator-section\").css(\"display\", \"none\");\n");
      out.write("                });\n");
      out.write("\n");
      out.write("                $('#teacher-settings').click(function () {\n");
      out.write("\n");
      out.write("                    $(\"#teacher-settings\").css(\"background-color\", \"lightgrey\");\n");
      out.write("                    $(\"#student-settings\").css(\"background-color\", \"white\");\n");
      out.write("                    $(\"#operator-settings\").css(\"background-color\", \"white\");\n");
      out.write("\n");
      out.write("                    $(\"#teacher-section\").css(\"display\", \"block\");\n");
      out.write("                    $(\"#operator-section\").css(\"display\", \"none\");\n");
      out.write("                    $(\"#student-section\").css(\"display\", \"none\");\n");
      out.write("                });\n");
      out.write("\n");
      out.write("                $('#operator-settings').click(function () {\n");
      out.write("\n");
      out.write("                    $(\"#teacher-settings\").css(\"background-color\", \"white\");\n");
      out.write("                    $(\"#student-settings\").css(\"background-color\", \"white\");\n");
      out.write("                    $(\"#operator-settings\").css(\"background-color\", \"lightgrey\");\n");
      out.write("\n");
      out.write("                    $(\"#teacher-section\").css(\"display\", \"none\");\n");
      out.write("                    $(\"#student-section\").css(\"display\", \"none\");\n");
      out.write("                    $(\"#operator-section\").css(\"display\", \"block\");\n");
      out.write("                });\n");
      out.write("            });\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <!--        Navigation bar-->\n");
      out.write("        <nav class=\"navbar navbar-expand-lg navbar-dark bg-dark\" >\n");
      out.write("            <!--            <a class=\"navbar-brand\" href=\"#\">PRESIDENT S COLLEGE</a>-->\n");
      out.write("            <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarSupportedContent\" aria-controls=\"navbarSupportedContent\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n");
      out.write("                <span class=\"navbar-toggler-icon\"></span>\n");
      out.write("            </button>\n");
      out.write("\n");
      out.write("            <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n");
      out.write("                <ul class=\"navbar-nav mr-auto\">\n");
      out.write("                    <li class=\"nav-item active\">\n");
      out.write("                        <a class=\"nav-link\" href=\"#\">Dashboard <span class=\"sr-only\">(current)</span></a>\n");
      out.write("                    </li>\n");
      out.write("\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class = \"dropdown\" style=\"color: white;\">\n");
      out.write("                <a style=\"color:white;\" class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n");
      out.write("                    <i class=\"fa fa-fw fa-user\" style=\"font-size: 23px; color: white;\"></i>\n");
      out.write("                </a>\n");
      out.write("                <div class=\"dropdown-menu dropdown-menu-right\">\n");
      out.write("                    <a class=\"dropdown-item\"  data-toggle=\"modal\" data-target=\"#userProfileView\">View profile</a>\n");
      out.write("                    <a class=\"dropdown-item\" href=\"#\">Settings</a>\n");
      out.write("                    <div class=\"dropdown-divider\"></div>\n");
      out.write("                    <a class=\"dropdown-item\" href=\"index.jsp?status=logout\"><strong>Log Out</strong></a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("        <!--        Navigation bar-->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <!-- User profile Modal -->\n");
      out.write("        <div class=\"modal fade\" id=\"userProfileView\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalCenterTitle\" aria-hidden=\"true\">\n");
      out.write("            <div class=\"modal-dialog modal-dialog-centered\" role=\"document\">\n");
      out.write("                <div class=\"modal-content\">\n");
      out.write("                    <div class=\"modal-header bg-dark\" >\n");
      out.write("                        <h5 class=\"modal-title\" id=\"exampleModalLongTitle\" style=\"color: white;\">User Profile</h5>\n");
      out.write("                        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\" style=\"color:white;\">\n");
      out.write("                            <span aria-hidden=\"true\">&times;</span>\n");
      out.write("                        </button>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"modal-body\">\n");
      out.write("                        <form>\n");
      out.write("                            <div class=\"form-group\">\n");
      out.write("                                <label for=\"adminUserName\">Name</label>\n");
      out.write("                                <input class=\"form-control\" id=\"adminUserName\" disabled value=\"");
      out.print(userData.getUserId());
      out.write("\">\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                            <div class=\"form-group\">\n");
      out.write("                                <label for=\"studentFirstName\">Role</label>\n");
      out.write("                                <input class=\"form-control\" id=\"studentFirstName\" disabled value=\"");
      out.print(userData.getUserRole());
      out.write("\">\n");
      out.write("                            </div>\n");
      out.write("                            \n");
      out.write("                            \n");
      out.write("\n");
      out.write("                        </form>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"modal-footer\">\n");
      out.write("                        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <!-- User profile Modal -->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <!--        Page content-->\n");
      out.write("        <div class=\"page-content\">\n");
      out.write("\n");
      out.write("            <div class=\"stats-cards\" style=\"padding-left: 1%; padding-right: 1%;\">\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <div class=\"col-xs-3 col-sm-3 col-md-3 col-lg-3\" style=\"padding:1%;\">\n");
      out.write("\n");
      out.write("                        <div class=\"card \"style=\" height: 100%; cursor: pointer;\" id=\"student-settings\">\n");
      out.write("                            <div class=\"card-body\">\n");
      out.write("                                <div class=\"row\">\n");
      out.write("                                    <div class=\"col-xs-4 col-md-4 col-sm-4 col-lg-4  \">\n");
      out.write("                                        <img class=\"cardAvatar\" src=\"assets/images/reading.png\" alt=\"Student Avatar\" style=\"height: auto; \"> \n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"col-xs-8 col-md-8 col-sm-8 col-lg-8\">\n");
      out.write("                                        <h4 style=\"font-size:1.1vw;\">Student Users</h4>\n");
      out.write("                                        <h3 style=\"font-size:3.5vw;\">");
      out.print(studentUsersCount);
      out.write("</h3>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-xs-3 col-sm-3 col-md-3 col-lg-3\" style=\"padding:1%;\" >\n");
      out.write("\n");
      out.write("                        <div class=\"card\" style=\" height: 100%; cursor: pointer;\" id=\"teacher-settings\" >\n");
      out.write("                            <div class=\"card-body\">\n");
      out.write("                                <div class=\"row\">\n");
      out.write("                                    <div class=\"col-xs-4 col-sm-4 col-lg-4\">\n");
      out.write("                                        <img class=\"cardAvatar\" src=\"assets/images/teacher.png\" alt=\"Teacher Avatar\" style=\"height: auto; \"> \n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"col-xs-8 col-sm-8 col-lg-8\">\n");
      out.write("                                        <h4 style=\"font-size:1.1vw;\">Teacher Users</h4>\n");
      out.write("                                        <h3 style=\"font-size:3.5vw;\">");
      out.print(teacherUsersCount);
      out.write("</h3>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-xs-3 col-sm-3 col-md-3 col-lg-3\" style=\"padding:1%;\">\n");
      out.write("\n");
      out.write("                        <div class=\"card\" style=\" height: 100%; cursor:pointer;\" id=\"operator-settings\" >\n");
      out.write("                            <div class=\"card-body\">\n");
      out.write("                                <div class=\"row\">\n");
      out.write("                                    <div class=\"col-xs-4 col-sm-4 col-lg-4\">\n");
      out.write("                                        <img class=\"cardAvatar\" src=\"assets/images/family.png\" alt=\"Family Avatar\" style=\"height: auto; \"> \n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"col-xs-8 col-sm-8 col-lg-8\">\n");
      out.write("                                        <h4 style=\"font-size:1.1vw;\">Operators</h4>\n");
      out.write("                                        <h3 style=\"font-size:3.5vw;\">");
      out.print(operatorsCount);
      out.write("</h3>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-xs-3 col-sm-3 col-md-3 col-lg-3\" style=\"padding:1%;\">\n");
      out.write("                        <a href=\"\" style=\"color: inherit;\">\n");
      out.write("                            <div class=\"card\" style=\" height: 100%;\">\n");
      out.write("                                <div class=\"card-body\">\n");
      out.write("\n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <div class=\"col-xs-4 col-sm-4 col-lg-4\">\n");
      out.write("                                            <img class=\"cardAvatar\" src=\"assets/images/notepad.png\" alt=\"Student Avatar\" style=\"height: auto; \"> \n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"col-xs-8 col-sm-8 col-lg-8\">\n");
      out.write("                                            <h4 style=\"font-size:1.1vw;\">Notice</h4>\n");
      out.write("                                            <h3 style=\"font-size:1vw;\">Important notices will be display here</h3>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("                        </a>\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"card-content\" style=\"padding-left: 1%; padding-right: 1%;\">\n");
      out.write("                <div  id=\"student-section\" style=\"display: block\">\n");
      out.write("                    <h3>Students section</h3>\n");
      out.write("                    <div class=\"row\">\n");
      out.write("                        <div class=\"col-md-8\">\n");
      out.write("                            <input style=\"background-image: url('assets/images/searchIcon.png');\" type=\"text\" id=\"studentSearchInput\" onkeyup=\"searchFunction({inputId: 'studentSearchInput', table: 'studentTable'})\" placeholder=\"Search for users..\">\n");
      out.write("                            <div style=\"height: 77%; overflow-y: auto\">\n");
      out.write("                                <table id=\"studentTable\">\n");
      out.write("                                    <tr class=\"header\">\n");
      out.write("                                        <th style=\"width:60%;\">USER ID</th>\n");
      out.write("                                        <th style=\"width:40%;\">ROLE</th>\n");
      out.write("                                    </tr>\n");
      out.write("\n");
      out.write("                                    ");

                                        for (UserModel us : studentUsers) {

                                    
      out.write("\n");
      out.write("                                    <tr style=\"cursor: pointer;\" onclick=\"someFunc({id: '");
      out.print(us.getUserId());
      out.write("', role: '");
      out.print(us.getUserRole());
      out.write("', sectionId: 'student_data_section'})\">\n");
      out.write("                                        <td>");
      out.print(us.getUserId());
      out.write("</td>\n");
      out.write("                                        <td>");
      out.print(us.getUserRole());
      out.write("</td>\n");
      out.write("                                    </tr>                              \n");
      out.write("                                    ");
}
      out.write("                       \n");
      out.write("                                </table> \n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"col-md-4\" id=\"student_data_section\">\n");
      out.write("                            <div class=\"card\">\n");
      out.write("                                <div class=\"card-body\">\n");
      out.write("                                    <h5 class=\"card-title\">User Details</h5>\n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                        <label class=\"col-md-4\">User ID</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <label class=\"col-md-4\">Role</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                    </div>                                 \n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div  id=\"teacher-section\" style=\"display: none\">\n");
      out.write("                    <h3>Teachers section</h3>\n");
      out.write("                    <div class=\"row\">\n");
      out.write("                        <div class=\"col-md-8\">\n");
      out.write("                            <input style=\"background-image: url('assets/images/searchIcon.png');\" type=\"text\" id=\"teacherSearchInput\" onkeyup=\"searchFunction({inputId: 'teacherSearchInput', table: 'teacherTable'})\" placeholder=\"Search for users..\">\n");
      out.write("                            <div style=\"height: 77%; overflow-y: auto\">\n");
      out.write("                                <table id=\"teacherTable\">\n");
      out.write("                                    <tr class=\"header\">\n");
      out.write("                                        <th style=\"width:60%;\">USER ID</th>\n");
      out.write("                                        <th style=\"width:40%;\">ROLE</th>\n");
      out.write("                                    </tr>\n");
      out.write("                                    ");

                                        for (UserModel us : teacherUsers) {

                                    
      out.write("\n");
      out.write("                                    <tr style=\"cursor: pointer;\" onclick=\"someFunc({id: '");
      out.print(us.getUserId());
      out.write("', role: '");
      out.print(us.getUserRole());
      out.write("', sectionId: 'teacher_data_section'})\">\n");
      out.write("                                        <td>");
      out.print(us.getUserId());
      out.write("</td>\n");
      out.write("                                        <td>");
      out.print(us.getUserRole());
      out.write("</td>\n");
      out.write("                                    </tr>                              \n");
      out.write("                                    ");
}
      out.write("                       \n");
      out.write("                                </table> \n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"col-md-4\" id=\"teacher_data_section\">\n");
      out.write("                            <div class=\"card\">\n");
      out.write("                                <div class=\"card-body\">\n");
      out.write("                                    <h5 class=\"card-title\">User Details</h5>\n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                        <label class=\"col-md-4\">User ID</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <label class=\"col-md-4\">Role</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                    </div>                                 \n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div  id=\"operator-section\" style=\"display: none\">\n");
      out.write("                    <h3>Operators section</h3>\n");
      out.write("                    <div class=\"row\">\n");
      out.write("                        <div class=\"col-md-8\">\n");
      out.write("                            <input style=\"background-image: url('assets/images/searchIcon.png');\" type=\"text\" id=\"operatorSearchInput\" onkeyup=\"searchFunction({inputId: 'operatorSearchInput', table: 'operatorTable'})\" placeholder=\"Search for users..\">\n");
      out.write("                            <div style=\"height: 77%; overflow-y: auto\">\n");
      out.write("                                <table id=\"operatorTable\">\n");
      out.write("                                    <tr class=\"header\">\n");
      out.write("                                        <th style=\"width:30%;\">NIC</th>\n");
      out.write("                                        <th style=\"width:40%;\">NAME</th>\n");
      out.write("                                        <th style=\"width:30%;\">STATUS</th>\n");
      out.write("                                    </tr>\n");
      out.write("                                    ");

                                        for (OperatorModel us : operators) {

                                    
      out.write("\n");
      out.write("                                    <tr style=\"cursor: pointer;\" onclick=\"operatorFunc({nic: '");
      out.print(us.getNic());
      out.write("', name: '");
      out.print(us.getFirstName() + " " + us.getLastName());
      out.write("', address: '");
      out.print(us.getAddress());
      out.write("', birthday: '");
      out.print(us.getBday());
      out.write("', enrolledDate: '");
      out.print(us.getEnrolledDate());
      out.write("', status: '");
      out.print(us.getStatus());
      out.write("'})\">\n");
      out.write("                                        <td>");
      out.print(us.getNic());
      out.write("</td>\n");
      out.write("                                        <td>");
      out.print(us.getFirstName() + " " + us.getLastName());
      out.write("</td>\n");
      out.write("                                        <td style=\"");
 if(us.getStatus().equals("active")){
      out.write(" color:green; ");
}else if(us.getStatus().equals("blocked")){
      out.write(" color:red; ");
}else{
      out.write("color:lightblue;");
}
      out.write('"');
      out.write('>');
      out.print(us.getStatus());
      out.write("</td>\n");
      out.write("                                    </tr>                              \n");
      out.write("                                    ");
}
      out.write("                       \n");
      out.write("                                </table> \n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"col-md-4\" >\n");
      out.write("                            <div id=\"operator_data_section\">\n");
      out.write("                                <div class=\"card\">\n");
      out.write("                                    <div class=\"card-body\">\n");
      out.write("                                        <h5 class=\"card-title\">User Details</h5>\n");
      out.write("                                        <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                            <label class=\"col-md-4\">Nic</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                            <label class=\"col-md-4\">Name</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                        </div> \n");
      out.write("\n");
      out.write("                                        <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                            <label class=\"col-md-4\">Birthday</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                            <label class=\"col-md-4\">Address</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                        </div> \n");
      out.write("\n");
      out.write("                                        <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                            <label class=\"col-md-4\">Enrolled Date</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                        </div> \n");
      out.write("\n");
      out.write("                                        <div class=\"row\">\n");
      out.write("                                            <label class=\"col-md-4\">Status</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"Not define\"></input>\n");
      out.write("                                        </div>                                 \n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            <button type=\"button\" class=\"btn btn-primary\" style=\"width: 100%; margin-top: 3%;\" data-toggle=\"modal\" data-target=\"#addOperatorModal\">Add Operator</button>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <!-- add operator Modal -->\n");
      out.write("                    <div class=\"modal fade\" id=\"addOperatorModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalCenterTitle\" aria-hidden=\"true\">\n");
      out.write("                        <div class=\"modal-dialog modal-dialog-centered\" role=\"document\">\n");
      out.write("                            <div class=\"modal-content\">\n");
      out.write("                                <div class=\"modal-header bg-dark\" >\n");
      out.write("                                    <h5 class=\"modal-title\" id=\"exampleModalLongTitle\" style=\"color: white;\">Add Operator</h5>\n");
      out.write("                                    <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\" style=\"color:white;\">\n");
      out.write("                                        <span aria-hidden=\"true\">&times;</span>\n");
      out.write("                                    </button>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"modal-body\">\n");
      out.write("                                    <!--                        operator add modal -->\n");
      out.write("                                    <form action=\"controller/AdminController.jsp\"> \n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <label for=\"operatorNic\">NIC</label>\n");
      out.write("                                            <input class=\"form-control\" id=\"operatorNic\" name=\"nic\" pattern=\"\\d{11}|\\d{9}\\w{1}\"  maxlength=10 minlength=9 required>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <label for=\"operatorFirstName\">First Name</label>\n");
      out.write("                                            <input class=\"form-control\" id=\"operatorFirstName\" name=\"firstName\" required>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <label for=\"operatorLastName\">Last Name</label>\n");
      out.write("                                            <input class=\"form-control\" id=\"operatorLastName\" name=\"lastName\" required>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <label for=\"operatorLastName\">Birthday</label>\n");
      out.write("                                            <input class=\"form-control\"  type=\"date\" name=\"birthday\" required>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <label for=\"operatorAddress\">Address</label>\n");
      out.write("                                            <input class=\"form-control\" id=\"operatorAddress\" name=\"address\" required>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <label for=\"operatorLastName\">Enrolled Date</label>\n");
      out.write("                                            <input class=\"form-control\" type=\"date\" name=\"enrolledDate\" required>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"form-group\" >\n");
      out.write("                                            <label style=\"width: 100%;\">Status</label>\n");
      out.write("                                            <div class=\"row\" style=\"text-align: center; width: 100%;\">\n");
      out.write("                                                <input class=\"col-sm-2\" type=\"radio\" name=\"status\" value=\"active\" checked> Active\n");
      out.write("                                                <input class=\"col-sm-2\" type=\"radio\" name=\"status\" value=\"blocked\" > Blocked\n");
      out.write("                                                <input class=\"col-sm-2\" type=\"radio\" name=\"status\" value=\"retired\" > Retired\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <input type=\"hidden\" name=\"action\" value=\"addOperator\">\n");
      out.write("\n");
      out.write("                                        <div style=\"margin-top:4%; \" class=\"form-group\">\n");
      out.write("                                            <div class=\"row mr-1\" style=\"float: right;\">\n");
      out.write("                                                <button type=\"submit\" class=\"btn btn-secondary mr-2\">Save</button>\n");
      out.write("                                                <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                    </form>\n");
      out.write("                                    <!--                        Student user details -->\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <!-- add operator Modal -->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("        <!--        Navigation bar-->\n");
      out.write("\n");
      out.write("\n");
      out.write("        <footer class=\"container-fluid text-center\">\n");
      out.write("            <p>Footer Text</p>\n");
      out.write("        </footer>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("\n");
      out.write("            /* Toggle between adding and removing the \"responsive\" class to topnav when the user clicks on the icon */\n");
      out.write("            function myFunction() {\n");
      out.write("                console.log(\"method started.\");\n");
      out.write("                var x = document.getElementById(\"myTopnav\");\n");
      out.write("                if (x.className === \"topnav\") {\n");
      out.write("                    x.className += \" responsive\";\n");
      out.write("                } else {\n");
      out.write("                    x.className = \"topnav\";\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function someFunc(arg) {\n");
      out.write("\n");
      out.write("\n");
      out.write("                const div = document.createElement('div-user');\n");
      out.write("\n");
      out.write("                div.innerHTML = `\n");
      out.write("                        <div class=\"card\">\n");
      out.write("                        <div class=\"card-body\">\n");
      out.write("                        <h5 class=\"card-title\">User Details</h5>\n");
      out.write("                            <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                <label class=\"col-md-4\">User ID</label>\n");
      out.write("                                <input class=\"col-md-8\" disabled value=\"` + arg.id + `\"></input>\n");
      out.write("                            </div>\n");
      out.write("                            \n");
      out.write("                                <div class=\"row\">\n");
      out.write("                                <label class=\"col-md-4\">Role</label>\n");
      out.write("                                <input class=\"col-md-8\" disabled value=\"` + arg.role + `\"></input>\n");
      out.write("                        </div>                                 \n");
      out.write("                        </div>\n");
      out.write("                        </div>\n");
      out.write("                                                    `;\n");
      out.write("\n");
      out.write("                const parentT = document.getElementById(arg.sectionId);\n");
      out.write("                parentT.innerHTML = \"\";\n");
      out.write("                parentT.appendChild(div);\n");
      out.write("\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function operatorFunc(arg) {\n");
      out.write("\n");
      out.write("                const div = document.createElement('div-user');\n");
      out.write("\n");
      out.write("                var checkedActive = \"\";\n");
      out.write("                var checkedBlocked = \"\";\n");
      out.write("                var checkedRetired = \"\";\n");
      out.write("\n");
      out.write("                //check the radio button according to the user current status\n");
      out.write("                if (arg.status === \"active\") {\n");
      out.write("                    checkedActive = \"checked\";\n");
      out.write("                } else if (arg.status === \"blocked\") {\n");
      out.write("                    checkedBlocked = \"checked\";\n");
      out.write("                } else if (arg.status === \"retired\") {\n");
      out.write("                    checkedRetired = \"checked\";\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                div.innerHTML = `\n");
      out.write("                        <div class=\"card\">\n");
      out.write("                            <div class=\"card-body\">\n");
      out.write("                                <h5 class=\"card-title\">User Details</h5>\n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                        <label class=\"col-md-4\">Nic</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"` + arg.nic + `\"></input>\n");
      out.write("                                    </div>\n");
      out.write("                                    \n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                            <label class=\"col-md-4\">Name</label>\n");
      out.write("                                            <input class=\"col-md-8\" disabled value=\"` + arg.name + `\"></input>\n");
      out.write("                                    </div> \n");
      out.write("                    \n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                        <label class=\"col-md-4\">Birthday</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"` + arg.birthday + `\"></input>\n");
      out.write("                                    </div> \n");
      out.write("                        \n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                        <label class=\"col-md-4\">Address</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"` + arg.address + `\"></input>\n");
      out.write("                                    </div> \n");
      out.write("                                    \n");
      out.write("                                    <div class=\"row\" style=\"margin-bottom: 10px;\">\n");
      out.write("                                        <label class=\"col-md-4\">Enrolled Date</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"` + arg.enrolledDate + `\"></input>\n");
      out.write("                                    </div> \n");
      out.write("                                \n");
      out.write("                                    <div class=\"row\">\n");
      out.write("                                        <label class=\"col-md-4\">Status</label>\n");
      out.write("                                        <input class=\"col-md-8\" disabled value=\"` + arg.status + `\"></input>\n");
      out.write("                                    </div>   \n");
      out.write("                        \n");
      out.write("                                    <div class=\"row \" style=\"width=100%; display:flex;\">\n");
      out.write("                                        <button class=\"btn btn-danger\" style=\"margin-left: auto; margin-top:3%;\" data-toggle=\"modal\" data-target=\"#operatorAccessControl\">Access Control</button>\n");
      out.write("                                    </div>\n");
      out.write("                            </div>                                \n");
      out.write("                        </div>\n");
      out.write("                                    \n");
      out.write("                                    <div class=\"modal fade\" id=\"operatorAccessControl\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalCenterTitle\" aria-hidden=\"true\">\n");
      out.write("                                    <div class=\"modal-dialog modal-dialog-centered\" role=\"document\">\n");
      out.write("                        <div class=\"modal-content\">\n");
      out.write("                            <div class=\"modal-header bg-dark\" >\n");
      out.write("                                <h5 class=\"modal-title\" id=\"exampleModalLongTitle\" style=\"color: white;\">Operator Access Control</h5>\n");
      out.write("                                        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\" style=\"color:white;\">\n");
      out.write("                                        <span aria-hidden=\"true\">&times;</span>\n");
      out.write("                                    </button>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"modal-body\">\n");
      out.write("                                 \n");
      out.write("                                    <form action=\"controller/AdminController.jsp\"> \n");
      out.write("        \n");
      out.write("                                        <div class=\"form-group\">\n");
      out.write("                                            <div class=\"row\" style=\"margin: 0 auto;\">\n");
      out.write("                                                <div class=\"col-sm-1\"></div>\n");
      out.write("                                                <div class=\"col-sm-3\">\n");
      out.write("                                                    <input type=\"radio\" name=\"status\" value=\"active\" ` + checkedActive + `> Active\n");
      out.write("                                                </div>\n");
      out.write("                                                <div class=\"col-sm-1\"></div>\n");
      out.write("                                                <div class=\"col-sm-3\">\n");
      out.write("                                                    <input type=\"radio\" name=\"status\" value=\"blocked\" ` + checkedBlocked + `> Blocked\n");
      out.write("                                                </div>\n");
      out.write("                                                <div class=\"col-sm-1\"></div>\n");
      out.write("                                                <div class=\"col-sm-3\">\n");
      out.write("                                                    <input type=\"radio\" name=\"status\" value=\"retired\" ` + checkedRetired + `> Retired\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("        \n");
      out.write("                                        \n");
      out.write("                                        <input type=\"hidden\" name=\"nic\" value=\"` + arg.nic + `\">\n");
      out.write("                                        <input type=\"hidden\" name=\"action\" value=\"accessOperator\">\n");
      out.write("\n");
      out.write("                                        <div style=\"margin-top:4%; \" class=\"form-group\">\n");
      out.write("                                            <div class=\"row mr-1\" style=\"float: right;\">\n");
      out.write("                                                <button type=\"submit\" class=\"btn btn-secondary mr-2\">Update</button>\n");
      out.write("                                                <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("                                    </form>\n");
      out.write("                                 \n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    \n");
      out.write("                      `;\n");
      out.write("\n");
      out.write("                const parentT = document.getElementById('operator_data_section');\n");
      out.write("                parentT.innerHTML = \"\";\n");
      out.write("                parentT.appendChild(div);\n");
      out.write("\n");
      out.write("\n");
      out.write("            }\n");
      out.write("\n");
      out.write("\n");
      out.write("            function searchFunction(args) {\n");
      out.write("                var input, filter, table, tr, td, i, txtValue;\n");
      out.write("                input = document.getElementById(args.inputId);\n");
      out.write("                filter = input.value.toUpperCase();\n");
      out.write("                table = document.getElementById(args.table);\n");
      out.write("                tr = table.getElementsByTagName(\"tr\");\n");
      out.write("                for (i = 0; i < tr.length; i++) {\n");
      out.write("                    td = tr[i].getElementsByTagName(\"td\")[0];\n");
      out.write("                    tdTwo = tr[i].getElementsByTagName(\"td\")[1];\n");
      out.write("                    if (td || tdTwo) {\n");
      out.write("                        txtValue = td.textContent || td.innerText;\n");
      out.write("\n");
      out.write("                        textValueTwo = tdTwo.textContent || tdTwo.innerText;\n");
      out.write("\n");
      out.write("                        if (txtValue.toUpperCase().indexOf(filter) > -1 || textValueTwo.toUpperCase().indexOf(filter) > -1) {\n");
      out.write("                            tr[i].style.display = \"\";\n");
      out.write("                        } else {\n");
      out.write("                            tr[i].style.display = \"none\";\n");
      out.write("                        }\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
