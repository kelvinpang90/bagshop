<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Forget Password&middot; My Paris Bags</title>
<!-- Main style -->
<link rel="stylesheet" href="css/main.css" type="text/css" />

<!-- Fancybox style -->
<link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

<!-- Product slider style -->
<link rel="stylesheet" href="css/product-slider.css" type="text/css" />

<!-- Style for the superfish navigation menu -->
<link rel="stylesheet" href="superfish/superfish.css" type="text/css" media="screen" />

<!-- Style for Megamenu -->
<link rel="stylesheet" href="css/megamenu.css" type="text/css" /> 

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

</head>
<body>

<div id="container">

	<jsp:include page="include/top.jsp" flush="true"/>

	<div id="content">
	
		<div class="content-top"></div>
		<div class="content-inner" style="min-height:600px">
			
			<!-- List Begin -->
			
			<div class="breadcrumbs">
				<ul>
					<li><a href="${pageContext.request.contextPath}/"><s:text name="navigate.home"/></a></li>
                    <li class="last"><s:text name="navigate.forget"/></li>
				</ul>
				<br class="clear"/>
			</div>
			
			<!-- Main Column Begin -->

                <div class="main-content">
                    <form action="${pageContext.request.contextPath}/user/forgetPassword.do" method="post" id="theForm" onsubmit="return validateForm();">
                    <h3><s:text name="forget.menu"/></h3>

                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="loginName1"><s:text name="forget.name"/></label>
                        <input type="text" size="50" name="loginName" id="loginName1" value="" class="required form-name input-text" />
                        <label for="loginName1" generated="true" class="error" id="loginNameTip"></label>
                    </div>
                    <br class="clear"/>

                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="email"><s:text name="forget.email"/></label>
                        <input type="text" size="50" name="email" id="email" value="" class="required email form-name input-text" />
                        <label for="emailTip" generated="true" class="error" id="emailTip"></label>
                    </div>
                    <br class="clear"/>

                        <div class="form-name float-left" style="margin-left: 150px;width:100px;">
                            <label for="validateCode"><s:text name="forget.code"/></label>
                            <input type="text" maxlength="4" name="validateCode" id="validateCode" value="" class="required email form-name input-text" style="width:50px;"/>
                            <label for="validateCode" generated="true" class="error" id="validateCodeTip"></label>
                        </div>
                        <div class="form-name float-left">
                            <label for="validateCode"><s:text name="forget.click"/></label>
                            <img title="change" onclick="javascript:this.src='/validateCode?'+Math.random();" src="/validateCode">
                            <label for="validateCode" generated="true" class="error"></label>
                        </div>

                        <br class="clear"/>
                    <div class="form-name float-left" style="margin-left: 250px">
                        <input type="submit" class="contact-form-button" value="Submit" name="submit"/>
                    </div>

                    <br class="clear"/>
            </form>
                </div>

			<!-- Main Column End -->
			
			<!-- List End -->
			
		</div>
		<div class="shadow"></div>
		
		<br class="clear"/>
	</div>

    <jsp:include page="include/bottom.jsp" flush="true"/>
</div>
<script type="text/javascript">
    function validateForm(){
        var loginName = $("#loginName1");
        var email = $("#email");
        var validateCode = $("#validateCode");

        var loginNameTip = $("#loginNameTip");
        var emailTip = $("#emailTip");
        var validateCodeTip = $("#validateCodeTip");
        if (loginName.val() == "" || loginName.val().length < 6) {
            loginNameTip.empty();
            loginNameTip.append("at least 6 character");
            return false;
        }
        if(email.val()==""){
            emailTip.append("please input your email");
            return false;
        }
        if(validateCode.val()==""){
            validateCodeTip.append("please input the validateCode");
            return false;
        }
        return true;
    }
</script>
</body>
</html>