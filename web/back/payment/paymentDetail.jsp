<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getPaymentById(param.id)}" var="paymentDetail"/>
<html>
<head>
    <title>Payment Detail</title>
</head>
<body>
<div class="container">
    ${paymentDetail.content}
</div>
</body>
</html>
