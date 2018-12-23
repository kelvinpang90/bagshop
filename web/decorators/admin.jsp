<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty sessionScope.admin}">
    <c:redirect url="${pageContext.request.contextPath}/login/index.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <title><decorator:title></decorator:title></title>
    <script src="${pageContext.request.contextPath}/bootstrap/js/jquery-1.11.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/html5shiv.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-paginator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/dashboard.css" rel="stylesheet">
    <decorator:head></decorator:head>
</head>
<body>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Category&Brand&Color <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/back/category/categoryList.jsp">Category List</a></li>
                        <li><a href="${pageContext.request.contextPath}/back/brand/brandList.jsp">Brand List</a></li>
                        <li><a href="${pageContext.request.contextPath}/back/color/colorList.jsp">Color List</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/back/product/productList.jsp">Product List</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">FAQ <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/back/faq/faqAdd.jsp">Add FAQ</a></li>
                        <li><a href="${pageContext.request.contextPath}/back/faq/faqList.jsp">FAQ List</a></li>
                        <li class="divider"></li>
                    </ul>
                </li>
                <li> <a href="${pageContext.request.contextPath}/back/email/emailAdd.jsp">Promotion Email</a></li>
                <li> <a href="${pageContext.request.contextPath}/back/user/userList.jsp">User</a></li>
                <li><a href="${pageContext.request.contextPath}/back/aboutUs/aboutUs.jsp">AboutUs</a></li>
                <li><a href="${pageContext.request.contextPath}/back/order/orderList.jsp">Order</a></li>
                <li><a href="${pageContext.request.contextPath}/back/payment/paymentList.jsp">Payment</a></li>
                <li><a href="${pageContext.request.contextPath}/back/changePassword.jsp">Password</a></li>
                <li><a href="javascript:imageManagement()">Review</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/loginOut.do" style="float: right">log_out</a>    </li>
            </ul>
        </div>
    </div>
</div>
<div class="container-fluid theme-showcase">
    <decorator:body></decorator:body>
</div>
<script>

    function imageManagement(){
        var finder = new CKFinder();
        finder.BasePath = "/ckfinder/ckfinder.js";  //导入CKFinder的路径
        finder.popup();
    }
</script>
</body>
</html>