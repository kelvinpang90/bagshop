<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Color List</title>
</head>
<body>
    <div>
        <h4>Color List    <a href="colorAdd.jsp" class="btn btn-danger">Add Color</a></h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>Name</th>
                <th>Picture</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${pwk:getAllColor()}" var="color">
                <tr>
                    <td class="td2">${color.id}</td>
                    <td class="td2">${color.name}</td>
                    <td class="td2">
                        <c:forEach items="${color.picPath}" var="pic" begin="0" end="0">
                            <img src="${pwk:getPicDomain()}/${pic.path}" style="height: 30px;width: 30px;"/>
                        </c:forEach>
                    </td>
                    <td class="td2">
                        <a href="colorUpdate.jsp?id=${color.id}" class="btn btn-danger">Modify</a>
                        <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/color/colorDelete.do?id=${color.id}'}" class="btn btn-success">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>