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

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
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

            .chip {
                display: inline-block;
                padding: 0 11px;
                height: 30px;
                font-size: 14px;
                line-height: 29px;
                border-radius: 25px;
                background-color: #f1f1f1;
                margin-right: 6px;
            }

            .chipclosebtn{
                padding-left: 8px;
                font-size: 15px;
                cursor: pointer;

            }

            .chipclosebtn:hover {
                color: #000;
            }

            #studentSearchInput,#assignStudentSearch {
                background-image: url('/css/searchicon.png'); /* Add a search icon to input */
                background-position: 10px 12px; /* Position the search icon */
                background-repeat: no-repeat; /* Do not repeat the icon image */
                width: 100%; /* Full-width */
                font-size: 13px; /* Increase font-size */
                padding: 12px 20px 12px 40px; /* Add some padding */
                border: 1px solid #ddd; /* Add a grey border */
                margin-bottom: 12px; /* Add some space below the input */
            }

            #studentTable,#assignStudentTable {
                border-collapse: collapse; /* Collapse borders */
                width: 100%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 14px; /* Increase font-size */
            }

            #studentTable th, #studentTable td ,#assignStudentTable th,#assignStudentTable td{
                text-align: left; /* Left-align text */
                padding: 12px; /* Add padding */
            }

            #studentTable tr, #assignStudentTable tr {
                /* Add a bottom border to all table rows */
                border-bottom: 0.5px solid #ddd;
                background-color: white;
            }

            #studentTable tr:hover {
                background-color: lightgrey;
            }

            #studentTable tr.header, #assignStudentTable tr.header{
                /* Add a grey background color to the table header and on hover */
                background-color: #f1f1f1;
            }





        </style>





    </head>

    <%        UserModel userData = (UserModel) session.getAttribute("userData");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MMM-dd");
        String status = "" + request.getParameter("status");

        String currentGrade = "" + request.getParameter("grade");
        String currentClassId = "" + request.getParameter("classid");
        ClassModel currentClassData = getClassInfo(Integer.parseInt(currentClassId));

        if (userData == null || userData.getUserRole().equals("admin")) {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        }

        List<ClassModel> classesList = getAllClassesByGrade(Integer.parseInt(currentGrade));
        List<StudentModel> studentsList = getAllStudentsOfAClass(Integer.parseInt(currentClassId));

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
                window.history.replaceState(null, null, window.location.pathname + "?grade=" +<%=currentGrade%> + "&classid=" +<%=currentClassId%>);

                getAllStudents(<%=currentClassId%>);

                $("#assignStartButton").click(function () {

                    console.log("student assigning started."+admissionNumList);
                    // $("#assignedModalCloseButton").click();


                });




                $("#studentAddBtn").click(function () {
                    var admissionNum = $('#admissionNumber').val().trim();
                    var firstName = $('#firstNameText').val().trim();
                    var lastName = $('#lastNameText').val();
                    var birthday = $('#studentBirthday').val();
                    var address = $('#addressText').val();
                    var enrolledDate = $('#studentEnrolledDate').val();

                    if (admissionNum === "" && firstName === "" && lastName === "" && birthday === null && address === "" && enrolledDate === "") {
                        console.log("not complted properly");
                    } else {
                        var studentAddObject = {
                            admissionNumber: admissionNum,
                            firstName: firstName.charAt(0).toUpperCase() + firstName.slice(1),
                            lastName: lastName.charAt(0).toUpperCase() + lastName.slice(1),
                            bday: birthday,
                            address: address,
                            enrolledDate: enrolledDate,
                            status: "active",
                            currentClassId: <%=currentClassId%>
                        };

                        console.log("student object : " + JSON.stringify(studentAddObject));
                        addAStudent(JSON.stringify(studentAddObject));


                    }


                });

                function addAStudent(studentData) {
                    $.ajax({
                        type: "post",
                        contentType: 'application/json; charset=utf-8',
                        url: "http://localhost:8090/api/studentMg/student/add",
                        data: studentData,
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            $("#studentAddModalCloseBtn").click();
                            console.log("received : " + data);
                            if (data.length < 0) {
                                console.log("new student save failed.");
                            } else {
                                console.log("new class saved successfully.");
                                $('#noDataRow').remove();
                                $('#studentTable > tbody:last-child').append('<tr><td>' + data.admissionNumber + '</td><td>' + data.firstName + ' ' + data.lastName + '</td><td>' + data.bday + '</td><td>' + data.address + '</td></tr>');

                            }
                            // $('#resultsShow').append(msg);
                        }
                    });

                }

                function getAllStudents(classId) {
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8090/api/studentMg/class/getStudents/" + classId, //this is my servlet
                        data: {},
                        crossDomain: true,
                        dataType: "json",
                        success: function (data) {
                            if (data.length < 1) {
                                $('#studentTable > tbody').append('<tr id="noDataRow"><td colspan = "4" style=" color: lightslategrey; text-align: center;">Nothing to show</td></tr>');
                            } else {
                                $('#noDataRow').remove();
                                for (var i = 0; i < data.length; i++) {
                                    $('#studentTable > tbody:last-child').append('<tr><td>' + data[i].admissionNumber + '</td><td>' + data[i].firstName + ' ' + data[i].lastName + '</td><td>' + data[i].bday + '</td><td>' + data[i].address + '</td></tr>');
                                }
                            }
                        }
                    });

                }

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
                <div class="col-md-2">
                    <h4 class="text-info">GRADE <%=currentGrade%></h4>
                    <h6 class="text-primary"> <%=currentClassData.getName().toUpperCase()%></h6>         
                </div>
                <div class="col-md-10">
                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#addAnExistingStudentModal" style="float: right; margin-left: 5px;">Add an existing student</button> 
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addStudentModal" style="float: right;">Add a new student</button> 
                </div>
            </div>
            <!--New class adding-->



            <div class="col-md-12 calssesHolder row" style="margin: auto;">


                <div class="col-md-12">
                    <input style="background-image: url('assets/images/searchIcon.png');" type="text" id="studentSearchInput" onkeyup="searchFunction({inputId: 'studentSearchInput', table: 'studentTable'})" placeholder="Search for students..">
                    <div style="height: 77%; overflow-y: auto">
                        <table id="studentTable">
                            <thead>
                                <tr class="header">
                                    <th style="width:20%;">Admission Number</th>
                                    <th style="width:30%;">Name</th>
                                    <th style="width:20%;">Birthday</th>
                                    <th style="width:30%;">Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!--                                    students of this class will be display here-->
                            </tbody>
                        </table> 
                    </div>
                </div>




            </div>

        </div>
        <!--        Navigation bar-->

        <div class="modal fade" id="addStudentModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-dark" >
                        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">Add a new student</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="gradeText">Grade </label>
                                        <input class="form-control" id="gradeText" disabled value="<%=currentGrade%>">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="className">Class Name</label>
                                        <input class="form-control" id="className" disabled value="<%=currentClassData.getName()%>" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="admissionNumberText">Admission Number</label>
                                    <input class="form-control" id="admissionNumber" type="number" name="admissionNumber" required>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="firstNameText">First Name</label>
                                    <input class="form-control" id="firstNameText" name="firstName" required>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="lastNameText">Last Name</label>
                                    <input class="form-control" id="lastNameText" name="lastName" required>
                                </div>
                            </div>



                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="addressText">Address</label>
                                    <input class="form-control" id="addressText" name="address" required>
                                </div>
                            </div>

                            <div class="form-group row"> <!-- Date input -->

                                <div class=" holder col-md-6">
                                    <label class="control-label" for="date">Birthday</label>
                                    <input class="form-control" type="date"  name="bDate" placeholder="yyyy-MM-dd" type="text" required id="studentBirthday"/>
                                </div>

                                <div class="col-md-6">
                                    <label class="control-label" for="date">Enrolled date</label>
                                    <input class="form-control" type="date"  name="eDate" placeholder="yyyy-MM-dd" type="text" required id="studentEnrolledDate"/>
                                </div>
                            </div>


                            <div class=" col-md-12" style="padding-right: 8%; padding-top: 4%;">
                                <div class="row" style="float: right;">
                                    <button type="button" class="btn bg-teal-300" style="background-color: blueviolet; color: white; margin-right: 13px;" data-dismiss="modal" id="studentAddModalCloseBtn">Close</button>
                                    <button type="button" class="btn bg-teal-300" style="background-color: orangered; color: white;" id="studentAddBtn">Save</button>
                                </div>

                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addAnExistingStudentModal"  role="dialog" aria-hidden="true" style="height: 700px;">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document" >
                <div class="modal-content">
                    <div class="modal-header bg-dark" >
                        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">Select students</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;" id="assignedModalCloseButton">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" >
                        <div style="margin-bottom: 10px; color: lightgray;">*If already assigned student is selected, the student will be automatically removed from the current class and added to this class.</div>
                        <div class="row">
                            <div class="col-md-10" id="admChipHolder">

                            </div>
                            <div class="col-md-2" style="display: flex; justify-content: center;">
                                <button class="btn btn-info"  id="assignStartButton">Assigned selected</button>
                            </div>
                        </div>
                        <input  style="background-image: url('assets/images/searchIcon.png'); margin-top: 8px;" type="text" id="assignStudentSearch" onkeyup="searchFunction({inputId: 'assignStudentSearch', table: 'assignStudentTable'})" placeholder="Search by admission number...">
                        <div style="height: 90%; overflow-y: auto">
                            <table id="assignStudentTable">
                                <thead>
                                    <tr class="header">
                                        <th style="width:20%; text-align: center;">Admission Number</th>
                                        <th style="width:40%; text-align: center;">Name</th>
                                        <th style="width:20%;">Current Class</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<StudentModel> allStudents = getAllStudents();

                                        if (allStudents != null) {
                                            for (StudentModel singleStudent : allStudents) {
                                                if (singleStudent.getCurrentClass().getId() != Integer.parseInt(currentClassId)) {

                                    %>
                                    <tr style="cursor: pointer; background-color: <%if (singleStudent.getCurrentClass().getGrade() == 0) {%>lightyellow;<%}%>" onclick="studentSelectChip(<%=singleStudent.getAdmissionNumber()%>)">

                                        <td ><%=singleStudent.getAdmissionNumber()%></td>
                                        <td><%=singleStudent.getFirstName() + " " + singleStudent.getLastName()%></td>
                                        <td><%if (singleStudent.getCurrentClass().getGrade() != 0) {%>
                                            <%=singleStudent.getCurrentClass().getGrade() + " - " + singleStudent.getCurrentClass().getName()%>
                                            <%} else {%>
                                            Not assigned<%}%>
                                        </td>
                                    </tr>                              
                                    <%}
                                        }
                                    } else {
                                    %>
                                    <tr id="noDataRow">
                                        <td colspan = "4" style=" color: lightslategrey; text-align: center;">Nothing to show</td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table> 
                        </div>



                    </div>
                </div>
            </div>
        </div>

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

            var admissionNumList = []; //maximum 10 students at once

            function removeAChip(recAdNum) {
                var index = admissionNumList.indexOf(recAdNum);
                if (index > -1) {
                    admissionNumList.splice(index, 1); //removing the id from the list
                }
                printChips();

            }
            
            function printChips(){//print all the chips
                $("#admChipHolder").html("");//clear exist chips
                for(var i=0;i<admissionNumList.length;i++){
                    $("#admChipHolder").append("<div class='chip'>" + admissionNumList[i] + "<span class='chipclosebtn' id='chipclosebtn"+admissionNumList[i]+"' onclick='removeAChip(" + admissionNumList[i] + ")'>&times;</span></div>");
                }
            }

            function studentSelectChip(recAdNum) {
                //create a chip to show the selected student id
                var index = admissionNumList.indexOf(recAdNum);

                if (admissionNumList.length < 6 && index === -1) {
                    //index is -1 ; new chip ;
                    admissionNumList.push(recAdNum);
                    printChips();
                    //onclick='this.parentElement.style.display =`none`'
                   // $("#admChipHolder").append("<div class='chip'>" + recAdNum + "<span class='chipclosebtn' id='chipclosebtn"+recAdNum+"' onclick='removeAChip(" + recAdNum + ")'>&times;</span></div>");
                } else {
                    console.log("exist chip");
                }
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
