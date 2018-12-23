<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Video Add</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/video/add.do" method="post" class="form-horizontal" id="theForm">
        <div class="control-group">
            <label class="control-label" for="name">Video Title</label>

            <div class="controls">
                <input type="text" name="name" id="name" class="input-xlarge">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="link">Link</label>

            <div class="controls">
                <input type="text" name="link" id="link" class="input-xxlarge">
            </div>
        </div>
        <div class="form-search">
            <input type="submit" value="Confirm" class="btn btn-danger"/>
        </div>
    </form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>