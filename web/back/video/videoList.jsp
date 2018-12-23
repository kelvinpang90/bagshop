<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Video List</title>
</head>
<body>
    <div>
        <h4>Video List</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>Video List</th>
                <th>Video Link</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${pwk:getVideoByList(param.p, param.s)}" var="video" varStatus="vs">
                <tr>
                    <td class="td2">${vs.count}</td>
                    <td class="td2">${video.name}</td>
                    <td class="td2">${video.link}</td>
                    <td class="td2">
                        <a href="videoUpdate.jsp?id=${video.id}" class="btn btn-danger">Modify</a>
                        <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/video/delete.do?id=${video.id}'}" class="btn btn-success">Delete</a>
                        <a href="${pageContext.request.contextPath}/playVideo_${video.id}.html" class="btn btn-info" target="_blank">Play</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>