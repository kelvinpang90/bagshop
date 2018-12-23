<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getOrderTotal()}" var="total"/>
<html>
<head>
    <title>Order List</title>
</head>
<body>
    <div>
        <h4>Order List</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>Order Id</th>
                <th>Order Date</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Total Price</th>
                <th>Payment Status</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${pwk:getAllOrder(param.p, 20)}" var="order" varStatus="vs">
                <tr>
                    <td class="td2">${vs.count}</td>
                    <td class="td2">${order.id}</td>
                    <td class="td2">${order.createDate}</td>
                    <td class="td2">${order.fullName}</td>
                    <td class="td2">${order.phone}</td>
                    <td class="td2">${order.totalPrice+order.shipPrice}</td>
                    <td class="td2">${order.status eq 0?'pending':order.status eq 1?'paid':order.status eq 2?'cancelled':'unknown'}</td>
                    <td class="td2">
                        <a href="orderDetail.jsp?id=${order.id}" class="btn btn-success">Detail</a>
                        <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/order/delete.do?id=${order.id}'}" class="btn btn-danger">Delete</a>
                        <c:if test="${order.status eq 0}">
                            <a href="javascript:if(confirm('confirm change to pay status?')){window.location.href='${pageContext.request.contextPath}/order/payByAdmin.do?id=${order.id}&status=1'}" class="btn btn-warning">Pay</a>
                        </c:if>
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
            return "${pageContext.request.contextPath}/back/order/orderList.jsp?s=20&p=" + page;
        }
    };

    $('#page').bootstrapPaginator(options);
</script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>