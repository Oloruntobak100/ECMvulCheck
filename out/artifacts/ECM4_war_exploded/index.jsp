<html lang="en"><head>
  <title>CBN PAPERLITE - LOGIN</title>
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


<div class="container-login100" style="background-image: url('v1.2-assets/images/bg-01.jpg');">
  <div class="wrap-login100">
    <div class="wrap-login100x p-l-55 p-r-55 p-t-40 p-b-30">
      <div class="text-center p-t-57x p-b-20">
        <span id="logo-container" class="txt1"><img src="assets/img/logo-big.png" alt="" /></span>
      </div>
      <form class="login-form activate-ajax login100-form validate-form" id="usersLoginForm" action="?action=authenticate&todo=users" method="post">

					<span class="login100-form-title p-b-37" id="registered-company"></span>

        <div class="wrap-input100 validate-input m-b-20" data-validate="Enter AD username">
          <input class="input100" type="email" required="required" placeholder="Enter AD username" name="username" style="border-radius:inherit;">
          <span class="focus-input100"></span>
        </div>
        <i style="margin-top: -17px;font-size: 85%;display: block;margin-left: 20px;">E.g: Olajide190@cbn.gov.ng</i><br />

        <div class="wrap-input100 validate-input m-b-25" data-validate="Enter password">
          <input class="input100" type="password" required="required" placeholder="Password" name="password" style="border-radius:inherit;">
          <span class="focus-input100"></span>
        </div>

        <div class="container-login100-form-btn">
          <button type="submit" class="login100-form-btn">
            Sign In
          </button>
        </div>

        <div class="text-center p-t-30">
						<span class="txt1">
							<i><a href="https://dev1kit.com/?odk=cbn-ecm" target="_blank">&copy; CBN PAPERLITE <span id="year-of-app">v.2020.01.20</span></a></i>
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
        CBN PAPERLITE - extensible regulatory tech & approval workflow solution.</div>
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
<script src="v1.2-assets/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
<script src="v1.2-assets/vendor/daterangepicker/moment.min.js"></script>
<script src="v1.2-assets/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
<script src="v1.2-assets/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
<script src="v1.2-assets/js/main.js"></script>



<script src="assets/app/amplify.min.js"></script>
<script src="assets/app/dexie.min.js"></script>
<script src="assets/app/md5.js"></script>
<script src="assets/app/fileuploader.js"></script>
<script src="assets/app/fastclick.js"></script>
<script src="assets/app/jquery.tinysort.min.js"></script>

<script src="assets/app/custom.plugin.url.js" type="text/javascript"></script>
<script src="assets/app/custom.plugin.js" type="text/javascript"></script>
<script src="assets/app/login-script.js" type="text/javascript"></script>

<script>
  jQuery(document).ready(function() {

    //Login.init();
    $.fn.cProcessForm.activateAjaxForm();
    //alert("data");
    $.fn.nwLogin.checkAuthenticationStatus();
  });
</script>

</body></html>