<%@page import="lk.studentsmanage.models.UserModel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lk.studentsmanage.models.StudentModel"%>
<%@include file="controller/StudentController.jsp" %>
<%@include file="controller/TeacherController.jsp" %>
<%@include file="controller/AdminController.jsp" %>

<html>
    <head>
        <title>School Management</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--        Bootstrap needs-->
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
                position:fixed;
                bottom:0;
                left:0;
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

    %>





    <body>

        <script>



            $(document).ready(function () {
            <%if (status.equals("savedOp")) {%>
                jQuery(function () {
                    jQuery('#operator-settings').click();
                });
                window.history.replaceState(null, null, window.location.pathname);
            <%} else {%>
                $("#student-settings").css("background-color", "lightgrey");
            <%}%>

                $('#student-settings').click(function () {

                    $("#student-settings").css("background-color", "lightgrey");
                    $("#operator-settings").css("background-color", "white");
                    $("#teacher-settings").css("background-color", "white");

                    $("#student-section").css("display", "block");
                    $("#teacher-section").css("display", "none");
                    $("#operator-section").css("display", "none");
                });

                $('#teacher-settings').click(function () {

                    $("#teacher-settings").css("background-color", "lightgrey");
                    $("#student-settings").css("background-color", "white");
                    $("#operator-settings").css("background-color", "white");

                    $("#teacher-section").css("display", "block");
                    $("#operator-section").css("display", "none");
                    $("#student-section").css("display", "none");
                });

                $('#operator-settings').click(function () {

                    $("#teacher-settings").css("background-color", "white");
                    $("#student-settings").css("background-color", "white");
                    $("#operator-settings").css("background-color", "lightgrey");

                    $("#teacher-section").css("display", "none");
                    $("#student-section").css("display", "none");
                    $("#operator-section").css("display", "block");
                });
            });

        </script>



        <!--        Navigation bar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark" >
            <!--            <a class="navbar-brand" href="#">PRESIDENT S COLLEGE</a>-->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Dashboard <span class="sr-only">(current)</span></a>
                    </li>

                </ul>
            </div>

            <div class = "dropdown" style="color: white;">
                <a style="color:white;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-fw fa-user" style="font-size: 23px; color: white;"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item"  data-toggle="modal" data-target="#userProfileView">View profile</a>
                    <a class="dropdown-item" href="#">Settings</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="index.jsp?status=logout"><strong>Log Out</strong></a>
                </div>
            </div>
        </nav>
        <!--        Navigation bar-->



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

                        <!--                        Student user details -->
                        <form>
                            <div class="form-group">
                                <label for="adminUserName">Name</label>
                                <input class="form-control" id="adminUserName" disabled value="<%=userData.getUserId()%>">
                            </div>

                            <div class="form-group">
                                <label for="studentFirstName">Role</label>
                                <input class="form-control" id="studentFirstName" disabled value="<%=userData.getUserRole()%>">
                            </div>

                        </form>
                        <!--                        Student user details -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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

                        <div class="card "style=" height: 100%; cursor: pointer;" id="student-settings">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-xs-4 col-md-4 col-sm-4 col-lg-4  ">
                                        <img class="cardAvatar" src="assets/images/reading.png" alt="Student Avatar" style="height: auto; "> 
                                    </div>

                                    <div class="col-xs-8 col-md-8 col-sm-8 col-lg-8">
                                        <h4 style="font-size:1.1vw;">Student Users</h4>
                                        <h3 style="font-size:3.5vw;"><%=studentUsersCount%></h3>
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
                                        <h4 style="font-size:1.1vw;">Teacher Users</h4>
                                        <h3 style="font-size:3.5vw;"><%=teacherUsersCount%></h3>
                                    </div>
                                </div>

                            </div>

                        </div>


                    </div>

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">

                        <div class="card" style=" height: 100%; cursor:pointer;" id="operator-settings" >
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-xs-4 col-sm-4 col-lg-4">
                                        <img class="cardAvatar" src="assets/images/family.png" alt="Family Avatar" style="height: auto; "> 
                                    </div>

                                    <div class="col-xs-8 col-sm-8 col-lg-8">
                                        <h4 style="font-size:1.1vw;">Operators</h4>
                                        <h3 style="font-size:3.5vw;"><%=operatorsCount%></h3>
                                    </div>
                                </div>

                            </div>

                        </div>


                    </div>

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">
                        <a href="" style="color: inherit;">
                            <div class="card" style=" height: 100%;">
                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-xs-4 col-sm-4 col-lg-4">
                                            <img class="cardAvatar" src="assets/images/notepad.png" alt="Student Avatar" style="height: auto; "> 
                                        </div>

                                        <div class="col-xs-8 col-sm-8 col-lg-8">
                                            <h4 style="font-size:1.1vw;">Notice</h4>
                                            <h3 style="font-size:1vw;">Important notices will be display here</h3>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </a>

                    </div>



                </div>

            </div>




            <div class="card-content" style="padding-left: 1%; padding-right: 1%;">
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
                <div  id="operator-section" style="display: none">
                    <h3>Operators section</h3>
                    <div class="row">
                        <div class="col-md-8">
                            <input style="background-image: url('assets/images/searchIcon.png');" type="text" id="operatorSearchInput" onkeyup="searchFunction({inputId: 'operatorSearchInput', table: 'operatorTable'})" placeholder="Search for users..">
                            <div style="height: 77%; overflow-y: auto">
                                <table id="operatorTable">
                                    <tr class="header">
                                        <th style="width:30%;">NIC</th>
                                        <th style="width:40%;">NAME</th>
                                        <th style="width:30%;">STATUS</th>
                                    </tr>
                                    <%
                                        for (OperatorModel us : operators) {

                                    %>
                                    <tr style="cursor: pointer;" onclick="operatorFunc({nic: '<%=us.getNic()%>', name: '<%=us.getFirstName() + " " + us.getLastName()%>', address: '<%=us.getAddress()%>', birthday: '<%=us.getBday()%>', enrolledDate: '<%=us.getEnrolledDate()%>', status: '<%=us.getStatus()%>'})">
                                        <td><%=us.getNic()%></td>
                                        <td><%=us.getFirstName() + " " + us.getLastName()%></td>
                                        <td style="<% if(us.getStatus().equals("active")){%> color:green; <%}else if(us.getStatus().equals("blocked")){%> color:red; <%}else{%>color:lightblue;<%}%>"><%=us.getStatus()%></td>
                                    </tr>                              
                                    <%}%>                       
                                </table> 
                            </div>
                        </div>

                        <div class="col-md-4" >
                            <div id="operator_data_section">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">User Details</h5>
                                        <div class="row" style="margin-bottom: 10px;">
                                            <label class="col-md-4">Nic</label>
                                            <input class="col-md-8" disabled value="Not define"></input>
                                        </div>

                                        <div class="row" style="margin-bottom: 10px;">
                                            <label class="col-md-4">Name</label>
                                            <input class="col-md-8" disabled value="Not define"></input>
                                        </div> 

                                        <div class="row" style="margin-bottom: 10px;">
                                            <label class="col-md-4">Birthday</label>
                                            <input class="col-md-8" disabled value="Not define"></input>
                                        </div>

                                        <div class="row" style="margin-bottom: 10px;">
                                            <label class="col-md-4">Address</label>
                                            <input class="col-md-8" disabled value="Not define"></input>
                                        </div> 

                                        <div class="row" style="margin-bottom: 10px;">
                                            <label class="col-md-4">Enrolled Date</label>
                                            <input class="col-md-8" disabled value="Not define"></input>
                                        </div> 

                                        <div class="row">
                                            <label class="col-md-4">Status</label>
                                            <input class="col-md-8" disabled value="Not define"></input>
                                        </div>                                 
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-primary" style="width: 100%; margin-top: 3%;" data-toggle="modal" data-target="#addOperatorModal">Add Operator</button>

                        </div>
                    </div>

                    <!-- add operator Modal -->
                    <div class="modal fade" id="addOperatorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header bg-dark" >
                                    <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">Add Operator</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!--                        operator add modal -->
                                    <form action="controller/AdminController.jsp"> 
                                        <div class="form-group">
                                            <label for="operatorNic">NIC</label>
                                            <input class="form-control" id="operatorNic" name="nic" pattern="\d{11}|\d{9}\w{1}"  maxlength=10 minlength=9 required>
                                        </div>

                                        <div class="form-group">
                                            <label for="operatorFirstName">First Name</label>
                                            <input class="form-control" id="operatorFirstName" name="firstName" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="operatorLastName">Last Name</label>
                                            <input class="form-control" id="operatorLastName" name="lastName" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="operatorLastName">Birthday</label>
                                            <input class="form-control"  type="date" name="birthday" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="operatorAddress">Address</label>
                                            <input class="form-control" id="operatorAddress" name="address" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="operatorLastName">Enrolled Date</label>
                                            <input class="form-control" type="date" name="enrolledDate" required>
                                        </div>

                                        <div class="form-group" >
                                            <label style="width: 100%;">Status</label>
                                            <div class="row" style="text-align: center; width: 100%;">
                                                <input class="col-sm-2" type="radio" name="status" value="active" checked> Active
                                                <input class="col-sm-2" type="radio" name="status" value="blocked" > Blocked
                                                <input class="col-sm-2" type="radio" name="status" value="retired" > Retired
                                            </div>
                                        </div>

                                        <input type="hidden" name="action" value="addOperator">

                                        <div style="margin-top:4%; " class="form-group">
                                            <div class="row mr-1" style="float: right;">
                                                <button type="submit" class="btn btn-secondary mr-2">Save</button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>

                                    </form>
                                    <!--                        Student user details -->
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- add operator Modal -->



                </div>


            </div>



        </div>
        <!--        Navigation bar-->


        <footer class="container-fluid text-center">
            <p>Footer Text</p>
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
