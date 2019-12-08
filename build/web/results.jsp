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

            #classesTable {
                border-collapse: collapse; /* Collapse borders */
                width: 100%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 14px; /* Increase font-size */
            }

            #classesTable th, #classesTable td {
                text-align: left; /* Left-align text */
                padding: 12px; /* Add padding */
            }

            #classesTable tr{
                /* Add a bottom border to all table rows */
                border-bottom: 0.5px solid #ddd;
                background-color: white;
            }

            #classesTable tr:hover{
                background-color: lightgrey;
            }

            #classesTable tr.header{
                /* Add a grey background color to the table header and on hover */
                background-color: #f1f1f1;
            }

            #resultsTable{
                border: 1px;
                width: 100%; /* Full-width */
                border: 1px solid #ddd; /* Add a grey border */
                font-size: 14px; /* Increase font-size */
            }

            #resultsTable tr{
                border-bottom:1px solid #ddd;
            }

            #resultsTable th, #resultsTable td{
                border: 1px solid #ddd;
                text-align: left; /* Left-align text */
                padding: 10px; /* Add padding */


            }




        </style>





    </head>

    <%        UserModel userData = (UserModel) session.getAttribute("userData");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MMM-dd");
        String status = "" + request.getParameter("status");

        String admisssionNumber = "" + request.getParameter("admissionNumber");

        System.out.println("status = " + status);

        if (userData == null || userData.getUserRole().equals("admin") || admisssionNumber == "") {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        }

        StudentModel studentDetails = getStudentDetails(admisssionNumber);
        List<StudentHistory> studentHistory = getStudentHistory(admisssionNumber);
        
        System.out.println("history amount : "+studentHistory.size());

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




                function displayNotification() {
                    $("#notificationHolder").css("display", "block");
                    $(".failedAlert").hide().fadeIn(400).delay(1700).fadeOut(800, function () {
                        $(".failedAlert").fadeOut(1000, 500);
                        $("#notificationHolder").css("display", "none");
                    });
                }

            });



        </script>

        <div class="notification" id="notificationHolder" style="display: none;">
            <div class="col-sm-3 failedAlert card m-2" style="float: right; background-color: green;"> 
                <div class="card-body">
                    <p style="color: white; font-size: 1.2em; margin: auto;">SignIn failed !</p> 
                </div>
            </div>
        </div>

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


            <!--        Student details-->
            <div class="col-md-12 newClassAddHolder row" style="padding: 1%;">
                <div class="col-md-12 col-sm-12">
                    <h4>Name : <span style="font-style: italic; color: lightslategray;"><%=studentDetails.getFirstName() + " " + studentDetails.getLastName()%></span></h4>
                    <h6>Admission Number : <span style="font-style: italic; color: lightslategray;"><%=studentDetails.getAdmissionNumber()%></span></h6>
                </div>
            </div>
            <!--        Student details-->



            <div class="col-md-12 row" style="margin: auto;">
                <div class="col-md-7">
                    <table id="classesTable">
                        <thead>
                            <tr class="header">
                                <th style="width:10%;">Year</th>
                                <th style="width:10%;">Grade</th>
                                <th style="width:10%;">Class</th>
                                <th style="width:20%; text-align: center;" colspan = "3">Results <%=studentHistory.size()%></th>

                            </tr>
                        </thead>
                        <tbody>
                            <% if (studentHistory.size() > 0) {
                                    for (StudentHistory st : studentHistory) {
                                        
                            %>
                            <tr style="cursor: pointer;" onclick="showOnResultsTable({id: '<%=st.getId()%>', year: '<%=st.getYear()%>', class: '<%=st.getClassId().getGrade() + " - " + st.getClassId().getName()%>', subjects: '<%=st.getSubjects()%>', firstTerm: '<%=st.getFirstTermResults()%>', secondTerm: '<%=st.getSecondTermResults()%>', thirdTerm: '<%=st.getThirdTermResults()%>'})">
                                <td><%=st.getYear()%></td>
                                <td><%=st.getClassId().getGrade()%></td>
                                <td><%=st.getClassId().getName()%></td>
                                <td>1 st term</td>
                                <td>2 nd term</td>
                                <td>3 rd term</td>
                            </tr>
                            <%}
                            } else {%>
                            <tr id="noDataRow">
                                <td colspan = "4" style=" color: lightslategrey; text-align: center;">Nothing to show</td>
                            </tr>
                            <%}%>

                        </tbody>
                    </table> 
                </div>

                <div class="col-md-5">
                    <div class="card" style="padding: 2%;">
                        <div class="col-md-12" style="text-align: center;"><h5 >Term Test Results</h5></div>
                        <div class="col-md-12" style="text-align: center;"><h5 id="resultsYearDisplay">gf</h5></div>
                        <div class="col-md-12" style="text-align: center;"><h6 id="resultSubTitle" style="color: lightskyblue;"></h6></div>
                        <table id="resultsTable">
                            <thead >
                                <tr class="header">
                                    <th style="text-align: center;">Subject</th>
                                    <th style="text-align: center;">Term 01</th>
                                    <th style="text-align: center;">Term 02</th>
                                    <th style="text-align: center;">Term 03</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>

                        </table>
                        <div class="col-md-12 row" style="margin-top: 3%;">
                            <input hidden id="historyIdHolder">
                            <button class=" btn btn-info" style="float: right; margin-right: 2%;" id="addNewRowBtn">Add a row</button>
                            <button class=" btn btn-info" style="float: right;" id="resultsTableSaveBtn">Save</button>
                        </div>
                    </div>
                </div>



            </div>


        </div>
        <!--        Navigation bar-->


        <footer class="container-fluid text-center">
            <p>Footer Text</p>
        </footer>




        <script type="text/javascript">



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

            function showOnResultsTable(args) {
                console.log("new row add function started " + args.subjects + "  " + args.firstTerm + " " + args.secondTerm + " " + args.thirdTerm+" "+args.year);

                $("#resultSubTitle").text(args.class);
                $("#historyIdHolder").val(args.id);
                $("#resultsYearDisplay").text(args.year);

                var subjectsArray = null;
                var firstTerm = null;
                var secondTerm = null;
                var thirdTerm = null;

                try {
                    subjectsArray = args.subjects.split(",");
                    firstTerm = args.firstTerm.split(",");
                    secondTerm = args.secondTerm.split(",");
                    thirdTerm = args.thirdTerm.split(",");

                } catch (exception) {
                    console.log("exception in string to array converter");
                }

                console.log(subjectsArray.length + "  " + firstTerm.length + " " + secondTerm.length + " " + thirdTerm.length);

                if (subjectsArray !== null) {
                    console.log("subject array is not null");
                    $("#resultsTable > tbody").empty();
                    for (var i = 0; i < subjectsArray.length; i++) {
                        var rowData = '<tr id="resultsRow' + i + '"><td><input value="' + subjectsArray[i] + '" style="border:none;" name="subject"></td><td style="text-align: center;"><input class="form-control" type="text" style="border:none" value="' + firstTerm[i] + '" name="firstMark"></td>\n\
                                    <td style="text-align: center;"><input class="form-control" type="text" style="border:none" value="' + secondTerm[i] + '" name="secondMark"></td>\n\
                                    <td style="text-align: center;"><input class="form-control" type="text" style="border:none" value="' + thirdTerm[i] + '" name="thirdMark"></td>\n\
                                <td><a onclick="deleteARow(`resultsRow' + i + '`)" href="javascript:void(0);" style="color:inherit; "><i class="fa fa-trash" style="color:red"></a></td></tr>';
                        $('#resultsTable > tbody:last-child').append(rowData);
                    }

                } else {
                    var rowNoData = '<tr><td colspan=5>Nothing to show</td></tr>';
                    $('#resultsTable > tbody:last-child').append(rowNoData);
                }
            }

            function addANewRow() {
                var rowCount = $('#resultsTable tr').length;
                console.log("row : " + rowCount + " ");

                var rowData = '<tr id="resultsRow' + (rowCount) + '"><td><input style="border:none;" name="subject"></td><td style="text-align: center;"><input class="form-control" type="text" style="border:none" name="firstMark"></td>\n\
                                    <td style="text-align: center;"><input class="form-control" type="text" style="border:none" name="secondMark"></td>\n\
                                    <td style="text-align: center;"><input class="form-control" type="text" style="border:none" name="thirdMark"></td>\n\
                                <td><a onclick="deleteARow(`resultsRow' + (rowCount) + '`)" href="javascript:void(0);" style="color:inherit; "><i class="fa fa-trash" style="color:red"></a></td></tr>';

                $('#resultsTable > tbody:last-child').append(rowData);
            }


            $("#addNewRowBtn").click(function () {
                console.log("add a new row");
                addANewRow();
            });

            function getTableData() {

                var subjects = [];
                var firstTermMarks = [];
                var secondTermMarks = [];
                var thirdTermMarks = [];

                $('#resultsTable tr').map(function () {//The map() method calls the provided function once for each element in an array, in order.
                    var currentSubject = "first";
                    $(this).find('td').map(function (x) {

                        var namesOfInputs = ["subject", "firstMark", "secondMark", "thirdMark"];
                        var arrayNames = [subjects, firstTermMarks, secondTermMarks, thirdTermMarks];

                        for (var i = 0; i < namesOfInputs.length; i++) {
                            $(this).find('input[name="' + namesOfInputs[i] + '"]').map(function () {
                                if (namesOfInputs[i] === "subject") {
                                    if ($(this).val() !== "") {
                                        arrayNames[i].push($(this).val());
                                    }
                                    currentSubject = $(this).val();
                                } else {
                                    if (currentSubject !== "") {
                                        arrayNames[i].push($(this).val());
                                    }
                                }

                            });
                        }

                    });
                });

                console.log("subjects : size " + subjects.length + " array :" + subjects.toString());
                console.log("first term : size " + firstTermMarks.length + " array : " + firstTermMarks.toString());
                console.log("second term : size " + secondTermMarks.length + " array : " + secondTermMarks.toString());
                console.log("third term : size " + thirdTermMarks.length + " array :" + thirdTermMarks.toString());
                var historyId = $("#historyIdHolder").val();

                saveTheResults(historyId, subjects.toString(), firstTermMarks.toString(), secondTermMarks.toString(), thirdTermMarks.toString());

            }

            $("#resultsTableSaveBtn").click(function () {
                console.log("results save btn done.");
                getTableData();
            });

            function deleteARow(rowId) {
                console.log("delete a row method. " + rowId);
                $("#" + rowId).remove();
            }


            function saveTheResults(id, subjects, firstTermTestResults, secondTermTestResults, thirdTermTestResults) {
                console.log("save the results started.");
                var ty = "oooooo";
                var dataObject = {
                    id: id,
                    admissionNumber: "",
                    year: "",
                    classId: "",
                    subjects: subjects,
                    firstTermResults: firstTermTestResults,
                    secondTermResults: secondTermTestResults,
                    thirdTermResults: thirdTermTestResults
                };
                
                console.log(ty+"save object : "+JSON.stringify(dataObject));

                $.ajax({
                    type: "put",
                    contentType: 'application/json; charset=utf-8',
                    url: "http://localhost:8090/api/studentMg/student/updateResults",
                    data: JSON.stringify(dataObject),
                    crossDomain: true,
                    dataType: "json",
                    success: function (data) {
                        console.log("received : " + data);
                        if (data === null) {
                            console.log("history save failed.");
                        } else {
                            console.log("history saved successfully." + data);
                            window.location.reload();
                        }
                    }
                });
            }








        </script>

    </body>
</html>
