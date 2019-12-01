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
        String currentClassId = ""+request.getParameter("classid");

        System.out.println("status = " + status);

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
                window.history.replaceState(null, null, window.location.pathname + "?grade=" +<%=currentGrade%>+"&classid="+<%=currentClassId%>);
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
                    
                </div>
                <div class="col-md-10">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addClassModal" style="float: right;">Add a student</button> 
                </div>
            </div>
            <!--New class adding-->



            <div class="col-md-12 calssesHolder row" style="margin: auto;">
                <% for (ClassModel singleClass : classesList) {%>




                <%}%>


            </div>

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

                        <form action="controller/ClassController.jsp">
                            <div class="form-group row">
                                <div class="enrolledDateClass col-md-6">
                                    <label for="gradeText">Grade </label>
                                    <input class="form-control" id="gradeText" disabled value="<%=currentGrade%>">
                                </div>

                                <div class="enrolledDateClass col-md-6">
                                    <label for="className">Class Name</label>
                                    <input class="form-control" id="className" name="className">
                                </div>
                            </div>



                            <input type="hidden" name="action" value="addAClass">
                            <input type="hidden" name="classGrade" value="<%=currentGrade%>">

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
