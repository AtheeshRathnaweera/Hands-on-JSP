<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lk.studentsmanage.models.StudentModel"%>
<%@page import="lk.studentsmanage.models.ClassModel"%>
<%@include file="controller/StudentController.jsp" %>
<%@include file="controller/TeacherController.jsp" %>
<%@include file="controller/ClassController.jsp" %>

<html>
    <head>
        <title>Students Section</title>
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

            /*             Small devices (landscape phones, 576px and up)*/
            @media (min-width: 576px) { 
                img.cardAvatar {
                    width: 100%;
                }
            }

            /*             Medium devices (tablets, 768px and up)*/
            @media (min-width: 768px) { 
                img.cardAvatar {
                    width: 10%;
                }
            }

            /*            Large devices (desktops, 992px and up)*/
            @media (min-width: 992px) { 
                img.cardAvatar {
                    width: 10%;
                }
            }

            /*            Extra large devices (large desktops, 1200px and up)*/
            @media (min-width: 1200px) { 
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
                bottom: 0px;
                left: 0px;

            }

            .cardLink,
            .cardLink:hover{
                color: inherit;
                text-decoration: none;
                cursor: pointer;

            }




            /* The snackbar - position it at the bottom and in the middle of the screen */
            #snackbar {
                visibility: hidden; /* Hidden by default. Visible on click */
                min-width: 250px; /* Set a default minimum width */
                margin-left: -125px; /* Divide value of min-width by 2 */
                background-color: grey; /* Black background color */
                color: #fff; /* White text color */
                text-align: center; /* Centered text */
                border-radius: 2px; /* Rounded borders */
                padding: 16px; /* Padding */
                position: fixed; /* Sit on top of the screen */
                z-index: 1; /* Add a z-index if needed */
                left: 90%; /* Center the snackbar */
                bottom: 50px; /* 30px from the bottom */
            }

            /* Show the snackbar when clicking on a button (class added with JavaScript) */
            #snackbar.show {
                visibility: visible; /* Show the snackbar */
                /* Add animation: Take 0.5 seconds to fade in and out the snackbar.
                However, delay the fade out process for 2.5 seconds */
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            /* Animations to fade the snackbar in and out */
            @-webkit-keyframes fadein {
                from {bottom: 0; opacity: 0;}
                to {bottom: 30px; opacity: 1;}
            }

            @keyframes fadein {
                from {bottom: 0; opacity: 0;}
                to {bottom: 30px; opacity: 1;}
            }

            @-webkit-keyframes fadeout {
                from {bottom: 30px; opacity: 1;}
                to {bottom: 0; opacity: 0;}
            }

            @keyframes fadeout {
                from {bottom: 30px; opacity: 1;}
                to {bottom: 0; opacity: 0;}
            } 




        </style>



    </head>

    <%        String role = (String) "" + session.getAttribute("userRole");
        String userId = (String) "" + session.getAttribute("userId");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MMM-dd");

        String grade = "" + request.getParameter("grade");
        String studentClass = "" + request.getParameter("class");
        String studentClassName = "" + request.getParameter("name");

        System.out.println("grade : " + grade);

        ArrayList al = new ArrayList();
        al.add("Olu");
        al.add("Nelum");

        ArrayList als = new ArrayList();
        als.add(al);

        if (role.equals("null") && role.equals("null")) {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        } else {
            System.out.println("Home page : role or userId found");
        }

        StudentModel currentStudentData = null;
        TeacherModel currentTeacherData = null;

        if (role.equals("student")) {
            currentStudentData = getStudentDetails(userId);
            System.out.println("received student : " + currentStudentData.toString());

        } else {
            currentTeacherData = getTeacherDetails(userId);
            System.out.println("received teacher :" + currentTeacherData.toString());
        }

        String saveStatus = (String) session.getAttribute("save_status");

        if (saveStatus.equals("1")) {
            System.out.println("save signal received : student details.");
        } else {
            System.out.println("no save signal received : student details.");
        }
    %>





    <body>

        <!--        Navigation bar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <!--            <a class="navbar-brand" href="#">PRESIDENT S COLLEGE</a>-->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item ">
                        <a class="nav-link" href="homePage.jsp">Home </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="studentDetails.jsp">Students Section <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="teacherDetails.jsp">Teachers Section</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                </ul>
            </div>

            <div class = "dropdown" style="color: white;">
                <a style="color:white;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-fw fa-user" style="font-size: 23px; color: white;"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item"  data-toggle="modal" data-target="#userProfileView">View profile</a>
                    <a class="dropdown-item" href="#">Another action</a>
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

                        <%if (role.equals("student")) {%>
                        <!--                        Student user details -->
                        <form>
                            <div class="form-group row">
                                <div class="enrolledDateClass col-md-6">
                                    <label for="studentUserName">User Name</label>
                                    <input class="form-control" id="studentUserName" disabled value="<%=currentStudentData.getAdmissionNumber()%>">
                                </div>

                                <div class="enrolledDateClass col-md-6">
                                    <label for="studentEnrolledDate">Enrolled Date</label>
                                    <input class="form-control" id="studentEnrolledDate" disabled value="<%=dateFormatter.format(currentStudentData.getEnrolledDate())%>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="studentFirstName">First Name</label>
                                <input class="form-control" id="studentFirstName" disabled value="<%=currentStudentData.getFirstName()%>">
                            </div>

                            <div class="form-group">
                                <label for="studentLastName">Last Name</label>
                                <input class="form-control" id="studentLastName" disabled value="<%=currentStudentData.getLastName()%>">
                            </div>

                            <div class="form-group row">
                                <div class="bdayClass col-md-6">
                                    <label for="studentBirthday">Birthday</label>
                                    <input class="form-control" id="studentBirthday" disabled value="<%=dateFormatter.format(currentStudentData.getBday())%>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="studentAddress">Address</label>
                                <textarea class="form-control" id="studentAddress" disabled style="resize: none;"><%=currentStudentData.getAddress()%></textarea>
                            </div>

                        </form>
                        <!--                        Student user details -->
                        <%} else if (role.equals("teacher")) {%>
                        <!--                        Teacher profile modal-->
                        <form>
                            <div class="form-group row">
                                <div class="enrolledDateClass col-md-12">
                                    <label for="teacherUserName">User Name</label>
                                    <input class="form-control" id="teacherUserName" disabled value="<%=currentTeacherData.getNic()%>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="teacherFirstName">First Name</label>
                                <input class="form-control" id="teacherFirstName" disabled value="<%=currentTeacherData.getFirstName()%>">
                            </div>

                            <div class="form-group">
                                <label for="teacherLastName">Last Name</label>
                                <input class="form-control" id="teacherLastName" disabled value="<%=currentTeacherData.getLastName()%>">
                            </div>

                            <div class="form-group row">
                                <div class="bdayClass col-md-6">
                                    <label for="teacherTel">Contact Number</label>
                                    <input class="form-control" id="teacherTel" disabled value="<%=currentTeacherData.getTelephoneNumber()%>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="teacherAddress">Address</label>
                                <textarea class="form-control" id="teacherAddress" disabled style="resize: none;"><%=currentTeacherData.getAddress()%></textarea>
                            </div>



                        </form>
                        <!--                        Teacher profile modal-->
                        <%}%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- User profile Modal -->





        <!--        Page content-->
        <div class="page-content" >

            <!-- The actual snackbar -->
            <div id="snackbar">Saved Successfully!</div> 


            <%if (request.getParameter("grade") == null && request.getParameter("class") == null) {%>

            <div class="gradesGrid">
                <!--                First row of grades-->
                <div class="row" style="padding-left: 2%; padding-right: 2%; padding-top: 2%; text-align: center;" >
                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=1" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>1</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 01<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=2" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>2</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 02<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=3" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>3</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 03<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=4" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>4</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 04<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=5" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>5</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 05<p>
                                </div>

                            </div>
                        </a>

                    </div>

                </div>
                <!--                First row of grades-->


                <!--                Second row of grades-->
                <div class="row" style="padding-left: 2%; padding-right: 2%; padding-top: 2%; text-align: center;" >
                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=6" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>6</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 06<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=7" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>7</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 07<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=8" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>8</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 08<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=9" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>9</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 09<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=10" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>10</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 10<p>
                                </div>

                            </div>
                        </a>

                    </div>

                </div>
                <!--                Second row of grades-->

                <!--Third row of grades-->
                <div class="row" style="padding-left: 2%; padding-right: 2%; padding-top: 2%; text-align: center;" >
                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=11" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>11</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 11<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=12" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>12</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 12<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="card col-md-2" style="margin: auto;">
                        <a href="studentDetails.jsp?grade=13" class="cardLink">
                            <div class="row" style="height: 6vw;">
                                <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                    <p class="gradeNumber" style="font-size: 25px; margin: auto;"><strong>13</strong></p>
                                </div>

                                <div class="numberHolder col-md-9" style="  display: flex; text-align: center;">
                                    <p class="gradeText" style="font-size: 25px; margin: auto; ">Grade 13<p>
                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="col-md-2" style="margin: auto;">
                    </div>

                    <div class="col-md-2" style="margin: auto;">
                    </div>

                </div>
                <!--Third row of grades-->
            </div>

            <%} else if (request.getParameter("grade") != null && request.getParameter("class") == null) {%>


            <div class="classesGrid">
                <div class="gradeTitle col-md-9" style="margin:auto; margin-top: 2%; margin-bottom: 1%;">

                    <span class="badge badge-pill badge-info" style="font-size: 1.7vw;"><%="Grade " + grade%></span>

                    <button type="button" class="btn btn-warning" style="float: right; color: white;"  data-toggle="modal" data-target="#addClassModal">Add a Class</button>


                </div>

                <div class="modal fade" id="addClassModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-dark" >
                                <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">Add a new class</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">

                                <form>
                                    <div class="form-group row">
                                        <div class="enrolledDateClass col-md-6">
                                            <label for="gradeText">Grade </label>
                                            <input class="form-control" id="gradeText" disabled value="<%=grade%>">
                                        </div>

                                        <div class="enrolledDateClass col-md-6">
                                            <label for="className">Class Name</label>
                                            <input class="form-control" id="className" name="className">
                                        </div>
                                    </div>



                                    <input type="hidden" name="action" value="addAClass">
                                    <input type="hidden" name="classGrade" value="<%=grade%>">

                                    <div class=" col-md-12" style="padding-right: 8%; padding-top: 4%;">
                                        <div class="row" style="float: right;">
                                            <button type="button" class="btn bg-teal-300" style="background-color: blueviolet; color: white; margin-right: 13px;" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn bg-teal-300" style="background-color: orangered; color: white;">Save</button>
                                        </div>

                                    </div>

                                </form>


                            </div>


                        </div>


                    </div>

                </div>

                <%
                    List<ClassModel> recClasses = getAllClassesByGrade(Integer.parseInt(grade));

                    for (ClassModel c : recClasses) {

                        String classTeacherName = "Not Found";

                        TeacherModel recData = getClassTeacher(c.getId());

                        if (recData.getFirstName() != null) {
                            if (recData.getGender().equals("M")) {
                                classTeacherName = "Mr. " + recData.getFirstName() + " " + recData.getLastName();
                            } else {
                                classTeacherName = "Mrs. " + recData.getFirstName() + " " + recData.getLastName();
                            }

                        }


                %>

                <div class="card col-md-9" style="margin-top: 1%; margin-bottom: 1%; margin-left: auto; margin-right: auto;">
                    <a href="studentDetails.jsp?grade=<%=grade%>&class=<%=c.getId()%>&name=<%=c.getName()%>" class="cardLink">
                        <div class="row">
                            <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center; padding: 1%;">
                                <p class="gradeNumber" style="font-size: 1.7vw; margin: auto;"><strong><%=c.getName()%></strong></p>
                            </div>

                            <div class="numberHolder col-md-9 row" style="display: flex; padding-left: 3%;">

                                <p class="teacherName" style="font-size: 1.6vw; margin-right: auto; margin-top: auto;  margin-bottom: auto;"><%=classTeacherName%><p>

                                <p class="gradeText" style="font-size: 1.7vw; margin-left: auto;margin-top: auto; margin-bottom: auto; "><span class="badge badge-pill badge-dark"><%="67"%></span><p>
                            </div>



                        </div>
                    </a>

                </div>

                <%}%>







            </div>


            <% } else if (request.getParameter("grade") != null && request.getParameter("class") != null) {

            %>

            <div class="studentsDetailsGrid">
                <div class="classTitle col-md-7" style="margin-left:5%; margin-top: 2%; margin-bottom: 1%;">

                    <span class="badge badge-info" style="font-size: 2vw;"><%=grade + " - " + studentClassName%></span>
                    <button type="button" class="btn btn-warning" style="float: right; color: white;" data-toggle="modal" data-target="#addStudentModal">Add a student</button>

                </div>

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
                                                <input class="form-control" id="gradeText" disabled value="<%=grade%>">
                                            </div>

                                            <div class="col-md-6">
                                                <label for="className">Class Name</label>
                                                <input class="form-control" id="className" disabled value="<%=studentClassName%>" required>
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
                                            <input class="form-control" type="date"  name="bDate" placeholder="yyyy-MM-dd" type="text" required/>
                                        </div>

                                        <div class="col-md-6">
                                            <label class="control-label" for="date">Enrolled date</label>
                                            <input class="form-control" type="date"  name="eDate" placeholder="yyyy-MM-dd" type="text" required/>
                                        </div>
                                    </div>

                                    <input type="hidden" name="action" value="addAStudent">
                                    <input type="hidden" name="classGrade" value="<%=grade%>">
                                    <input type="hidden" name="classId" value="<%=studentClass%>">
                                    <input type="hidden" name="className" value="<%=studentClassName%>">

                                    <div class=" col-md-12" style="padding-right: 8%; padding-top: 4%;">
                                        <div class="row" style="float: right;">
                                            <button type="button" class="btn bg-teal-300" style="background-color: blueviolet; color: white; margin-right: 13px;" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn bg-teal-300" style="background-color: orangered; color: white;">Save</button>
                                        </div>

                                    </div>

                                </form>


                            </div>


                        </div>


                    </div>

                </div>

                <div class="row">
                    <div class="studentsHolder col-md-7">
                        <%
                            List<StudentModel> recStudents = getAllStudentsOfAClass(Integer.parseInt(studentClass));
                            System.out.println("rec amount students : " + recStudents.size());

                            for (StudentModel s : recStudents) {


                        %>

                        <div class="card col-md-12" style="margin-top: 0.5%; margin-bottom: 0.5%; margin-left: 5%;">
                            <a class="cardLink" data-toggle="modal" data-target="#viewStudentModal_<%=s.getAdmissionNumber()%>"> 
                                <div class="row">
                                    <div class="numberHolder col-md-3" style="display: flex; background-color: green; color: white; text-align: center;">
                                        <p class="gradeNumber" style="font-size: 1.4vw; margin: auto;"><strong><%=s.getAdmissionNumber()%></strong></p>
                                    </div>

                                    <div class="numberHolder col-md-9" style="  display: flex;">
                                        <p class="gradeText" style="font-size: 1.4vw; margin-top: auto; margin-bottom: auto;"><%=s.getFirstName() + " " + s.getLastName()%><p>
                                    </div>

                                </div>
                            </a>

                        </div>


                        <div class="modal fade" id="viewStudentModal_<%=s.getAdmissionNumber()%>" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header bg-dark" >
                                        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white;">Student Details</h5>
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
                                                        <input class="form-control" id="gradeText" disabled value="<%=grade%>">
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label for="className">Class Name</label>
                                                        <input class="form-control" id="className" disabled value="<%=studentClassName%>">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <div class="col-md-12">
                                                    <label for="admissionNumberText">Admission Number</label>
                                                    <input class="form-control" id="admissionNumber" type="number" value="<%=s.getAdmissionNumber()%>" disabled>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <div class="col-md-12">
                                                    <label for="firstNameText">First Name</label>
                                                    <input class="form-control" id="firstNameText" value="<%=s.getFirstName()%>" disabled>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <div class="col-md-12">
                                                    <label for="lastNameText">Last Name</label>
                                                    <input class="form-control" id="lastNameText" value="<%=s.getLastName()%>" disabled>
                                                </div>
                                            </div>



                                            <div class="form-group row">
                                                <div class="col-md-12">
                                                    <label for="addressText">Address</label>
                                                    <input class="form-control" id="addressText" value="<%=s.getAddress()%>" disabled>
                                                </div>
                                            </div>

                                            <div class="form-group row"> <!-- Date input -->

                                                <div class=" holder col-md-6">
                                                    <label class="control-label" for="date">Birthday</label>
                                                    <input class="form-control" type="date" value="<%=s.getBday()%>" disabled/>
                                                </div>

                                                <div class="col-md-6">
                                                    <label class="control-label" for="date">Enrolled date</label>
                                                    <input class="form-control" type="date"  value="<%=s.getEnrolledDate()%>" disabled/>
                                                </div>
                                            </div>


                                            <div class=" col-md-12" style=" padding-top: 2%;">
                                                <div class="row" style="float: right;">
                                                    <button type="button" class="btn bg-teal-300" style="background-color: blueviolet; color: white;" data-dismiss="modal">Close</button>
                                                </div>

                                            </div>

                                        </form>


                                    </div>


                                </div>


                            </div>

                        </div>



                        <%}%>

                    </div>

                    <%
                        TeacherModel currentClassTeacher = getClassTeacher(Integer.parseInt(request.getParameter("class")));


                    %>

                    <div class="teacherHolder col-md-5" >
                        <div class="card  col-md-9" style="margin: auto;">
                            <div class="form-group row" style="margin-top: 5%;">
                                <div class="col-md-12">
                                    <h4 for="nicText"><strong>Class Teacher Details</strong></h4>
                                </div>
                            </div>

                            <% if (currentClassTeacher.getNic() != null) {%>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="nicText">NIC</label>
                                    <input class="form-control" id="nicText" value="<%=currentClassTeacher.getNic()%>" disabled>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="firstNameText">First Name</label>
                                    <input class="form-control" id="firstNameText" value="<%=currentClassTeacher.getFirstName()%>" disabled>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="lastNameText">Last Name</label>
                                    <input class="form-control" id="lastNameText" value="<%=currentClassTeacher.getLastName()%>" disabled>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="addressText">Address</label>
                                    <input class="form-control" id="addressText" value="<%=currentClassTeacher.getAddress()%>" disabled>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="telText">Telephone Number</label>
                                    <input class="form-control" id="telText" value="<%=currentClassTeacher.getTelephoneNumber()%>" disabled>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-6">
                                    <label for="statusText">Status</label>
                                    <input class="form-control" id="statusText" value="<%=currentClassTeacher.getStatus()%>" disabled>
                                </div>

                                <div class="col-md-6">
                                    <label for="statusText">Gender</label>
                                    <input class="form-control" id="statusText" value="<%=currentClassTeacher.getGender()%>" disabled>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <button type="button" class="btn bg-teal-300" style="background-color: blueviolet; color: white; margin: auto;">Update class teacher</button>
                                    </div>

                                </div>
                            </div>

                            <%} else {%>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <p>Class Teacher Not Found.</p>

                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <button type="button" class="btn bg-teal-300" style="background-color: blueviolet; color: white; margin: auto;">Configure class teacher</button>
                                    </div>

                                </div>
                            </div>

                            <%}%>




                        </div>


                    </div>

                </div>





            </div>

            <%}%>







        </div>
        <!--        Navigation bar-->


        <footer class="container-fluid text-center">
            <p>Footer Text</p>
        </footer>


        <script>

            var session_obj = '<%=saveStatus%>';
            console.log("status : " + session_obj);

            if (session_obj === "1") {

                var x = document.getElementById("snackbar");
                x.className = "show";

                setTimeout(function () {
                    x.className = x.className.replace("show", "");
                }, 3000);

                //change the session attribute

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







        </script>

    </body>
</html>
