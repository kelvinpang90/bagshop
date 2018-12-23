<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Register &middot; My Paris Bags</title>
    <!-- Main style -->
    <link rel="stylesheet" href="css/main.css" type="text/css" />

    <!-- Fancybox style -->
    <link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

    <!-- Product slider style -->
    <link rel="stylesheet" href="css/product-slider.css" type="text/css" />

    <!--[if IE 6]>
    <link rel="stylesheet" href="css/ie6.css" type="text/css" media="screen" />
    <![endif]-->

    <!-- Style for the superfish navigation menu -->
    <link rel="stylesheet" href="superfish/superfish.css" type="text/css" media="screen" />

    <!-- Style for Megamenu -->
    <link rel="stylesheet" href="css/megamenu.css" type="text/css" />

    <!-- Style for price range slider -->
    <link rel="stylesheet" href="jQueryUI/css/redmond/jquery-ui-1.7.1.custom.css" type="text/css" />
    <link rel="Stylesheet" href="jQueryUI/css/ui.slider.extras.css" type="text/css" />

    <!-- Google font -->
    <link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Qwigley' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css' />

    <!-- JS for jQuery -->
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

    <!-- JS for jQuery Product slider -->
    <script type="text/javascript" src="js/jquery.tools.min.js"></script>

    <!-- JS for jQuery Fancy Box -->
    <script type="text/javascript" src="fancybox/fancybox/jquery.fancybox-1.3.4.pack.js"></script>

    <!-- JS for superfish navigation menu -->
    <script type="text/javascript" src="superfish/hoverIntent.js"></script>
    <script type="text/javascript" src="superfish/superfish.js"></script>

    <!-- JS for price range slider -->
    <script type="text/javascript" src="jQueryUI/js/jquery-ui-1.7.1.custom.min.js"></script>
    <%--<script type="text/javascript" src="jQueryUI/js/selectToUISlider.jQuery.js"></script>--%>

    <!-- Style for product gallery -->
    <link href="exposure/exposure.css" type="text/css" rel="stylesheet" />

    <!-- JS for product gallery -->
    <script src="exposure/jquery.exposure.js" type="text/javascript"></script>

    <!-- JS for contact form -->
    <script src="js/jquery.validate.pack.js" type="text/javascript"></script>
</head>
<body>

