<%--
  Created by IntelliJ IDEA.
  User: M13
  Date: 21/09/2020
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="css/style.css">
    <title>Welcome</title>
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
                    <li><a href='<%=response.encodeURL("getProfileDetails")%>'>view my profile</a></li>
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

        <section id="registration" class="section">
            <% String username = request.getParameter("username"); %>
            <h3> Welcome <% out.println(username); %>!!!</h3>
            <a href="login.jsp">Logout</a>
        </section>

    <%@include file="footer.jsp"%>
</body>
</html>
