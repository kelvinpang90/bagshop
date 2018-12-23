<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getIndexProductTotal()}" var="total"/>
<c:set value="${pwk:getIndexProductByList(param.p, param.s )}"  var="indexProduct"/>
<html>
<head>
    <title>Index Product List</title>
</head>
<body>
    <div>
        <h4>Index Product List</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Product Name</th>
                <th>Picture</th>
                <th>Position</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${indexProduct}" var="indexProduct">
                <tr>
                    <td class="td2">${indexProduct.product.name}</td>
                    <td class="td2">
                        <c:forEach items="${indexProduct.product.picPath}" var="pic" begin="0" end="0">
                            <img src="${pwk:getPicDomain()}/${pic.path}" style="height: 80px;width: 80px;"/>
                        </c:forEach>
                    </td>
                    <td class="td2">${indexProduct.position}</td>
                    <td class="td2">
                        <a href="${pageContext.request.contextPath}/back/indexProduct/updateIndexProduct.jsp?id=${indexProduct.id}" class="btn btn-danger">Modify</a>
                        <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/indexProduct/deleteIndexProduct.do?id=${indexProduct.id}'}" class="btn btn-success">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
<ul id="page"></ul>
<script>
    var options = {
        bootstrapMajorVersion:3,
        alignment: 'center',
        currentPage: ${empty param.p?1:param.p},
        totalPages: ${(total+10)/10},
        pageUrl: function (type, page, current) {
            return "${pageContext.request.contextPath}/back/indexProduct/indexProductList.jsp?s=10&p=" + page;
        }
    };

    $('#page').bootstrapPaginator(options);
</script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>