<div id="container">

    <jsp:include page="include/top.jsp" flush="true"/>

    <div id="content">

        <div class="content-top"></div>
        <div class="content-inner">

            <!-- List Begin -->

            <div class="breadcrumbs">
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li class="last">Register</li>
                </ul>
                <br class="clear"/>
            </div>

            <!-- Main Begin -->

            <div class="full-width-content" style="margin:0 auto;">
                <h3>Register</h3>
                <form method="post" action="${pageContext.request.contextPath}/user/userAdd.do" id="theForm" onsubmit="return validateInfo()">
                    <div class="one-half float-left">
                        <span class="new-comment-heading">User information</span>
                        <!-- Form Begin -->
                        <div class="comment-form-container" id="contact-wrapper" >

                            <div class="form-name float-left">
                                <label for="loginName">Login Name<font color="red">*</font></label>

                                <input type="text" size="50" name="loginName" id="loginName" value="" class="required form-name input-text" />
                                <label for="loginName" generated="true" class="error" id="loginNameTip"></label>
                            </div>
                            <br class="clear"/>

                            <div class="form-name float-left">
                                <label for="password">Password<font color="red">*</font></label>
                                <input type="password" size="50" name="password" id="password" value="" class="required email form-name input-text" />
                                <label for="password" generated="true" class="error" id="passwordTip"></label>
                            </div>
                            <br class="clear"/>

                            <div class="form-name float-left">
                                <label for="password2">Password Confirm<font color="red">*</font></label>
                                <input type="password" size="50" name="password1" id="password2" value="" class="required email form-name input-text" />
                                <label for="password2" generated="true" class="error" id="password2Tip"></label>
                            </div>
                            <br class="clear"/>

                            <div class="form-name float-left">
                                <label for="email">Email<font color="red">*</font></label>
                                <input type="text" size="50" name="email" id="email" value="" class="required email form-name input-text" />
                                <label for="email" generated="true" class="error float-right" id="emailTip"></label>
                            </div>
                            <br class="clear"/>

                            <div class="form-name float-left">
                                <label for="validateCode">ValidateCode<font color="red">*</font></label>
                                <input type="text" maxlength="4" name="validateCode" id="validateCode" value="" class="required email form-name input-text"/>
                                <label for="validateCode" generated="true" class="error" id="validateCodeTip"></label>
                            </div>
                            <div class="form-name float-right">
                                <label for="validateCode">click to refresh</label>
                                <img title="change" onclick="javascript:this.src='/validateCode?'+Math.random();" src="/validateCode">
                                <label for="validateCode" generated="true" class="error"></label>
                            </div>

                            <br class="clear"/>



                        </div>
                        <!-- Form End -->

                    </div>

                    <div class="one-half float-right address">
                        <span class="new-comment-heading">Delivery details</span>
                        <div class="form-name float-left">
                            <label for="name">Contact Name</label>
                            <input type="text" size="50" name="name" id="name" value="" class="required email form-name input-text" />
                            <label for="name" generated="true" class="error"></label>
                        </div>
                        <br class="clear"/>
                        <div class="form-name float-left">
                            <label for="phone">Contact phone</label>
                            <input type="text" size="50" name="phone" id="phone" value="" class="required email form-name input-text" />
                            <label for="phone" generated="true" class="error"></label>
                        </div>
                        <br class="clear"/>
                        <div class="form-name float-left">
                            <label for="country">Country</label>
                            <select id="country" name="country" onchange="loadState()" class="required email form-name input-text">
                                <option selected></option>
                            </select>
                            <label for="phone" generated="true" class="error"></label>
                        </div>
                        <br class="clear"/>
                        <div class="form-name float-left" id="stateDiv">
                            <label for="state">State</label>
                            <select id="state" name="state" class="required email form-name input-text">
                                <option></option>
                            </select>
                            <label for="phone" generated="true" class="error"></label>
                        </div>
                        <br class="clear"/>
                        <div class="form-name float-left">
                            <label for="address">Address</label>
                            <input type="text" size="50" name="address" id="address" value="" class="required email form-name input-text" />
                            <label for="address" generated="true" class="error"></label>
                        </div>
                        <br class="clear"/>

                    </div>


                    <br class="clear"/>

                    <input type="submit" class="contact-form-button" value="Register" name="submit"/>
                </form>

            </div>
            <!-- Main End -->

            <br class="clear"/>

            <!-- List End -->

        </div>
        <div class="shadow"></div>

        <br class="clear"/>
    </div>

    <jsp:include page="include/bottom.jsp" flush="true"/>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $.post("/location/loadCountry.do",{"countryId":128},function(data){
            $("#country").append(data);
        },"html");
        $.post("/location/loadState.do",{"countryId":128},function(data){
            $("#state").empty().append(data);
            $("#stateDiv").show();
        },"html");
    });
    function loadState(){
        var country = $("#country").val();
        $("#stateDiv").hide();
        $.post("/location/loadState.do",{"countryId":country},function(data){
            if(data!=null&&data!=""){
                $("#state").empty().append(data);
                $("#stateDiv").show();
            }
        },"html");
    }
    function validateInfo(){
        var loginName = $("#loginName");
        var loginName1 = $("#loginName1");
        var loginNameTip = $("#loginNameTip");
        var loginNameTip1 = $("#loginNameTip1");
        var loginNameTip2 = $("#loginNameTip2");
        var password = $("#password");
        var password1 = $("#password1");
        var password2 = $("#password2");
        var passwordTip = $("#passwordTip");
        var passwordTip1 = $("#passwordTip1");
        var password2Tip = $("#password2Tip");
        var passwordTip2 = $("#passwordTip2");
        var password2Tip2 = $("#password2Tip2");
        var email = $("#email");
        var emailTip = $("#emailTip");
        var validateCode = $("#validateCode");
        var validateCodeTip = $("#validateCodeTip");
        if (loginName.val() == "" || loginName.val().length < 6) {
            loginNameTip.empty();
            loginNameTip2.empty();
            loginNameTip.append("at least 6 character");
            return false;
        } else {
            loginNameTip.empty();
            loginNameTip2.empty();
            loginNameTip2.append("checking...");
            $.post('/user/findUniqueName.do', {'loginName': loginName.val()}, function (data) {
                if (data.state == "ok") {
                    loginNameTip.empty();
                    loginNameTip2.empty();
                } else if (data.state == "error") {
                    loginNameTip.empty();
                    loginNameTip2.empty();
                    loginNameTip.append("cannot use this loginName");
                    return false;
                } else {
                    loginNameTip.empty();
                    loginNameTip2.empty();
                    loginNameTip.append("network error,please try again");
                    return false;
                }
            },"json");
        }
        if (password.val() == '' || password.val().length < 6) {
            passwordTip.empty();
            passwordTip2.empty();
            passwordTip.append("at least 6 character");
            return false;
        } else {
            passwordTip.empty();
            passwordTip2.empty();
            passwordTip2.append("ok");
        }
        if (password2.val() == '' || password2.val() != password.val()) {
            password2Tip.empty();
            password2Tip2.empty();
            password2Tip.append("not match");
            return false;
        } else {
            password2Tip.empty();
            password2Tip2.empty();
            password2Tip2.append("ok");
        }
        if(email.val()==""){
            emailTip.empty();
            emailTip.append("please input your email");
            return false;
        }
        if(validateCode.val()==""){
            validateCodeTip.empty();
            validateCodeTip.append("please input the validateCode");
            return false;
        }
        return true;
    }
</script>
</body>
</html>