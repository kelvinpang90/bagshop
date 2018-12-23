<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Brand List</title>
</head>
<body>
    <div>
        <h4>Brand List    <a href="brandAdd.jsp" class="btn btn-danger">Add Brand</a></h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>Brand Name</th>
                <th>Picture</th>
                <th>Order</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${pwk:getAllBrand()}" var="brand">
                <tr>
                    <td class="td2">${brand.id}</td>
                    <td class="td2">${brand.brandName}</td>
                    <td class="td2">
                        <c:forEach items="${brand.picPath}" var="pic" begin="0" end="0">
                            <img src="${pwk:getPicDomain()}/${pic.path}" style="height: 40px;width: 80px;"/>
                        </c:forEach>
                    </td>
                    <td class="td2">${brand.position}</td>
                    <td class="td2">
                        <a href="brandUpdate.jsp?id=${brand.id}" class="btn btn-info">Modify</a>
                        <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/brand/brandDelete.do?id=${brand.id}'}" class="btn btn-danger">Delete</a>
                        <c:if test="${brand.status eq 0}">
                            <a href="javascript:if(confirm('confirm to change status?')){window.location.href='${pageContext.request.contextPath}/brand/setStatus.do?id=${brand.id}&status=1'}" class="btn btn-success">On</a>
                        </c:if>
                        <c:if test="${brand.status eq 1}">
                            <a href="javascript:if(confirm('confirm to change status?')){window.location.href='${pageContext.request.contextPath}/brand/setStatus.do?id=${brand.id}&status=0'}" class="btn btn-warning">Off</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>