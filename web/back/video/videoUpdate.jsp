<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getVideoById(param.id)}" var="video"/>
<html>
<head>
    <title>Video Update</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/video/update.do" method="post" class="form-horizontal" id="theForm">
        <input type="hidden" name="id" value="${video.id}">
        <div class="control-group">
            <label class="control-label" for="name">Video Name</label>

            <div class="controls">
                <input type="text" name="name" id="name" class="input-small" value="${video.name}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="link">Link</label>

            <div class="controls">
                <input type="text" name="link" id="link" class="input-xxlarge" value="${video.link}">
            </div>
        </div>
        <div class="form-search">
            <input type="submit" value="Confirm" class="btn btn-danger"/>
        </div>
    </form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>