<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set value="${pwk:getCountByUserId(pageContext.request)}" var="count"/>
<c:if test="${count eq null or count eq 0}">
    <c:redirect url="${pageContext.request.contextPath}/cart.html"/>
</c:if>
<c:set value="${pwk:getUserByRequest(pageContext.request)}" var="user"/>
<c:set value="${pwk:getShoppingCartByUserId(pageContext.request)}" var="carts"/>
<%
    String token = UUID.randomUUID().toString().replace("-","");
    session.setAttribute("token",token);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Order Confirm &middot; My Paris Bags</title>
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
                    <li><a href="cart.html">Shopping cart</a></li>
                    <li class="last">Order Confirm</li>
                </ul>
                <br class="clear"/>
            </div>

            <!-- Main Begin -->

            <div class="full-width-content">
                <h3>Order confirm</h3>

                <div class="one-half float-left">

                    <!-- Form Begin -->
                    <div class="comment-form-container" id="contact-wrapper">



                        <form method="post" action="${pageContext.request.contextPath}/order/add.do" onsubmit="return validateInfo();" id="theForm">

                            <input type="hidden" name="token" value="${token}"/>
                            <span class="new-comment-heading">Delivery Details</span>

                            <div class="form-name float-left">
                                <label for="fullName">Your Name</label>
                                <input type="text" size="50" name="fullName" id="fullName" value="${user.name}" class="required form-name input-text" />
                            </div>

                            <div class="form-name float-right">
                                <label for="phone">Contact Phone</label>
                                <input type="text" size="50" name="phone" id="phone" value="${user.phone}" class="required email form-name input-text" />
                            </div>

                            <div class="form-name float-left">
                                <label for="email">Email</label>
                                <input type="text" size="50" name="email" id="email" value="${user.email}" class="required email form-name input-text" />
                            </div>
                            <br class="clear"/>

                            <div class="form-name float-left">
                                <label for="country">Country</label>
                                <select name="country" id="country" onchange="loadState()" class="required email form-name input-text" ></select>
                            </div>
                            <br class="clear"/>

                            <div class="form-name float-left" id="stateDiv" style="display: none;">
                                <label for="state">State</label>
                                <select name="state" id="state" class="required email form-name input-text" ></select>
                            </div>
                            <br class="clear"/>

                            <div class="form-comment">
                                <label for="address">Address Detail</label>
                                <textarea rows="4" cols="20" name="address" id="address" class="required txtarea-comment">${user.address}</textarea>
                            </div>

                            <input id="confirmButton" type="submit" class="contact-form-button" value="Confirm" name="submit" />
                        </form>
                    </div>
                    <!-- Form End -->

                </div>

                <div class="one-half float-right address">
                    <span class="new-comment-heading">Product Details</span>
                    <c:forEach items="${carts}" var="cart">
                        <div class="street">
                            <div style="float: left">
                                <c:forEach items="${cart.product.picPath}" var="pic" begin="0" end="0">
                                    <img src="${pwk:getPicDomain()}/${pic.miniPath}" alt="${cart.product.name}" width="80px" height="80px">
                                </c:forEach>
                            </div>
                            <div style="float:left;margin-left: 20px;">
                                <p style="color: #50062C;font-size: 15px;">
                                        ${fn:substring(cart.product.name, 0, 30)}
                                    <c:if test="${cart.product.stockStatus eq 0}">
                                        <span style="color: red">Out of Stock</span>
                                    </c:if>
                                </p>
                                <p>
                                    <c:forEach items="${cart.color.picPath}" var="pic" begin="0" end="0">
                                        Color:<img src="${pwk:getPicDomain()}/${pic.path}" alt="${cart.color.name}" width="20" height="">
                                    </c:forEach>
                                </p>
                                <p>Price:RM  <fmt:formatNumber value="${cart.product.price+cart.additionalPrice}" type="currency" pattern="###,##0.00"/></p>
                                <c:forEach items="${pwk:StringToJsonArray(cart.attributes)}" var="attribute">
                                    <p>${attribute.name}:${attribute.value}</p>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <br class="clear"/>

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
        $("#stateDiv").hide();
        $.post("/location/loadState.do",{"countryId":country},function(data){
            if(data!=null&&data!=""){
                $("#state").empty().append(data);
                $("#stateDiv").show();
            }
        },"html");
    }
    function validateInfo(){
        var fullName = $("#fullName");
        var phone = $("#phone");
        var email = $("#email");
        var country = $("#country");
        var state = $("#state");
        var address = $("#address");
        if(fullName.val()==""){
            alert("please input your name");
            fullName.focus();
            return false;
        }
        if(phone.val()==""){
            alert("please input your phone");
            phone.focus();
            return false;
        }
        if(email.val()==""){
            alert("please input your email");
            email.focus();
            return false;
        }
        if(country.val()==""){
            alert("please select country");
            country.focus();
            return false;
        }
        if(address.val()==""){
            alert("please input your address");
            address.focus();
            return false;
        }
        return true;
    }
</script>

</body>
</html>