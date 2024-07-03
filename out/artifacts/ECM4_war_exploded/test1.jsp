<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 12/30/2020
  Time: 1:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="codes.GlobalFunctions" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<%@ page import="codes.UrlEncoder" %>
<html lang="en"><head>
    <title>HYELLA - LOGIN</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="v1.2-assets/images/icons/favicon.ico">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="v1.2-assets/css/util.css">
    <link rel="stylesheet" type="text/css" href="v1.2-assets/css/main.css">
    <!--===============================================================================================-->
    <link href="assets/css/custom.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="notification-container" style="max-width:300px;">

</div>
<div id="generate-report-progress-bar">

</div>
<%
    HashMap<String,String> accessible_tabs = new HashMap<>();

    //String accessible_tabs1 = GlobalFunctions.frontend_tabs();
        /*accessible_tabs.put("A","A1");
        accessible_tabs.put("B","B2");
        accessible_tabs.put("C","C3");
        accessible_tabs.put("D","D4");*/

    accessible_tabs.putAll(GlobalFunctions.frontend_tabs1());
    //System.out.println(accessible_tabs);

    int no_of_visible_tabs = 0;
    AtomicInteger visible_tabs_count = new AtomicInteger();

    //String more_tabs ="";
    accessible_tabs.forEach((tk,tval)->{
//            System.out.println("Key: "+tk + " value: "+tval);
        String attrx = "#" + tk;
        String attrx2 = "custom-single-selected-record-button empty-tab ";
        String attrx3 = "nav-link";

        String attrx4 ="data-toggle=\"tab\" role=\"tab\"";

        if( accessible_tabs == null && accessible_tabs.isEmpty()){

        }else{
            attrx = accessible_tabs.get("link");
            attrx2 = "";
            attrx4 = "";
        }
        //URL ENCODING using a method (UrlEncoder) created in another package
        String value = accessible_tabs.get("title");
        String encodedValue = UrlEncoder.encodeValue(value); // Encoding a hashmap string value

        StringBuffer tval1 = new StringBuffer();
        String tvalue = tval1.append(accessible_tabs.get("action")).append(encodedValue).append("&is_menu=1&tab_key=").append(tk).toString();

            /*accessible_tabs.get("action").join(",", "&menu_title=", encodedValue);
            accessible_tabs.get("action").join(",", "&is_menu=1&tab_key=", tk);*/

//            System.out.println(tvalue);

        if(visible_tabs_count.get() > no_of_visible_tabs ){

            StringBuffer tval2 = new StringBuffer();
            String more_tabs = tval2.append("<li class=\"nav-item \"><a href=\"").append(attrx).append("\"  class=\"").append(attrx2).append(" more-tab\" id=\"").append(tk).append(" override-selected-record=\"1\" action=").append(accessible_tabs.get("action")).append(" data-toggle=\"tab\"><span id=").append(tk).append("-span\">").append(accessible_tabs.get("title")).append("</span></a></li>").toString();

        }else{

        }

        String active = "";

        visible_tabs_count.incrementAndGet();


    });

%>

<div class="container-login100" style="background-image: url('v1.2-assets/images/bg-01.jpg');">
    <div class="wrap-login100">
        <div class="wrap-login100x p-l-55 p-r-55 p-t-40 p-b-30">
            <div class="text-center p-t-57x p-b-20">
                <span id="logo-container" class="txt1"><img src="assets/img/logo-big.png" alt="" /></span>
            </div>
            <form class="login-form activate-ajax login100-form validate-form" id="usersLoginForm" action="Login" method="post">

					<span class="login100-form-title p-b-37" id="registered-company">
					</span>

                <div class="wrap-input100 validate-input m-b-20" data-validate="Enter username or email">
                    <input class="input100" type="email" required="required" placeholder="Email" name="email" style="border-radius:inherit;">
                    <span class="focus-input100"></span>
                </div>

                <div class="wrap-input100 validate-input m-b-25" data-validate="Enter password">
                    <input class="input100" type="password" required="required" placeholder="Password" name="password" style="border-radius:inherit;">
                    <span class="focus-input100"></span>
                </div>

                <div class="container-login100-form-btn">
                    <button type="submit" class="login100-form-btn">
                        Sign In
                    </button>
                    <%out.println("attrx");%>
                </div>

                <div class="text-center p-t-30">
						<span class="txt1">
							<i><a href="http://hyella.com/" target="_blank">&copy; Hyella <span id="year-of-app">v.2020.01.20</span></a></i>
						</span>
                </div>
            </form>


        </div>

        <div id="bg-txt-1" class="text-center p-t-20 p-b-20 p-r-40 p-l-40 b" style="
    background: #bd59d4;
    background: -webkit-linear-gradient(left, rgba(0,168,255,0.5), rgba(185,0,255,0.5));
    MARGIN-TOP: 72px;
    color: #e4e4e4;
    position: relative;
    z-index: 1;
">
            <h4>Scalable &amp; Flexible</h4>

            <div class="txt5 p-t-5" style="font-size: 18px;">
                HYELLA ERP - easily monitor your business from anywhere in the world.</div>
            <p><%=out.print("test");%></p>
        </div>

    </div>
</div>



<div id="dropDownSelect1"></div>

<!--===============================================================================================-->
<script src="v1.2-assets/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="v1.2-assets/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="v1.2-assets/vendor/bootstrap/js/popper.js"></script>
<script src="v1.2-assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->






<script>
    function callAjax(){
        var email = $('#email').val();
        var password = $('#password').val();
        $.ajax({
            url     : 'Login',
            method     : 'POST',
            data     : {email : email, password : password},
            success    : function(resultText){
                $('#result').html(resultText);
            },
            error : function(jqXHR, exception){
                console.log('Error occured!!');
            }
        });
    }
</script>

</body></html>