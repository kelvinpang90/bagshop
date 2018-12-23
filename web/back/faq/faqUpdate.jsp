<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getFAQById(param.id)}" var="faq"/>
<html>
<head>
    <title>Modify FAQ</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/faq/updateFAQ.do" method="post" class="bs-example bs-example-form" role="form" id="theForm" onsubmit="return checkForm()">
        <input type="hidden" name="id" value="${faq.id}">
        <div class="input-group col-lg-7">
            <span class="input-group-addon">Question</span>
            <textarea name="question" id="question" class="form-control">${faq.question}</textarea>
        </div>
        <br>
        <div class="input-group col-lg-7">
            <span class="input-group-addon">Answer</span>
            <textarea name="answer" id="answer" class="form-control">${faq.answer}</textarea>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Position</span>
            <input type="text" name="position" id="position" class="form-control" placeholder="1,2,3,4,5......" value="${faq.position}">
        </div>
        <br>
        <input type="submit" value="Confirm" class="btn btn-danger"/>
    </form>
<jsp:include page="../exclude/message.jsp"/>
<script type="text/javascript">
    function checkForm() {
        var question = $("#question").val();
        var answer = $("#answer").val();
        var position = $("#position").val();
        if (question == "") {
            alert("question can not be empty");
            return false;
        }
        if (answer == "") {
            alert("answer can not be empty");
            return false;
        }
        if (position == "") {
            alert("position can not be empty");
            return false;
        }
        return true;
    }
</script>
</body>
</html>