<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Change Password</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/admin/changePassword.do" method="post" class="bs-example bs-example-form" role="form"
          id="theForm">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Current Password</span>
            <input type="password" name="oldPassword" id="oldPassword" class="form-control" placeholder="Current Password">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">New Password</span>
            <div class="controls">
            <input type="password" name="newPassword" id="newPassword" class="form-control" placeholder="New Password">
            </div>
        </div>
        <br>
        <div class="input-group col-lg-4">
            <span class="input-group-addon">Confirm New Password</span>
            <input type="password" name="newPassword1" id="newPassword1" class="form-control" placeholder="Confirm New Password">
        </div>
        <br>
        <div class="form-horizontal">
            <input type="submit" value="Confirm" class="btn btn-danger"/>
        </div>
    </form>
<jsp:include page="../back/exclude/message.jsp"/>
</body>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
</html>