<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Category List</title>
</head>
<body>
<div>
    <h4>Category List   <a href="categoryAdd.jsp" class="btn btn-danger">Add Category</a></h4>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
        <tr>
            <th>Id</th>
            <th>Category Name</th>
            <th>Category Parent</th>
            <th>Operation</th>
        </tr>
        <c:forEach items="${pwk:getCategoryList(param.p, param.s)}" var="category">
            <tr>
                <td class="td2">${category.id}</td>
                <td class="td2">${category.name}</td>
                <td class="td2">${category.parentId eq null?'':pwk:getCategoryById(category.parentId).name}</td>
                <td class="td2">
                    <a href="categoryUpdate.jsp?id=${category.id}" class="btn btn-info">Update</a>
                    <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/category/delete.do?id=${category.id}'}" class="btn btn-danger">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>