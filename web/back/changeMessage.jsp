<%@ page import="com.pwk.entity.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Admin admin = (Admin)request.getSession().getAttribute("admin");
    request.setAttribute("bandAccount",admin.getBandAccount());
    request.setAttribute("email",admin.getEmail());
    request.setAttribute("contactNumber",admin.getContactNumber());
    request.setAttribute("contactPerson",admin.getContactPerson());
    request.setAttribute("fullName",admin.getFullName());
%>
<html>
<head>
    <title>Change Self Information</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/admin/changeMessage.do" method="post" class="form-signin"
          id="theForm">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">BandAccount</span>
            <input type="text" name="bandAccount" id="bandAccount" class="form-control" placeholder="bandAccount" value="${bandAccount}">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Email</span>
            <input type="text" name="email" id="email" class="form-control" placeholder="email" value="${email}">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">ContactNumber</span>
            <input type="text" name="contactNumber" id="contactNumber" class="form-control" placeholder="contactNumber" value="${contactNumber}">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">ContactPerson</span>
            <input type="text" name="contactPerson" id="contactPerson" class="form-control" placeholder="contactPerson" value="${contactPerson}">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">FullName</span>
            <input type="text" name="fullName" id="fullName" class="form-control" placeholder="fullName" value="${fullName}">
        </div>
        <br>
        <input type="submit" value="Confirm" class="btn btn-danger"/>
    </form>
<jsp:include page="../back/exclude/message.jsp"/>
</body>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
</html>