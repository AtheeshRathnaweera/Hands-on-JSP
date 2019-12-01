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
                position:fixed;
                bottom:0;
                left:0;
            }

            .singleClassCard:hover{
                background-color: lightgreen;
                opacity: 2;
                -webkit-opacity: 2;
                -moz-opacity: 2;
                transition: 0.6s ease;
                -webkit-transition: 0.6s ease;
                -moz-transition: 0.6s ease;


            }





        </style>





    </head>

    <%        UserModel userData = (UserModel) session.getAttribute("userData");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MMM-dd");
        String status = "" + request.getParameter("status");

        String currentGrade = "" + request.getParameter("grade");

        System.out.println("status = " + status);

        if (userData == null || userData.getUserRole().equals("admin")) {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        }

        List<ClassModel> classesList = getAllClassesByGrade(Integer.parseInt(currentGrade));

    %>






    <body style="background-color: whitesmoke;">
        <script>
            $(document).ready(function () {

            <%if (status.equals("saveFailed")) {%>

                $("#notificationHolder").css("display", "block");
                $(".failedAlert").hide().fadeIn(400).delay(1700).fadeOut(800, function () {
                    $(".failedAlert").fadeOut(1000, 500);
                    $("#notificationHolder").css("display", "none");
                });
            <%}%>


                getClassesOfGrade(<%=currentGrade%>);


                function getClassesOfGrade(gradeNum) {
                    //get all the classes of the grade and display in #allClassesHolder div
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8090/api/studentMg/class/getClasses/" + gradeNum, //this is my servlet
                        data: {},
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            if (data.length < 1) {
                                var noDataMessage = $('<div class="col-md-12" id="noDataDiv" style="color: grey; font-size: 1vw; text-align:center; margin-top:10%;">Nothing to display</div>');
                                $('#allClassesHolder').append(noDataMessage);
                            } else {
                                for (var i = 0; i < data.length; i++) {
                                    var classCard = $('<div class="col-md-3 col-sm-3" style="padding: 1%;">\n\
                                    <a class="singleClassCard card" style="color: inherit; text-decoration:none; border-radius: 10px;" href="./classInfo.jsp?grade=' + gradeNum + '&classid=' + data[i].id + '">\n\
                                        <div  style="background-color: green; text-align: center; color: white; border-radius: 10px 10px 0 0; padding: 2%;">\n\
                                            <h4 style="font-size: 1.6vw;">' + data[i].name + '</h4>\n\
                                        </div>\n\
                                        <div class="card-body" style="margin-left: 3%;">\n\
                                            <div class="row" style="font-size: 1.1vw;">Teacher Name : <span style="font-style: italic; margin-left: 2%;" id="teacherName' + data[i].id + '"></span></div>\n\
                                            <div class="row" style="font-size: 1.1vw;">Total Students : <span style="font-style: italic; margin-left: 2%;" id="totalStudents' + data[i].id + '"></span></div>\n\
                                        </div>\n\
                                    </a>');
                                    $('#allClassesHolder').append(classCard);
                                    getClassTeacherName(data[i].id);
                                    getClassStudentsAmount(data[i].id);
                                }

                            }


                        }
                    });

                }

                function getClassTeacherName(classId) {
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8090/api/studentMg/class/getTeacher/" + classId,
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            if (data.length < 1) {
                                $("#teacherName" + classId).text("not assigned");
                            } else {
                                var teacherName = data[0].firstName + " " + data[0].lastName;
                                $("#teacherName" + classId).text(teacherName);
                            }

                        }

                    });
                }

                function getClassStudentsAmount(classId) {
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8090/api/studentMg/class/getStudentsCount/" + classId,
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            $("#totalStudents" + classId).text(data);
                        }

                    });
                }

                $("#addModalSaveBtn").click(function () {
                    $("#addClassModalCloseBtn").click();
                    var className = $('#modalClassName').val();
                    saveAClass(<%=currentGrade%>, className);
                });

                function saveAClass(gradeRec, className) {
                    console.log("save classes method started " + gradeRec + "  " + className);
                    $.ajax({
                        type: "post",
                        contentType: 'application/json; charset=utf-8',
                        url: "http://localhost:8090/api/studentMg/class/add",
                        data: '{ "grade": "' + gradeRec + '", "name": "' + className + '"}',
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            console.log("received : " + data);
                            if (data.length < 0) {
                                console.log("new class save failed.");
                            } else {
                                $('#noDataDiv').remove();
                                var newClassCard = $('<div class="col-md-3 col-sm-3" style="padding: 1%;">\n\
                                    <a class="singleClassCard card" style="color: inherit; text-decoration:none; border-radius: 10px;" href="./classInfo.jsp?grade=' + gradeRec + '&classid=' + data.id + '">\n\
                                        <div  style="background-color: green; text-align: center; color: white; border-radius: 10px 10px 0 0; padding: 2%;">\n\
                                            <h4 style="font-size: 1.6vw;">' + data.name + '</h4>\n\
                                        </div>\n\
                                        <div class="card-body" style="margin-left: 3%;">\n\
                                            <div class="row" style="font-size: 1.1vw;">Teacher Name : <span style="font-style: italic; margin-left: 2%;" id="teacherName' + data.id + '"></span></div>\n\
                                            <div class="row" style="font-size: 1.1vw;">Total Students : <span style="font-style: italic; margin-left: 2%;" id="totalStudents' + data.id + '"></span></div>\n\
                                        </div>\n\
                                    </a>');
                                $('#allClassesHolder').append(newClassCard);
                                getClassTeacherName(data.id);
                                getClassStudentsAmount(data.id);
                            }
                            // $('#resultsShow').append(msg);
                        }
                    });

                }

                window.history.replaceState(null, null, window.location.pathname + "?grade=" +<%=currentGrade%>);
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
                        <a class="nav-link" href="./operatorDashboard.jsp">Dashboard<span class="sr-only">(current)</span></a>
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

            <!--            Notification-->
            <div class="notification" id="notificationHolder" style="width:100%; display: none; z-index:2; position:absolute;">
                <div class="col-sm-3 failedAlert card m-2" style="float: right; background-color: red;"> 
                    <div class="card-body">
                        <p style="color: white; font-size: 1.2em; margin: auto;">Class already exists !</p> 
                    </div>
                </div>
            </div>
            <!--            Notification-->


            <!--New class adding-->
            <div class="col-md-12 newClassAddHolder row" style="padding: 1%;">
                <div class="col-md-2 col-sm-3">
                    <h4 class="text-info" style="margin-left: 7%;">GRADE <%=currentGrade%></h4>
                </div>
                <div class="col-md-10 col-sm-9">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addClassModal" style="float: right;">Add a class</button> 
                </div>
            </div>
            <!--New class adding-->

            <!--            Class data display here-->
            <div class="col-md-12 calssesHolder row" style="margin: auto;" id="allClassesHolder">


            </div>
            <!--            Class data display here-->

        </div>
        <!--        Navigation bar-->

        <!--        Add a class modal-->
        <div class="modal fade" id="addClassModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-dark" >
                        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;" >Add a new class</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">


                        <div class="form-group row">
                            <div class="enrolledDateClass col-md-6">
                                <label for="gradeText">Grade </label>
                                <input class="form-control" id="gradeText" disabled value="<%=currentGrade%>">
                            </div>

                            <div class="enrolledDateClass col-md-6">
                                <label for="className">Class Name</label>
                                <input class="form-control" id="modalClassName" name="className">
                            </div>
                        </div>



                        <input type="hidden" name="action" value="addAClass">
                        <input type="hidden" name="classGrade" value="<%=currentGrade%>">

                        <div class=" col-md-12" style="padding-right: 8%; padding-top: 4%;">
                            <div class="row" style="float: right;">
                                <button type="button" id="addClassModalCloseBtn" class="btn bg-teal-300" style="background-color: blueviolet; color: white; margin-right: 13px;" data-dismiss="modal">Close</button>
                                <button class="btn bg-teal-300" style="background-color: orangered; color: white;" id="addModalSaveBtn">Save</button>
                            </div>

                        </div>




                    </div>


                </div>


            </div>

        </div>
        <!--        Add a class modal-->

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







        </script>

    </body>
</html>
