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
                /*                position:fixed;*/
                /*                bottom:0;
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

        List<UserModel> studentUsers = getAllStudentUsers();
        int studentUsersCount = studentUsers.size();

        List<UserModel> teacherUsers = getAllTeacherUsers();
        int teacherUsersCount = teacherUsers.size();

        List<OperatorModel> operators = getAllOperators();
        int operatorsCount = operators.size();

        System.out.println("userdata : " + userData.toString());

        Long classAmount = getAllClassCount() - 1; //-1 for remove the default null class
        Long studentsAmount = getAllStudentsCount();
        Long teachersAmount = getTeachersCount();

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
                                        <div style="font-size:1.1vw;">Student Users</div>
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
                                        <div style="font-size:1.1vw;">Teacher Users</div>
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
                <div  id="class-section" style="display: none">

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


                </div>

                <div  id="student-section" style="display: block">
                    <h3>Students section</h3>
                    <div class="row">
                        <div class="col-md-8">
                            <input style="background-image: url('assets/images/searchIcon.png');" type="text" id="studentSearchInput" onkeyup="searchFunction({inputId: 'studentSearchInput', table: 'studentTable'})" placeholder="Search for users..">
                            <div style="height: 77%; overflow-y: auto">
                                <table id="studentTable">
                                    <tr class="header">
                                        <th style="width:60%;">USER ID</th>
                                        <th style="width:40%;">ROLE</th>
                                    </tr>

                                    <%
                                        for (UserModel us : studentUsers) {

                                    %>
                                    <tr style="cursor: pointer;" onclick="someFunc({id: '<%=us.getUserId()%>', role: '<%=us.getUserRole()%>', sectionId: 'student_data_section'})">
                                        <td><%=us.getUserId()%></td>
                                        <td><%=us.getUserRole()%></td>
                                    </tr>                              
                                    <%}%>                       
                                </table> 
                            </div>
                        </div>

                        <div class="col-md-4" id="student_data_section">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">User Details</h5>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <label class="col-md-4">User ID</label>
                                        <input class="col-md-8" disabled value="Not define"></input>
                                    </div>

                                    <div class="row">
                                        <label class="col-md-4">Role</label>
                                        <input class="col-md-8" disabled value="Not define"></input>
                                    </div>                                 
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div  id="teacher-section" style="display: none">
                    <h3>Teachers section</h3>
                    <div class="row">
                        <div class="col-md-8">
                            <input style="background-image: url('assets/images/searchIcon.png');" type="text" id="teacherSearchInput" onkeyup="searchFunction({inputId: 'teacherSearchInput', table: 'teacherTable'})" placeholder="Search for users..">
                            <div style="height: 77%; overflow-y: auto">
                                <table id="teacherTable">
                                    <tr class="header">
                                        <th style="width:60%;">USER ID</th>
                                        <th style="width:40%;">ROLE</th>
                                    </tr>
                                    <%
                                        for (UserModel us : teacherUsers) {

                                    %>
                                    <tr style="cursor: pointer;" onclick="someFunc({id: '<%=us.getUserId()%>', role: '<%=us.getUserRole()%>', sectionId: 'teacher_data_section'})">
                                        <td><%=us.getUserId()%></td>
                                        <td><%=us.getUserRole()%></td>
                                    </tr>                              
                                    <%}%>                       
                                </table> 
                            </div>
                        </div>

                        <div class="col-md-4" id="teacher_data_section">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">User Details</h5>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <label class="col-md-4">User ID</label>
                                        <input class="col-md-8" disabled value="Not define"></input>
                                    </div>

                                    <div class="row">
                                        <label class="col-md-4">Role</label>
                                        <input class="col-md-8" disabled value="Not define"></input>
                                    </div>                                 
                                </div>
                            </div>


                        </div>
                    </div>
                </div>



            </div>



        </div>
        <!--        Navigation bar-->


        <footer class="container-fluid text-center" style="padding: 1%;">
            <div style="font-size: 1.3vw;">Footer Text</div>
        </footer>




        <script>

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

            function operatorFunc(arg) {

                const div = document.createElement('div-user');

                var checkedActive = "";
                var checkedBlocked = "";
                var checkedRetired = "";

                //check the radio button according to the user current status
                if (arg.status === "active") {
                    checkedActive = "checked";
                } else if (arg.status === "blocked") {
                    checkedBlocked = "checked";
                } else if (arg.status === "retired") {
                    checkedRetired = "checked";
                }

                div.innerHTML = `
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">User Details</h5>
                                    <div class="row" style="margin-bottom: 10px;">
                                        <label class="col-md-4">Nic</label>
                                        <input class="col-md-8" disabled value="` + arg.nic + `"></input>
                                    </div>
                                    
                                    <div class="row" style="margin-bottom: 10px;">
                                            <label class="col-md-4">Name</label>
                                            <input class="col-md-8" disabled value="` + arg.name + `"></input>
                                    </div> 
                    
                                    <div class="row" style="margin-bottom: 10px;">
                                        <label class="col-md-4">Birthday</label>
                                        <input class="col-md-8" disabled value="` + arg.birthday + `"></input>
                                    </div> 
                        
                                    <div class="row" style="margin-bottom: 10px;">
                                        <label class="col-md-4">Address</label>
                                        <input class="col-md-8" disabled value="` + arg.address + `"></input>
                                    </div> 
                                    
                                    <div class="row" style="margin-bottom: 10px;">
                                        <label class="col-md-4">Enrolled Date</label>
                                        <input class="col-md-8" disabled value="` + arg.enrolledDate + `"></input>
                                    </div> 
                                
                                    <div class="row">
                                        <label class="col-md-4">Status</label>
                                        <input class="col-md-8" disabled value="` + arg.status + `"></input>
                                    </div>   
                        
                                    <div class="row " style="width=100%; display:flex;">
                                        <button class="btn btn-danger" style="margin-left: auto; margin-top:3%;" data-toggle="modal" data-target="#operatorAccessControl">Access Control</button>
                                    </div>
                            </div>                                
                        </div>
                                    
                                    <div class="modal fade" id="operatorAccessControl" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-dark" >
                                <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">Operator Access Control</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                 
                                    <form action="controller/AdminController.jsp"> 
        
                                        <div class="form-group">
                                            <div class="row" style="margin: 0 auto;">
                                                <div class="col-sm-1"></div>
                                                <div class="col-sm-3">
                                                    <input type="radio" name="status" value="active" ` + checkedActive + `> Active
                                                </div>
                                                <div class="col-sm-1"></div>
                                                <div class="col-sm-3">
                                                    <input type="radio" name="status" value="blocked" ` + checkedBlocked + `> Blocked
                                                </div>
                                                <div class="col-sm-1"></div>
                                                <div class="col-sm-3">
                                                    <input type="radio" name="status" value="retired" ` + checkedRetired + `> Retired
                                                </div>
                                            </div>
                                        </div>
        
                                        
                                        <input type="hidden" name="nic" value="` + arg.nic + `">
                                        <input type="hidden" name="action" value="accessOperator">

                                        <div style="margin-top:4%; " class="form-group">
                                            <div class="row mr-1" style="float: right;">
                                                <button type="submit" class="btn btn-secondary mr-2">Update</button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </form>
                                 
                                </div>

                            </div>
                        </div>
                    </div>
                    
                      `;

                const parentT = document.getElementById('operator_data_section');
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
