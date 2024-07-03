<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 12/22/2020
  Time: 6:47 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DREAVERs</title>
    <link rel="stylesheet" href="css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<%@include file="header.jsp"%>
<!-- #home -->

<section id="registration" class="section">
    <div class="container tagline">
        <em>Register User</em><br/>
        <em>{0}</em>
        <form action="RegisterUser" method="post">
            <%=(request.getAttribute("errorMessage") == null) ? ""
                    : request.getAttribute("errorMessage")%>
            <br />
            <label>Username</label> <input type="text" name="username" id="username"><br/>
            <label>Password</label> <input type="password" name="password" id="password"><br/>
            <label>First Name</label> <input type="text" name="fname" id="fname"><br/>
            <label>Last Name</label> <input type="text" name="lname" id="lname"><br/>
            <label>What do you want to do? </label>
            <input type="radio" name="activity" id="activity" value="Playing a sport">Play a Sport?
            <input type="radio" name="activity" id="activiti" value="Exercise in Gym">Hit the Gym?<br/>
            <input type="submit" value="Submit" id="submit">
        </form>
    </div>
</section>
<!-- #products -->



<!-- footer -->
<%@include file="footer.jsp"%>



</body>
</html>