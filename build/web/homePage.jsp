<%@page import="lk.studentsmanage.models.UserModel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lk.studentsmanage.models.StudentModel"%>
<%@include file="controller/StudentController.jsp" %>
<%@include file="controller/TeacherController.jsp" %>

<html>
    <head>
        <title>Home</title>
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




        </style>



    </head>

    <%
        UserModel userData= (UserModel) session.getAttribute("userData");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat typeDate = new SimpleDateFormat("yyyy-MM-dd");
        
        String role = "";
        String userId = "";

        if (userData.getUserRole() == null) {
            System.out.println("Home page : role or userId is null ");
            response.sendRedirect("index.jsp");
            return;
        } else {
            System.out.println("Home page : role or userId found");
            role = userData.getUserRole();
            userId = userData.getUserId();
        }

        StudentModel currentStudentData = null;
        TeacherModel currentTeacherData = null;    

        if (role.equals("student")) {
            currentStudentData = getStudentDetails(userId);
            System.out.println("received student : " + currentStudentData.toString());

        } else if(role.equals("teacher")){
            currentTeacherData = getTeacherDetails(userId);
            System.out.println("received teacher :" + currentTeacherData.toString());
        }

        Long studentCount = getStudentsCount();
        Long teachersCount = getTeachersCount();

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
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="studentDetails.jsp">Students Section</a>
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
                                    <input class="form-control" id="studentEnrolledDate" disabled value="<%=dateFormatter.format(dateFormatter.parse(currentStudentData.getEnrolledDate()))%>">
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
                                    <input class="form-control" id="studentBirthday" disabled value="<%=dateFormatter.format(dateFormatter.parse(currentStudentData.getBday()))%>">
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
        <div class="page-content">

            <div class="stats-cards" style="padding-left: 1%; padding-right: 1%;">
                <div class="row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">
                        <a href="" style="color: inherit;">
                            <div class="card "style=" height: 100%;">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-xs-4 col-md-4 col-sm-4 col-lg-4  ">
                                            <img class="cardAvatar" src="assets/images/reading.png" alt="Student Avatar" style="height: auto; "> 
                                        </div>

                                        <div class="col-xs-8 col-md-8 col-sm-8 col-lg-8">
                                            <h4 style="font-size:1.1vw;">Students</h4>
                                            <h3 style="font-size:3.5vw;"><%=studentCount%></h3>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </a>

                    </div>

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">
                        <a href="" style="color: inherit;">
                            <div class="card" style=" height: 100%;">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-xs-4 col-sm-4 col-lg-4">
                                            <img class="cardAvatar" src="assets/images/teacher.png" alt="Teacher Avatar" style="height: auto; "> 
                                        </div>

                                        <div class="col-xs-8 col-sm-8 col-lg-8">
                                            <h4 style="font-size:1.1vw;">Teachers</h4>
                                            <h3 style="font-size:3.5vw;"><%=teachersCount%></h3>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </a>

                    </div>

                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="padding:1%;">
                        <a href="" style="color: inherit;">
                            <div class="card" style=" height: 100%;">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-xs-4 col-sm-4 col-lg-4">
                                            <img class="cardAvatar" src="assets/images/family.png" alt="Family Avatar" style="height: auto; "> 
                                        </div>

                                        <div class="col-xs-8 col-sm-8 col-lg-8">
                                            <h4 style="font-size:1.1vw;">Parents</h4>
                                            <h3 style="font-size:3.5vw;">1290</h3>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </a>

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

            <div class="events_schedule card" style="margin-left: 1%; margin-right: 1%;">
                <div class="title_holder" style="padding: 1%; background-color: darkgrey;">
                    <h4 style="color: white; "><b>Events Schedule</b></h4>
                    <h6 style="color: white; font-style: oblique ">November</h6>
                </div>

                <div class="event_list">

                    <div class="event card " style="margin: 0.5%;">
                        <div class="row">
                            <div class="date col-md-1">

                                <div style="background-color: darkcyan; color: white; text-align: center; padding: 1%;">
                                    <p style="margin: auto;">November</p>
                                </div>

                                <div style="text-align: center; padding: 3%; background-color: whitesmoke;">
                                    <h3>23</h3>
                                </div>

                            </div>
                            <div class="col-md-11">
                                Event description
                            </div>
                        </div>
                    </div>

                    <div class="event card" style="margin: 0.5%;">
                        <div class="row">
                            <div class="date col-md-1">

                                <div style="background-color: darkcyan; color: white; text-align: center; padding: 1%;">
                                    <p style="margin: auto;">November</p>
                                </div>

                                <div class="" style="text-align: center; padding: 3%; background-color: whitesmoke;">
                                    <h3>24</h3>
                                </div>

                            </div>
                            <div class="col-md-5">
                                Event description
                            </div>
                        </div>
                    </div>

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





        </script>

    </body>
</html>
