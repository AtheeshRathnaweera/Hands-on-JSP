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







    </head>







    <body style="background-color: whitesmoke;">


        <script type="text/javascript">
            $(document).ready(function () {
                console.log("started.");
                allClassCount();



                function allClassCount() {
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8090/api/studentMg/class/allCount", //this is my servlet
                        crossDomain: true,
                        dataType: "json",
                        success: function (msg) {
                            $('#resultsShow').text("Total classes : " + msg);
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
                            console.log(data.length);
                            if(data.length < 1){
                                $("#teacherName" + classId).text("not assigned");
                            }else{
                                var teacherName = data[0].firstName + " " + data[0].lastName;
                                $("#teacherName" + classId).text(teacherName);
                            }

                        }

                    });
                }

                function getClassesOfGrade(param) {
                    console.log("get classes method started " + param);
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8090/api/studentMg/class/getClasses/" + param, //this is my servlet
                        data: {},
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            console.log("received : " + data);
                            for (var i = 0; i < data.length; i++) {
                                var classCard = $('<div class="col-md-3 col-sm-3" style="padding: 1%;">\n\
                                    <div class="card" >\n\
                                              <card-title style="background-color: green; color: white; text-align:center;">' + data[i].name + '</card-title><card-body> Teacher Name : <span id="teacherName' + data[i].id + '"></span></card-body></div></div>');
                                $('#classesDetailsHolder').append(classCard);
                                getClassTeacherName(data[i].id);
                            }


                        }
                    });

                }

                function saveAClass(gradeRec, className) {
                    console.log("save classes method started " + gradeRec + "  " + className);
                    $.ajax({
                        type: "post",
                        contentType: 'application/json; charset=utf-8',
                        url: "http://localhost:8090/api/studentMg/class/add",
                        data: '{ "grade": "' + gradeRec + '", "name": "' + className + '"}',
                        crossDomain: true,
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            console.log("received : " + data);
                            allClassCount();
                            // $('#resultsShow').append(msg);
                        }
                    });

                }


                $('#saveClassBtn').click(function () {
                    var sGrade = $('#gradeText').val();
                    var sClassName = $('#className').val();
                    saveAClass(sGrade, sClassName);

                });

                $('#viewBtn').click(function ()
                {
                    var grade = $('#gradeToView').val();
                    console.log("click button method started. Grade = " + grade);
                    getClassesOfGrade(grade);

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



        <!--        Page content-->
        <div class="page-content">

            <div style=" margin: 1% 0 1% 1%;">


                <div class="form-group row">
                    <div class="enrolledDateClass col-md-3">
                        <label for="gradeText">Grade </label>
                        <input class="form-control" id="gradeText">
                    </div>

                    <div class="enrolledDateClass col-md-3">
                        <label for="className">Class Name</label>
                        <input class="form-control" id="className">
                    </div>
                </div>
                <button id='saveClassBtn' class="btn bg-teal-300" style="background-color: orangered; color: white;">Save</button>



            </div>

            <div id='resultsShow' style="padding: 1%;">Total classes :  </div>

            <div style="margin: 1%;">
                <div class="enrolledDateClass col-md-3">
                    <label for="gradeText">Grade to view </label>
                    <input class="form-control" id="gradeToView">

                </div>

                <div class="col-md-5"> <button id='viewBtn'>View</button></div>

                <div id="classesDetailsHolder" class="col-md-12 row">


                </div>


            </div>
            <!--        Navigation bar-->



    </body>
</html>
