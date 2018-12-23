<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getUserTotal()}" var="total"/>
<html>
<head>
    <title>User List</title>
</head>
<body>
    <div>
        <h4>Order List</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>LoginName</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Name</th>
                <th>Address</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${pwk:getUserList(param.p, param.s)}" var="user">
                <tr>
                    <td class="td2">${user.id}</td>
                    <td class="td2">${user.loginname}</td>
                    <td class="td2">${user.email}(${user.emailStatus eq 1?'<span style="color:green">subscribe</span>':'<span style="color:red">unsubscribe</span>'})</td>
                    <td class="td2">${user.phone}</td>
                    <td class="td2">${user.name}</td>
                    <td class="td2">${user.address}</td>
                    <td class="td2">

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
        totalPages: ${(total+20)/20},
        pageUrl: function (type, page, current) {
            return "${pageContext.request.contextPath}/back/user/userList.jsp?s=20&p=" + page;
        }
    };

    $('#page').bootstrapPaginator(options);
</script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>