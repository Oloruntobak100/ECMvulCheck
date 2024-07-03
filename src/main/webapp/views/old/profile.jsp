<%--
  Created by IntelliJ IDEA.
  User: M13
  Date: 13/10/2020
  Time: 09:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<header id="home" class="header">
    <nav class="nav" role="navigation">
        <div class="container nav-elements">
            <div class="branding">
                <a href="#home"><img src="images/hpluslogo.svg"
                                     alt="Logo - H Plus Sports"></a>
            </div>
            <!-- branding -->
            <ul class="navbar">
                <li><a href="">home</a></li>
                <li><a href="">order history</a></li>
                <!-- <li><a href="viewProfile">view my profile</a></li> -->
                <li><a href='ViewProfile'>view my profile</a></li>
                <li><a href='Login'>logout</a></li>
                <li><a href="">linkedIn</a></li>

            </ul>
            <!-- navbar -->
        </div>
        <!-- container nav-elements -->
    </nav>
    <!-- <div class="container tagline">
<h1 class="headline">Our Mission</h1>
<p>We support and encourage <em>active and healthy</em> lifestyles, by offering <em>ethically sourced</em> and <em>eco-friendly</em> nutritional products for the <em>performance-driven</em> athlete.</p>
</div>container tagline -->
</header>
<section id="profile" class="section">
    <div class="container">
        <h2 class="headline"></h2>
        <table id="profile1">

            <tr>
                <td>Username</td>
                <td>${user.username}</td>
            </tr>
            <tr>
                <td>First Name</td>
                <td>${user.firstName}</td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td>${user.lastName}</td>
            </tr>
            <tr>
                <td>Interested in</td>
                <td>${user.activity}</td>
            </tr>

        </table>
    </div>
</section>

<%@include file="footer.jsp"%>
</body>
</html>
