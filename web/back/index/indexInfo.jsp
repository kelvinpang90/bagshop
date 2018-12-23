<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getIndexInfoById(1)}" var="info1"/>
<c:set value="${pwk:getIndexInfoById(2)}" var="info2"/>
<html>
<head>
    <title>Index Information</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/indexInfo/updateIndexInfo.do" method="post" class="form-horizontal" id="theForm">
        <div class="control-group">
            <label class="control-label" for="topInfo">Top Words</label>

            <div class="controls">
                <input type="text" name="topInfo" id="topInfo" class="input-xxlarge" value="${info1.content}"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="middleInfo">Middle Words</label>

            <div class="controls">
                <input type="text" name="middleInfo" id="middleInfo" class="input-xxlarge" value="${info2.content}"/>
            </div>
        </div>
        <div class="form-search">
            <input type="submit" value="Confirm" class="btn btn-danger" />
        </div>
    </form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>