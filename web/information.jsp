<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<c:set value="${pwk:getUserByRequest(pageContext.request)}" var="user"/>
<c:if test="${empty user}">
    <c:redirect url="${pageContext.request.contextPath}/index.html?t=login&url=/information.html"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>My Profile &middot; My Paris Bags</title>
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
		<div class="content-inner" style="min-height:700px">
			
			<!-- List Begin -->
			
			<div class="breadcrumbs">
				<ul>
					<li><a href="${pageContext.request.contextPath}/"><s:text name="navigate.home"/></a></li>
                    <li class="last"><s:text name="navigate.profile"/></li>
				</ul>
				<br class="clear"/>
			</div>
			
			<!-- Left Column Begin -->
			<div class="left-side float-left">
                <h3>Menu</h3>
				<ul>
					<li><s:text name="personal.menu.profile"/></li>
					<li><a href="${pageContext.request.contextPath}/order.html"><s:text name="personal.menu.order"/></a></li>
					<li><a href="${pageContext.request.contextPath}/changePassword.html"><s:text name="personal.menu.change"/></a></li>
				</ul>
				
			</div>
			<!-- Left Column End -->
			
			<!-- Main Column Begin -->

                <div class="main-content-left">
                    <form action="${pageContext.request.contextPath}/user/changeInformation.do" method="post" id="theForm">
                        <input type="hidden" name="id" value="${user.id}">
                    <h3><s:text name="profile.menu"/></h3>

                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="loginName"><s:text name="profile.name"/></label>

                        <input type="text" size="50" name="loginName" id="loginName" value="${user.loginname}" class="required form-name input-text" disabled />
                    </div>
                    <br class="clear"/>

                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="email"><s:text name="profile.email"/></label>
                        <input type="text" size="50" name="email" id="email" value="${user.email}" class="required email form-name input-text" />
                    </div>
                    <br class="clear"/>

                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="name"><s:text name="profile.name"/></label>
                        <input type="text" size="50" name="name" id="name" value="${user.name}" class="required email form-name input-text" />
                    </div>
                    <br class="clear"/>
                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="phone"><s:text name="profile.phone"/></label>
                        <input type="text" size="50" name="phone" id="phone" value="${user.phone}" class="required email form-name input-text" />
                    </div>
                    <br class="clear"/>

                        <div class="form-name float-left" style="margin-left: 150px">
                            <label for="country"><s:text name="profile.country"/></label>
                            <select id="country" name="country" onchange="loadState()">
                                <option></option>
                            </select>
                        </div>
                        <br class="clear"/>

                        <div class="form-name float-left" style="margin-left: 150px" id="stateDiv">
                            <label for="state"><s:text name="profile.state"/></label>
                            <select id="state" name="state">
                                <option></option>
                            </select>
                        </div>
                        <br class="clear"/>

                    <div class="form-name float-left" style="margin-left: 150px">
                        <label for="address"><s:text name="profile.address"/></label>
                        <textarea rows="3" cols="50" id="address" name="address">${user.address}</textarea>
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
    $(document).ready(function(){
        $.post("/location/loadCountry.do",{"countryId":${empty user.country?0:user.country}},function(data){
            $("#country").append(data);
        },"html");
        $.post("/location/loadState.do",{"countryId":${empty user.country?0:user.country},"userId":${user.id}},function(data){
            $("#state").empty().append(data);
            $("#stateDiv").show();
        },"html");
    });
    function loadState(){
        var country = $("#country").val();
        var state = $("#state");
        state.attr("value","");
        $("#stateDiv").hide();
        $.post("/location/loadState.do",{"countryId":country},function(data){
            if(data!=null&&data!=""){
                state.empty().append(data);
                $("#stateDiv").show();
            }
        },"html");
    }
</script>
</body>
</html>