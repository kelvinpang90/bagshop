<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<c:set value="${pwk:getUserByRequest(pageContext.request)}" var="user"/>
<c:if test="${empty user}">
    <c:redirect url="${pageContext.request.contextPath}/index.html?t=login&url=/order.html"/>
</c:if>
<c:choose>
    <c:when test="${not empty param.status}">
        <c:set value="${pwk:getOrderByStatus(pageContext.request,param.status)}" var="orders"/>
    </c:when>

    <c:otherwise>
        <c:set value="${pwk:getOrderByUserId(pageContext.request)}" var="orders"/>
    </c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <title>Order List</title>
    <!-- Main style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css"/>

    <!-- Fancybox style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen"/>

    <!-- Product slider style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product-slider.css" type="text/css"/>

    <!-- Style for the superfish navigation menu -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/superfish/superfish.css" type="text/css" media="screen"/>

    <!-- Style for Megamenu -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/megamenu.css" type="text/css"/>

    <!-- Style for price range slider -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/jQueryUI/css/redmond/jquery-ui-1.7.1.custom.css" type="text/css"/>
    <link rel="Stylesheet" href="${pageContext.request.contextPath}/jQueryUI/css/ui.slider.extras.css" type="text/css"/>
    <!-- JS for jQuery -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.1.min.js"></script>

    <!-- JS for jQuery Product slider -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.tools.min.js"></script>

    <!-- JS for jQuery Fancy Box -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/fancybox/fancybox/jquery.fancybox-1.3.4.pack.js"></script>

    <!-- JS for superfish navigation menu -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/superfish/hoverIntent.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/superfish/superfish.js"></script>

    <!-- Style for product gallery -->
    <link href="${pageContext.request.contextPath}/exposure/exposure.css" type="text/css" rel="stylesheet"/>

    <!-- JS for product gallery -->
    <script src="${pageContext.request.contextPath}/exposure/jquery.exposure.js" type="text/javascript"></script>

</head>
<body>

<div id="container">

    <jsp:include page="include/top.jsp" flush="true"/>

    <div id="content">

        <div class="content-top"></div>
        <div class="content-inner">

            <!-- List Begin -->

            <div class="breadcrumbs">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/"><s:text name="navigate.home"/></a></li>
                    <li class="last"><s:text name="navigate.order.list"/></li>
                </ul>
                <br class="clear"/>
            </div>

            <div class="left-side float-left">
                <h3>Menu</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/information.html"><s:text name="personal.menu.profile"/></a></li>
                    <li><s:text name="personal.menu.order"/></li>
                    <li><a href="${pageContext.request.contextPath}/changePassword.html"><s:text name="personal.menu.change"/></a></li>
                </ul>

            </div>
            <!-- Main Begin -->

            <div class="main-content-left">
                <h3><s:text name="order.list.title"/></h3>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="remove"><span class="heading"><s:text name="order.list.id"/></span></td>
                        <td class="product-name"><span class="heading"><s:text name="order.list.date"/></span></td>
                        <td class="product-name" style="text-align: center"><span class="heading"><s:text name="order.list.color"/></span></td>
                        <td class="quantity" style="width: 0"><span class="heading"><s:text name="order.list.price"/></span></td>
                        <td class="unit-price"><span class="heading"><s:text name="order.list.status"/></span></td>
                        <td class="quantity"><span class="heading"><s:text name="order.list.operation"/></span></td>
                    </tr>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td class="remove">${order.id}</td>
                            <td class="product-name"><fmt:formatDate value="${order.createDate}" type="both"/> </td>
                            <td class="product-name">
                            <table>
                                <c:forEach items="${order.orderItems}" var="item">
                                    <tr>
                                        <td style="border-bottom:1px;" width="100px">
                                            <c:forEach items="${item.product.picPath}" var="pic" begin="0" end="0">
                                                <img src="${pwk:getPicDomain()}/${pic.path}" alt="" width="80" height="80">
                                            </c:forEach>
                                        </td>
                                        <td style="border-bottom:1px;" width="100px"><s:text name="order.list.color"/>:${item.color.name}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                            </td>
                            <td class="quantity" style="width: 0">RM <fmt:formatNumber value="${order.totalPrice+order.shipPrice}" type="currency" pattern="###,##0.00"/></td>
                            <td class="unit-price">${order.status eq 1?'Paid':order.status eq 0?'Pending':order.status eq 2?'Cancelled':'Unknown'}</td>
                            <td class="quantity">
                                <c:if test="${order.status eq 0}">
                                    <a href="${pageContext.request.contextPath}/orderDetail_${order.id}.html" style="color: #0000ff"><s:text name="order.list.detail"/>(<s:text name="order.list.pay"/>)</a>
                                    <a href="javascript:if(confirm('Are you sure to cancel this order?')){window.location.href='${pageContext.request.contextPath}/order/cancelOrder.do?id=${order.id}'}" style="color: red"><s:text name="order.list.cancel"/></a>
                                </c:if>
                                <c:if test="${order.status eq 1}">
                                    <a href="${pageContext.request.contextPath}/orderDetail_${order.id}.html" style="color: #0000ff"><s:text name="order.list.detail"/></a>
                                </c:if>
                                <c:if test="${order.status eq 2}">
                                    <a href="${pageContext.request.contextPath}/orderDetail_${order.id}.html" style="color: #0000ff"><s:text name="order.list.detail"/></a>
                                    <a href="javascript:if(confirm('Are you sure to delete this order?')){window.location.href='${pageContext.request.contextPath}/order/deleteOrder.do?id=${order.id}'}" style="color: red"><s:text name="order.list.delete"/></a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <!-- Main End -->

            <br class="clear"/>

            <!-- List End -->

        </div>
        <div class="shadow"></div>

        <br class="clear"/>
    </div>

    <jsp:include page="include/bottom.jsp" flush="true"/>
</div>
<c:if test="${param.order eq 'add'}">
    <script type="text/javascript">
        alert("Thanks for order from myparisbags,we will contact you via phone or email soon.")
    </script>
</c:if>
<c:if test="${param.order eq 'noOrder'}">
    <script type="text/javascript">
        alert("Order dose not exist!");
    </script>
</c:if>
<c:if test="${param.order eq 'delete'}">
    <script type="text/javascript">
        alert("Delete order success!");
    </script>
</c:if>
<c:if test="${param.order eq 'cancel'}">
    <script type="text/javascript">
        alert("Cancel order success!");
    </script>
</c:if>
<c:if test="${param.order eq 'error'}">
    <script type="text/javascript">
        alert("error!");
    </script>
</c:if>

</body>
</html>