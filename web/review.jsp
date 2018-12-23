<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getPicFromCategory('')}" var="feedbacks"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Customer Review</title>
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

<!-- Style for price range slider -->
<link rel="stylesheet" href="jQueryUI/css/redmond/jquery-ui-1.7.1.custom.css" type="text/css" />
<link rel="Stylesheet" href="jQueryUI/css/ui.slider.extras.css" type="text/css" />

<!-- Google font -->
<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Qwigley' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css' />

<link rel="stylesheet" href="colorbox/example2/colorbox.css"/>

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
<script type="text/javascript" src="colorbox/jquery.colorbox-min.js"></script>
<script type="text/javascript" src="js/jquery_lazyload-1.9.7/jquery.lazyload.min.js"></script>
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
					<li><a href="${pageContext.request.contextPath}/">Home</a></li>
					<li class="last">Customer Review</li>
				</ul>
				<br class="clear"/>
			</div>

			<div id="slider-container">
					<div class="items">
						<div class="group-items">
							<c:forEach items="${pwk:getPicFromCategory('/opt/pic_bak/upload/images/review')}" var="feedbacks" varStatus="vs1">
								<c:forEach items="${feedbacks}" var="feedback" varStatus="vs">
									<c:if test="${vs.first}">
                                        <c:set value="${feedback}" var="date"/>
                                        <li class="last">${date}</li><br>
                                    </c:if>
                                    <c:if test="${not vs.first}">
                                        <a href="${pwk:getPicDomain()}/upload/images/review/${date}/${feedback}" class="group${vs1.count}"><img class="lazy" data-original="${pwk:getPicDomain()}/upload/images/review/${date}/${feedback}" alt="" style="width: 240px;"/></a>
                                    </c:if>
                                    <c:if test="${vs.last}">
                                        <br>
                                        <c:set value="${vs1.count}" var="count"/>
                                    </c:if>
								</c:forEach>
							</c:forEach>
						</div>
					</div>
				<br class="clear"/>
			</div>
			<!-- Main Column End -->
			
			<br class="clear"/>
			
			<!-- List End -->
			
		</div>
		<div class="shadow"></div>
		
		<br class="clear"/>
	</div>

    <jsp:include page="include/bottom.jsp" flush="true"/>
</div>

<script>
	$(function() {
		$(".lazy").lazyload();
	});
</script>
</body>
</html>