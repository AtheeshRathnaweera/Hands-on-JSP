<%@page import="lk.studentsmanage.models.UserModel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lk.studentsmanage.models.StudentModel"%>
<%@include file="controller/StudentController.jsp" %>
<%@include file="controller/TeacherController.jsp" %>
<%@include file="controller/AdminController.jsp" %>
<%@include file="controller/ClassController.jsp" %>

<html>
    <head>
        <title>School Management</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!--        Bootstrap needs-->


        <!-- Load an icon library to show a hamburger menu (bars) on small screens -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link href="assets/styles/topNavigation.css" rel="stylesheet" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>




        <style>

            /* If the screen size is 601px wide or more, set the font-size of <div> to 80px */
            @media screen and (min-width:577.5px) {
                img.cardAvatar {
                    width: 100%;
                }
            }

            /* If the screen size is 600px wide or less, set the font-size of <div> to 30px */
            @media screen and (max-width: 577px) {
                img.cardAvatar {
                    width: 10%;
                }
            }

            .dropdown-menu{
                right: 0;
                left: auto;
            }

            /* Set black background color, white text and some padding */
            footer {
                background-color: #555;
                color: white;
                margin-top:1%;
                /*                position:fixed;
                                bottom:0;
                                left:0;*/
            }

            .gradeCard:hover{
                background-color: lightgrey;
                opacity: 2;
                -webkit-opacity: 2;
                -moz-opacity: 2;
                transition: 0.6s ease;
                -webkit-transition: 0.6s ease;
                -moz-transition: 0.6s ease;

            }

            #studentSearchInput, #teacherSearchInput, #operatorSearchInput {
                background-image: url('/css/searchicon.png'); /* Add a search icon to input */
                background-position: 10px 12px; /* Position the search icon */
                background-repeat: no-repeat; /* Do not repeat the icon image */
                width: 100%; /* Full-width */
                font-size: 16px; /* Increase font-size */
                padding: 12px 20px 12px 40px; /* Add some padding */
                border: 1px solid #ddd; /* Add a grey border */
                margin-bottom: 12px; /* Add some space below the input */
            }

            #studentTable, #teacherTable, #operatorTable {
                border-collapse: collapse; /* Collapse borders */
                width: 100%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 18px; /* Increase font-size */
            }

            #studentTable th, #studentTable td, #teacherTable th, #teacherTable td, #operatorTable th, #operatorTable td {
                text-align: left; /* Left-align text */
                padding: 12px; /* Add padding */
            }

            #studentTable tr, #teacherTable tr, #operatorTable tr {
                /* Add a bottom border to all table rows */
                border-bottom: 1px solid #ddd;
            }

            #studentTable tr.header,#teacherTable tr.header, #operatorTable tr.header, #operatorTable tr:hover, #teacherTable tr:hover, #studentTable tr:hover {
                /* Add a grey background color to the table header and on hover */
                background-color: #f1f1f1;
            }




        </style>





    </head>

    <%        UserModel userData = (UserModel) session.getAttribute("userData");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MMM-dd");
        String status = "" + request.getParameter("status");

        if (userData == null) {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        }

        Long classAmount = getAllClassCount() - 1; //-1 for remove the default null class
        Long studentsAmount = getAllStudentsCountOfTheSchool();
        Long teachersAmount = getTeachersCountOfTheSchool();

    %>





    <body style="background-color: whitesmoke;">

        <script>

            $(document).ready(function () {
                jQuery(function () {
                    jQuery('#class-settings').click();
                });

                $("#pw_reset_section").css("display", "none"); //hide the password reset section
                $("#updateAdminProfileButton").css("visibility", "hidden");
                document.getElementById("adminProfileUpdateForm").reset();

                $('#student-settings').click(function () {

                    $("#student-settings").css("background-color", "lightgrey");
                    $("#class-settings").css("background-color", "white");
                    $("#teacher-settings").css("background-color", "white");

                    $("#student-section").css("display", "block");
                    $("#teacher-section").css("display", "none");
                    $("#class-section").css("display", "none");
                });

                $('#teacher-settings').click(function () {

                    $("#teacher-settings").css("background-color", "lightgrey");
                    $("#student-settings").css("background-color", "white");
                    $("#class-settings").css("background-color", "white");

                    $("#teacher-section").css("display", "block");
                    $("#class-section").css("display", "none");
                    $("#student-section").css("display", "none");
                });

                $('#class-settings').click(function () {

                    $("#teacher-settings").css("background-color", "white");
                    $("#student-settings").css("background-color", "white");
                    $("#class-settings").css("background-color", "lightgrey");

                    $("#teacher-section").css("display", "none");
                    $("#student-section").css("display", "none");
                    $("#class-section").css("display", "block");
                });


                $('#adminCurrentPassword').on('keyup', function () { //validate the passwords when password resetting
                    if ($('#adminCurrentPassword').val() === "<%=userData.getPassword()%>") {
                        $("#pw_reset_section").css("display", "block");

                        $('#adminNewRepeatPassword').on('keyup', function () {
                            if ($('#adminNewPassword').val() !== "" && $('#adminNewRepeatPassword').val() !== "" && ($('#adminNewPassword').val() === $('#adminNewRepeatPassword').val())) {
                                $("#updateAdminProfileButton").css("visibility", "visible");
                            } else {
                                $("#updateAdminProfileButton").css("visibility", "hidden");
                            }
                        });

                    } else {
                        $("#pw_reset_section").css("display", "none");
                    }


                });

                $("#studentSearchBtn").click();//display results for the search input text when the section loads
                $("#teacherSearchBtn").click();
            });

        </script>



        <!--        Navigation bar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark" >
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Operator Dashboard<span class="sr-only">(current)</span></a>
                    </li>

                </ul>
            </div>

            <div class = "dropdown" style="color: white;">
                <a style="color:white;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-fw fa-user" style="font-size: 23px; color: white;"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item"  data-toggle="modal" data-target="#userProfileView">View profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="index.jsp?status=logout"><strong>Log Out</strong></a>
                </div>
            </div>
        </nav>
        <!-- Navigation bar-->

        <!-- User profile Modal -->
        <div class="modal fade" id="userProfileView" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-dark" >
                        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">User Profile</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="adminProfileUpdateForm" action="controller/AdminController.jsp">
                            <div class="form-group">
                                <label >Name</label>
                                <input class="form-control" disabled value="<%=userData.getUserId()%>">
                            </div>

                            <div class="form-group">
                                <label >Role</label>
                                <input class="form-control" disabled value="<%=userData.getUserRole()%>">
                            </div>

                            <label>Password reset</label>

                            <div class="form-group">
                                <input class="form-control" id="adminCurrentPassword" type="password" required placeholder="current password">
                            </div>

                            <div id="pw_reset_section">
                                <div class="form-group">
                                    <input class="form-control" id="adminNewPassword" type="password" required placeholder="new password">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" id="adminNewRepeatPassword" type="password" name="newPassword" required placeholder="repeat password">
                                </div>
                            </div>

                            <input type="hidden" name="action" value="updateAdmin">
                            <input type="hidden" name="updateName" value="<%=userData.getUserId()%>">
                            <input type="hidden" name="updateRole" value="<%=userData.getUserRole()%>">

                            <div style="margin-top:4%;" class="form-group">
                                <div class="row mr-1" style="float: right;">
                                    <button id="updateAdminProfileButton" type="submit" class="btn btn-warning mr-2" style="color: white;">Update Profile</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </form>
                    </div>

                </div>
            </div>
        </div>
        <!-- User profile Modal -->

        <!--        Page content-->
        <div class="page-content">

            <div class="stats-cards" style="padding-left: 1%; padding-right: 1%;">
                <div class="row">

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">

                        <div class="card" style=" height: 100%; cursor:pointer;" id="class-settings" >
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-xs-4 col-sm-4 col-lg-4">
                                        <img class="cardAvatar" src="assets/images/classOne.png" alt="Class Avatar" style="height: auto;"> 
                                    </div>

                                    <div class="col-xs-8 col-sm-8 col-lg-8">
                                        <div style="font-size:1.1vw;">Classes</div>
                                        <div style="font-size:3.3vw;"><%=classAmount%></div>
                                    </div>
                                </div>

                            </div>

                        </div>


                    </div>

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">

                        <div class="card "style=" height: 100%; cursor: pointer;" id="student-settings">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-xs-4 col-md-4 col-sm-4 col-lg-4  ">
                                        <img class="cardAvatar" src="assets/images/reading.png" alt="Student Avatar" style="height: auto; "> 
                                    </div>

                                    <div class="col-xs-8 col-md-8 col-sm-8 col-lg-8">
                                        <div style="font-size:1.1vw;">Students</div>
                                        <div style="font-size:3.3vw;"><%=studentsAmount%></div>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;" >

                        <div class="card" style=" height: 100%; cursor: pointer;" id="teacher-settings" >
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-xs-4 col-sm-4 col-lg-4">
                                        <img class="cardAvatar" src="assets/images/teacher.png" alt="Teacher Avatar" style="height: auto; "> 
                                    </div>

                                    <div class="col-xs-8 col-sm-8 col-lg-8">
                                        <div style="font-size:1.1vw;">Teachers</div>
                                        <div style="font-size:3.3vw;"><%=teachersAmount%></div>
                                    </div>
                                </div>

                            </div>

                        </div>


                    </div>


                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">
                        <a style="color: inherit;">
                            <div class="card" style=" height: 100%;">
                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-xs-4 col-sm-4 col-lg-4">
                                            <img class="cardAvatar" src="assets/images/notepad.png" alt="Student Avatar" style="height: auto; "> 
                                        </div>

                                        <div class="col-xs-8 col-sm-8 col-lg-8">
                                            <div style="font-size:1.1vw;">Notice</div>
                                            <div style="font-size:1vw;">Important notices will be display here</div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </a>

                    </div>



                </div>

            </div>




            <div class="card-content" style="padding-left: 1%; padding-right: 1%;">
                <div  id="class-section" style="display: none" >

                    <div style=" font-size: 1.8vw; margin-bottom: 1%;">Classes Section</div>

                    <div class="col-sm-12">

                        <div class="list-group">
                            <% for (int i = 0; i < 13; i++) {%>

                            <a class="card gradeCard col-md-12 " style="margin: 0.2vw; cursor: pointer; color: inherit; text-decoration:none;" href="./classPage.jsp?grade=<%=(i + 1)%>">
                                <div class="row">
                                    <div class="col-md-1" style="background-color: #1874CD; display: flex; justify-content: center; align-items: center;">
                                        <div style='font-size: 1.8vw; color: white;'> <%=String.format("%02d", (i + 1))%></div>
                                    </div>
                                    <div class="col-md-11" style="padding: 0.5%;">
                                        <div class="row" style="padding-left: 1%; ">
                                            <div class="gradeName col-md-2" >
                                                <div style="font-size: 1.3vw;">Grade <%=(i + 1)%></div>
                                            </div>

                                        </div>
                                        <div class="teacherName" style="padding-left: 1%;">
                                            <div style="font-size: 0.9vw; font-style: italic;">Total classes : <%=getClassAmountOfAGrade(i + 1)%></div>
                                        </div>
                                    </div>
                                </div>

                            </a>

                            <%}%>


                        </div> 

                    </div>

                    <footer class="container-fluid text-center">
                        <div style="font-size: 1.3vw;">Footer Text</div>
                    </footer>


                </div>

                <div  id="student-section" style="display: block">
                    <h3>Students section</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="col-md-12 row" style=" padding: 1% 2% 1% 2%;">
                                <div class="row col-md-9">
                                    <input  type="text" id="studentSearchInputValue" type="text" class="form-control col-md-5 col-sm-8" placeholder="admission number...">
                                    <button style="margin-left: 1%; cursor: pointer;" id="studentSearchBtn" class=" btn btn-info">Search</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-danger" style="float: right;" id="addNewStudentButton">
                                        Add new student
                                    </button>
                                </div>
                            </div>

                            <div class="card" style="display: none; margin: 0% 1% 1% 1%;" id="studentInfoDisplayCard">                   
                                <div style="background-color: lightseagreen; padding: 1%; color: white;"><h5>Student Details</h5></div>
                                <form style="padding: 2%;" id="studentDetailsForm">

                                    <div class="form-group" id="sdAdmissionNumberSection">
                                        <label for="sdAdmissionNumber">Admission Number</label>
                                        <input type="text" class="form-control" id="sdAdmissionNumber" required>
                                    </div>

                                    <div class="form-group" id="displayInfoAdClassSection" style="display: none;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="sdDisplayAdmissionNumber">Admission Number</label>
                                                <input class="form-control" id="sdDisplayAdmissionNumber" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="sdDisplayCurrentClass">Current Class</label>
                                                <input class="form-control" id="sdDisplayCurrentClassName" disabled>
                                                <input class="form-control" id="sdDisplayCurrentClassId" hidden>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="sdNameText">First Name</label>
                                                <input type="text" class="form-control" id="sdFirstName" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="sdLastName">Last Name</label>
                                                <input type="text" class="form-control" id="sdLastName" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="sdAddress">Address</label>
                                        <input type="text" class="form-control" id="sdAddress" required>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="sdBday">Birthday</label>
                                                <input type="date" class="form-control" id="sdBday" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="sdEnrolledDate">Enrolled Date</label>
                                                <input type="date" class="form-control" id="sdEnrolledDate" required>
                                            </div>
                                        </div>
                                    </div>

                                    <fieldset class="form-group">
                                        <div class="row">
                                            <legend class="col-form-label col-sm-1 pt-0">Status</legend>
                                            <div class="col-sm-11">
                                                <div class="form-check-inline">
                                                    <input class="form-check-input" type="radio" name="statusRadios" id="statusactiveradio" value="active" checked>
                                                    <label class="form-check-label" for="statusActiveRadio">
                                                        Active
                                                    </label>
                                                </div>
                                                <div class="form-check-inline">
                                                    <input class="form-check-input" type="radio" name="statusRadios" id="statusunenrolledradio" value="unenrolled">
                                                    <label class="form-check-label" for="statusUnenrolledRadio">
                                                        Unenrolled
                                                    </label>
                                                </div>
                                                <div class="form-check-inline">
                                                    <input class="form-check-input" type="radio" name="statusRadios" id="statuspastradio" value="past">
                                                    <label class="form-check-label" for="statusPastRadio">
                                                        Past
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>


                                    <div class="form-group" id="sdCurrentClassSelectSection">
                                        <label for="sdAddress">Current Class Name</label>

                                        <select class="form-control selectpicker" id="classSelection" >
                                            <option value="1">Not assign</option>
                                            <%List<ClassModel> allClasses = getAllClasses();
                                                if (allClasses.size() > 0) {
                                                    for (ClassModel cl : allClasses) {
                                                        if (cl.getGrade() != 0) {
                                            %>
                                            <option value="<%=cl.getId()%>"><%=cl.getGrade() + " - " + cl.getName()%></option>
                                            <%}
                                                    }
                                                }%>
                                        </select>
                                    </div>

                                    <div class="col-md-12" style="margin-top: 2%;">
                                        <button  class="btn btn-primary" id="newStudentSaveBtn" style="float: right; width: 10%;">Save</button>
                                        <button  class="btn btn-primary" id="updateStudentSaveBtn" style="float: right; width: 10%;">Update</button>
                                    </div>
                                </form>

                            </div>

                            <div class="card" style=" margin: 0% 1% 1% 1%; display: none; height: 100%; padding: 5%;" id="studentNoResultsCard" >
                                <div style="text-align: center; color: lightslategrey;">No results found</div>
                            </div>

                        </div>
                    </div>
                </div>
                <div  id="teacher-section" style="display: none">
                    <h3>Teachers section</h3>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="col-md-12 row" style=" padding: 1% 2% 1% 2%;">
                                <div class="row col-md-9">
                                    <input  type="text" id="teacherSearchInputValue" type="text" class="form-control col-md-5 col-sm-8" placeholder="nic number...">
                                    <button style="margin-left: 1%; cursor: pointer;" id="teacherSearchBtn" class=" btn btn-info">Search</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-danger" style="float: right;" id="addNewTeacherButton">
                                        Add new teacher
                                    </button>
                                </div>
                            </div>

                            <div class="card" style=" margin: 0% 1% 1% 1%; display: none;" id="teacherInfoDisplayCard" >                   
                                <div style="background-color: lightseagreen; padding: 1%; color: white;"><h5>Teacher Details</h5></div>
                                <form style="padding: 2%;" id="teacherDetailsForm">

                                    <div class="form-group" id="tdNicNumberSection">
                                        <label for="tdNicNumber">NIC</label>
                                        <input type="text" class="form-control" id="tdNicNumber" required>
                                    </div>

                                    <div class="form-group" id="tdInfoAdClassSection" style="display: none;">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="tdDisplayNicNumber">NIC</label>
                                                <input class="form-control" id="tdDisplayNicNumber" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="tdDisplayCurrentClass">Current Class</label>
                                                <input class="form-control" id="tdDisplayCurrentClassName" disabled>
                                                <input class="form-control" id="tdDisplayCurrentClassId" hidden>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="tdNameText">First Name</label>
                                                <input type="text" class="form-control" id="tdFirstName" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="tdLastName">Last Name</label>
                                                <input type="text" class="form-control" id="tdLastName" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="tdAddress">Address</label>
                                        <input type="text" class="form-control" id="tdAddress" required>
                                    </div>


                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="tdTelephoneNumber">Contact Number</label>
                                                <input type="tel" class="form-control" id="tdTelephoneNumber" required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="tdGender">Gender</label>
                                                <div class="col-sm-11">
                                                    <div class="form-check-inline">
                                                        <input class="form-check-input" type="radio" name="tdGenderRadios" id="tdMradio" value="male" checked>
                                                        <label class="form-check-label" for="tdmaleradio">
                                                            Male
                                                        </label>
                                                    </div>
                                                    <div class="form-check-inline">
                                                        <input class="form-check-input" type="radio" name="tdGenderRadios" id="tdFradio" value="female">
                                                        <label class="form-check-label" for="tdfemaleradio">
                                                            Female
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <fieldset class="form-group">
                                        <div class="row">
                                            <legend class="col-form-label col-sm-1 pt-0">Status</legend>
                                            <div class="col-sm-11">
                                                <div class="form-check-inline">
                                                    <input class="form-check-input" type="radio" name="tdStatusRadios" id="tdstatusactiveradio" value="active" checked>
                                                    <label class="form-check-label">
                                                        Active
                                                    </label>
                                                </div>
                                                <div class="form-check-inline">
                                                    <input class="form-check-input" type="radio" name="tdStatusRadios" id="tdstatusunenrolledradio" value="unenrolled">
                                                    <label class="form-check-label">
                                                        Unenrolled
                                                    </label>
                                                </div>
                                                <div class="form-check-inline">
                                                    <input class="form-check-input" type="radio" name="tdStatusRadios" id="tdstatuspastradio" value="past">
                                                    <label class="form-check-label">
                                                        Past
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>


                                    <div class="form-group" id="tdCurrentClassSelectSection">
                                        <label>Current Class Name</label>

                                        <select class="form-control selectpicker" id="tdClassSelection" >
                                            <option value="1">Not assign</option>
                                            <%List<ClassModel> allClassess = getAllClasses();
                                                if (allClasses.size() > 0) {
                                                    for (ClassModel cl : allClassess) {
                                                        if (cl.getGrade() != 0) {
                                            %>
                                            <option value="<%=cl.getId()%>"><%=cl.getGrade() + " - " + cl.getName()%></option>
                                            <%}
                                                    }
                                                }%>
                                        </select>
                                    </div>

                                    <div class="col-md-12" style="margin-top: 2%;">
                                        <button type="submit" class="btn btn-primary" id="newTeacherSaveBtn" style="float: right; width: 10%;">Save</button>
                                        <button type="submit" class="btn btn-primary" id="updateTeacherBtn" style="float: right; width: 10%;">Update</button>
                                    </div>
                                </form>

                            </div>

                            <div class="card" style=" margin: 0% 1% 1% 1%; display: none; height: 100%; padding: 5%;" id="teacherNoResultsCard" >
                                <div style="text-align: center; color: lightslategrey;">No results found</div>
                            </div>

                        </div>
                    </div>
                </div>



            </div>



        </div>
        <!--        Navigation bar-->







        <script type="text/javascript">

            //teacher section

            $("#teacherSearchInputValue").on('keyup', function (e) {
                if (e.keyCode === 13) {//submit when enter key is pressed in nic input field
                    $("#teacherSearchBtn").click();
                }
            });

            $("#teacherSearchBtn").click(function () {
                var teacherNic = $("#teacherSearchInputValue").val().trim();
                if (teacherNic !== "") {
                    getTeacherDetails(teacherNic);
                } else {
                    console.log("search teacher nic number is null. ");
                    $("#teacherInfoDisplayCard").css("display", "none");
                    $("#teacherNoResultsCard").css("display", "block");
                }
            });

            $("#addNewTeacherButton").click(function () {
                $("#teacherNoResultsCard").css("display", "none");
                $("#teacherInfoDisplayCard").css("display", "block");
                $("#tdInfoAdClassSection").css("display", "none");
                $("#tdNicNumberSection").css("display", "block");
                $("#newTeacherSaveBtn").css("display", "block");
                $("#updateTeacherBtn").css("display", "none");
                $("#tdCurrentClassSelectSection").css("display", "block");

                $("#teacherDetailsForm").closest('form').find("input[type=text],input[type=date],input[type=tel]").val("");

            });

            $("#newTeacherSaveBtn").click(function () {

                var nic = $("#tdNicNumber").val();
                var firstName = $("#tdFirstName").val();
                var lastName = $("#tdLastName").val();
                var address = $("#tdAddress").val();
                var telephoneNumber = $("#tdTelephoneNumber").val();
                var status = $('input[name=tdStatusRadios]:checked').val();
                var gender = $('input[name=tdGenderRadios]:checked').val();
                var currentClassId = $('#tdClassSelection').val();

                if (nic === "" || firstName === "" || lastName === "" || address === "" || telephoneNumber === "" || status === "" || gender === "" || currentClassId === "") {
                    console.log("not completed properly");
                } else {
                    var teacherUpdateObject = {
                        nic: nic,
                        firstName: firstName,
                        lastName: lastName,
                        address: address,
                        telephoneNumber: telephoneNumber,
                        status: status,
                        gender: gender,
                        currentClassId: currentClassId
                    };

                    console.log("teacher object : " + JSON.stringify(teacherUpdateObject));
                    saveATeacher(JSON.stringify(teacherUpdateObject));
                }

            }
            );

            $("#updateTeacherBtn").click(function () {

                var nic = $("#tdDisplayNicNumber").val();
                var firstName = $("#tdFirstName").val();
                var lastName = $("#tdLastName").val();
                var address = $("#tdAddress").val();
                var telephoneNumber = $("#tdTelephoneNumber").val();
                var status = $('input[name=tdStatusRadios]:checked').val();
                var gender = $('input[name=tdGenderRadios]:checked').val();
                var currentClassId = $("#tdDisplayCurrentClassId").val();

                if (nic === "" || firstName === "" || lastName === "" || address === "" || telephoneNumber === "" || status === "" || gender === "" || currentClassId === "") {
                    console.log("not completed properly");
                } else {
                    var teacherUpdateObject = {
                        nic: nic,
                        firstName: firstName,
                        lastName: lastName,
                        address: address,
                        telephoneNumber: telephoneNumber,
                        status: status,
                        gender: gender,
                        currentClassId: currentClassId
                    };

                    console.log("teacher object : " + JSON.stringify(teacherUpdateObject));
                    updateATeacher(JSON.stringify(teacherUpdateObject));
                }

            }
            );

            function saveATeacher(teacherData) {
                $.ajax({
                    type: "post",
                    contentType: 'application/json; charset=utf-8',
                    url: "http://localhost:8090/api/studentMg/teacher/add",
                    data: teacherData,
                    crossDomain: true,
                    dataType: "json",
                    success: function (data) {
                        window.location.reload();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("teacher save failed. " + xhr.status);
                    }
                });
            }

            function updateATeacher(teacherData) {
                $.ajax({
                    type: "put",
                    contentType: 'application/json; charset=utf-8',
                    url: "http://localhost:8090/api/studentMg/teacher/update",
                    data: teacherData,
                    crossDomain: true,
                    dataType: "json",
                    success: function (data) {
                        window.location.reload();

                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("teacher update failed. " + xhr.status);
                    }
                });
            }

            function getTeacherDetails(nicNumber) {
                $.ajax({
                    type: "get",
                    url: "http://localhost:8090/api/studentMg/teacher/get/" + nicNumber,
                    data: {},
                    crossDomain: true,
                    dataType: "json",
                    success: function (data) {
                        console.log("recei : " + data.toString());
                        if (data.nic !== "") {
                            $("#teacherNoResultsCard").css("display", "none");
                            $("#teacherInfoDisplayCard").css("display", "block");
                            $("#tdInfoAdClassSection").css("display", "block");
                            $("#tdNicNumberSection").css("display", "none");
                            $("#newTeacherSaveBtn").css("display", "none");
                            $("#updateTeacherBtn").css("display", "block");
                            $("#tdCurrentClassSelectSection").css("display", "none");

                            $("#tdDisplayNicNumber").val(data.nic);
                            $("#tdDisplayNicNumber").prop('disabled', true);

                            $("#tdFirstName").val(data.firstName);
                            $("#tdLastName").val(data.lastName);
                            $("#tdAddress").val(data.address);
                            $("#tdTelephoneNumber").val(data.telephoneNumber);
                            $("#td" + data.gender + "radio").prop("checked", true);
                            $("#tdstatus" + data.status + "radio").prop("checked", true);

                            $("#tdDisplayCurrentClassName").val(data.currentClass.grade + " - " + data.currentClass.name);
                            $("#tdDisplayCurrentClassId").val(data.currentClass.id);

                        } else {
                            console.log("get student failed.");
                        }
                    },
                    error: function (data) {
                        console.log("get student failed." + data);
                        $("#teacherInfoDisplayCard").css("display", "none");
                        $("#teacherNoResultsCard").css("display", "block");
                    }
                });

            }

            /* Toggle between adding and removing the "responsive" class to topnav when the user clicks on the icon */
            function myFunction() {
                console.log("method started.");
                var x = document.getElementById("myTopnav");
                if (x.className === "topnav") {
                    x.className += " responsive";
                } else {
                    x.className = "topnav";
                }
            }

            //students sections
            $("#studentSearchInputValue").on('keyup', function (e) {
                if (e.keyCode === 13) {//submit when enter key is pressed in admission number input field
                    $("#studentSearchBtn").click();
                }
            });

            //search button action
            $("#studentSearchBtn").click(function () {
                var studentAd = $("#studentSearchInputValue").val();

                if (studentAd !== null) {
                    getStudentDetails(studentAd);
                } else {
                    console.log("search admission number is null. ");
                }
            });

            //add new student button action
            $("#addNewStudentButton").click(function () {
                $("#studentInfoDisplayCard").css("display", "block");
                $("#studentNoResultsCard").css("display", "none");

                $("#sdAdmissionNumberSection").css("display", "block");
                $("#sdCurrentClassSelectSection").css("display", "block");
                $("#displayInfoAdClassSection").css("display", "none");

                $("#updateStudentSaveBtn").css("display", "none");
                $("#newStudentSaveBtn").css("display", "block");

                $("#studentDetailsForm").closest('form').find("input[type=text],input[type=date]").val("");
            });

            //new student save button
            $("#newStudentSaveBtn").click(function () {
                var admissionNum = $('#sdAdmissionNumber').val().trim();
                var firstName = $('#sdFirstName').val().trim();
                var lastName = $('#sdLastName').val();
                var birthday = $('#sdBday').val();
                var address = $('#sdAddress').val();
                var enrolledDate = $('#sdEnrolledDate').val();
                var classId = $('#classSelection').val();
                var status = $('input[name=statusRadios]:checked').val();

                if (admissionNum === "" || firstName === "" || lastName === "" || birthday === null || address === "" || enrolledDate === "") {
                    console.log("not complted properly");
                } else {
                    var studentAddObject = {
                        admissionNumber: admissionNum,
                        firstName: firstName.charAt(0).toUpperCase() + firstName.slice(1),
                        lastName: lastName.charAt(0).toUpperCase() + lastName.slice(1),
                        bday: birthday,
                        address: address,
                        enrolledDate: enrolledDate,
                        status: status,
                        currentClassId: classId
                    };

                    console.log("student object : " + JSON.stringify(studentAddObject));
                    addNewStudent(JSON.stringify(studentAddObject));
                }

            });

            //update student save button
            $("#updateStudentSaveBtn").click(function () {
                var admissionNum = $('#sdDisplayAdmissionNumber').val().trim();
                var firstName = $('#sdFirstName').val().trim();
                var lastName = $('#sdLastName').val();
                var birthday = $('#sdBday').val();
                var address = $('#sdAddress').val();
                var enrolledDate = $('#sdEnrolledDate').val();
                var classId = $('#sdDisplayCurrentClassId').val();
                var status = $('input[name=statusRadios]:checked').val();

                if (admissionNum === "" || firstName === "" || lastName === "" || birthday === null || address === "" || enrolledDate === "") {
                    console.log("not complted properly");
                } else {
                    var studentAddObject = {
                        admissionNumber: admissionNum,
                        firstName: firstName.charAt(0).toUpperCase() + firstName.slice(1),
                        lastName: lastName.charAt(0).toUpperCase() + lastName.slice(1),
                        bday: birthday,
                        address: address,
                        enrolledDate: enrolledDate,
                        status: status,
                        currentClassId: classId
                    };

                    console.log("student object : " + JSON.stringify(studentAddObject));
                    updateAStudent(JSON.stringify(studentAddObject));
                }

            });


            //api requests
            function addNewStudent(studentData) {
                $.ajax({
                    type: "post",
                    contentType: 'application/json; charset=utf-8',
                    url: "http://localhost:8090/api/studentMg/student/add",
                    data: studentData,
                    crossDomain: true,
                    async: true,
                    dataType: "json",
                    success: function (data) {
                        if (data.admissionNumber !== "") {
                            window.location.reload();
                            window.history.replaceState(null, null, window.location.pathname);
                        } else {
                            console.log("save failed.");
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("student save failed. " + xhr.status);
                    }
                });

            }

            function updateAStudent(studentData) {
                $.ajax({
                    type: "put",
                    contentType: 'application/json; charset=utf-8',
                    url: "http://localhost:8090/api/studentMg/student/update",
                    data: studentData,
                    crossDomain: true,
                    dataType: "json",
                    success: function (data) {
                        if (data.admissionNumber !== null) {
                            window.location.reload();
                        } else {
                            console.log("save failed.");
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("student update failed. " + xhr.status);
                    }
                });
            }

            function getStudentDetails(admissionNumber) {
                $.ajax({
                    type: "get",
                    url: "http://localhost:8090/api/studentMg/student/get/" + admissionNumber, //this is my servlet
                    data: {},
                    crossDomain: true,
                    dataType: "json",
                    success: function (data) {
                        console.log("recei : " + data.toString());
                        if (data !== null) {
                            $("#studentInfoDisplayCard").css("display", "block");
                            $("#studentNoResultsCard").css("display", "none");

                            $("#displayInfoAdClassSection").css("display", "block");
                            $("#sdAdmissionNumberSection").css("display", "none");

                            $("#sdDisplayAdmissionNumber").prop("disabled", true);

                            if (data.currentClass.grade === 0) {
                                $("#sdDisplayCurrentClassName").val("Not Assigned");
                            } else {
                                $("#sdDisplayCurrentClassName").val(data.currentClass.grade + " - " + data.currentClass.name);
                            }

                            $("#sdDisplayCurrentClassId").val(data.currentClass.id);

                            $("#sdDisplayAdmissionNumber").val(data.admissionNumber);
                            $("#sdFirstName").val(data.firstName);
                            $("#sdLastName").val(data.lastName);
                            $("#sdAddress").val(data.address);
                            $("#sdBday").val(data.bday);
                            $("#sdEnrolledDate").val(data.enrolledDate);

                            $("#status" + data.status + "radio").prop("checked", true);

                            $("#sdCurrentClassSelectSection").css("display", "none");

                            $("#updateStudentSaveBtn").css("display", "block");
                            $("#newStudentSaveBtn").css("display", "none");

                        } else {
                            console.log("get student failed.");
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log("teacher display failed. " + xhr.status);
                        $("#studentNoResultsCard").css("display", "block");
                        $("#studentInfoDisplayCard").css("display", "none");
                    }
                });

            }


            function someFunc(arg) {

                const div = document.createElement('div-user');

                div.innerHTML = `
                        <div class="card">
                        <div class="card-body">
                        <h5 class="card-title">User Details</h5>
                            <div class="row" style="margin-bottom: 10px;">
                                <label class="col-md-4">User ID</label>
                                <input class="col-md-8" disabled value="` + arg.id + `"></input>
                            </div>
                            
                                <div class="row">
                                <label class="col-md-4">Role</label>
                                <input class="col-md-8" disabled value="` + arg.role + `"></input>
                        </div>                                 
                        </div>
                        </div>
                                                    `;

                const parentT = document.getElementById(arg.sectionId);
                parentT.innerHTML = "";
                parentT.appendChild(div);


            }


            function searchFunction(args) {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById(args.inputId);
                filter = input.value.toUpperCase();
                table = document.getElementById(args.table);
                tr = table.getElementsByTagName("tr");
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0];
                    tdTwo = tr[i].getElementsByTagName("td")[1];
                    if (td || tdTwo) {
                        txtValue = td.textContent || td.innerText;

                        textValueTwo = tdTwo.textContent || tdTwo.innerText;

                        if (txtValue.toUpperCase().indexOf(filter) > -1 || textValueTwo.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }


        </script>

    </body>
</html>
