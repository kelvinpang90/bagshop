<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<c:set value="${pwk:getUserByRequest(pageContext.request)}" var="user"/>
<c:if test="${empty user}">
    <c:redirect url="${pageContext.request.contextPath}/index.html?t=login&url=/order.html"/>
</c:if>
<c:if test="${empty param.orderId}">
    <c:redirect url="${pageContext.request.contextPath}/order.html"/>
</c:if>
<c:set value="${pwk:getOrderById(param.orderId, pageContext.request)}" var="order"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Order Detail &middot; My Paris Bags</title>
    <!-- Main style -->
    <link rel="stylesheet" href="css/main.css" type="text/css" />

    <!-- Fancybox style -->
    <link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

    <!-- Product slider style -->
    <link rel="stylesheet" href="css/product-slider.css" type="text/css" />

    <!--[if IE 6]>
    <link rel="stylesheet" href="css/ie6.css" type="text/css" media="screen" />
    <![endif]-->

    <!-- Style for the superfish navigation menu -->
    <link rel="stylesheet" href="superfish/superfish.css" type="text/css" media="screen" />

    <!-- Style for Megamenu -->
    <link rel="stylesheet" href="css/megamenu.css" type="text/css" />

    <!-- Style for price range slider -->
    <link rel="stylesheet" href="jQueryUI/css/redmond/jquery-ui-1.7.1.custom.css" type="text/css" />
    <link rel="Stylesheet" href="jQueryUI/css/ui.slider.extras.css" type="text/css" />

    <!-- Google font -->
    <link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Qwigley' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css' />

    <!-- JS for jQuery -->
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

    <!-- JS for jQuery Product slider -->
    <script type="text/javascript" src="js/jquery.tools.min.js"></script>

    <!-- JS for jQuery Fancy Box -->
    <script type="text/javascript" src="fancybox/fancybox/jquery.fancybox-1.3.4.pack.js"></script>

    <!-- JS for superfish navigation menu -->
    <script type="text/javascript" src="superfish/hoverIntent.js"></script>
    <script type="text/javascript" src="superfish/superfish.js"></script>

    <!-- JS for price range slider -->
    <script type="text/javascript" src="jQueryUI/js/jquery-ui-1.7.1.custom.min.js"></script>
    <%--<script type="text/javascript" src="jQueryUI/js/selectToUISlider.jQuery.js"></script>--%>

    <!-- Style for product gallery -->
    <link href="exposure/exposure.css" type="text/css" rel="stylesheet" />

    <!-- JS for product gallery -->
    <script src="exposure/jquery.exposure.js" type="text/javascript"></script>

    <!-- JS for contact form -->
    <script src="js/jquery.validate.pack.js" type="text/javascript"></script>

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
                    <li><a href="index.html"><s:text name="navigate.home"/></a></li>
                    <li><a href="order.html"><s:text name="navigate.order.list"/></a></li>
                    <li class="last"><s:text name="navigate.detail"/></li>
                </ul>
                <br class="clear"/>
            </div>

            <!-- Main Begin -->

            <div class="full-width-content" style="margin:0 auto;">
                <h3><s:text name="order.detail.menu"/></h3>
                <br>
                <h2 style="color: #000000;text-align: center"><s:text name="order.detail.status"/>:
                    <c:if test="${order.status eq 0}">
                        <span style="color: #0000ff"><s:text name="order.detail.pending"/></span>
                    </c:if>
                    <c:if test="${order.status eq 1}">
                        <span style="color: green"><s:text name="order.detail.paid"/></span>
                    </c:if>
                    <c:if test="${order.status eq 2}">
                        <span style="color: red"><s:text name="order.detail.cancelled"/></span>
                    </c:if>
                </h2>
                <h5 style="text-align: center"><s:text name="order.detail.total_price"/>:RM:<fmt:formatNumber value="${order.totalPrice}" type="currency" pattern="###,##0.00"/>(<s:text name="order.detail.price"/>)+RM:<fmt:formatNumber value="${order.shipPrice}" type="currency" pattern="###,##0.00"/>(<s:text name="order.detail.shipping"/>)=RM: <fmt:formatNumber value="${order.totalPrice+order.shipPrice}" type="currency" pattern="###,##0.00"/></h5>
                <hr>
                <c:if test="${order.status eq 0}">
                    <form name="paypal" action="https://www.paypal.com/cgi-bin/websc" method="post" style="text-align: center">
                        <input type="image" name="submit" src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppppcmcvdam.png" alt="Pay with PayPal, PayPal Credit or any major credit card"/>
                        <input type="hidden" value="_ext-enter" name="cmd">
                        <input type="hidden" value="_xclick" name="redirect_cmd">
                        <input type="hidden" name="business" value="official@myparisbags.com">
                        <input type="hidden" value="official@myparisbags.com" name="receiver_email">
                        <input type="hidden" name="item_name" value="order information">
                        <input type="hidden" name="amount" value="${order.totalPrice}">
                        <input type="hidden" name="shipping" value="${order.shipPrice}">
                        <input type="hidden" value="MY" name="country">
                        <input type="hidden" name="currency_code" value="MYR">
                        <input type="hidden" value="http://www.myparisbags.com/logo/logo.png" name="cpp_header_image">
                        <input type="hidden" value="OrderId: ${order.id}" name="item_name">
                        <input type="hidden" value="${order.id}" name="item_number">
                        <input type="hidden" value="http://www.myparisbags.com/orderDetail_${order.id}.html" name="return">
                        <input type="hidden" value="http://www.myparisbags.com/order/paypalReturn.do?orderId=${order.id}" name="notify_url">
                        <input type="hidden" value="http://www.myparisbags.com/order.html" name="cancel_return">
                    </form>
                </c:if>
                    <div class="float-left" style="width: 450px;">
                        <span class="new-comment-heading"><s:text name="order.detail.delivery"/></span>
                        <!-- Form Begin -->
                        <div class="comment-form-container" id="contact-wrapper" >
                            <table>
                                <tr>
                                    <td><s:text name="order.detail.contact"/>:</td>
                                    <td>${order.fullName}</td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.phone"/>:</td>
                                    <td>${order.phone}</td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.country"/>:</td>
                                    <td>${pwk:getCountryById(order.country).name}</td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.state"/>:</td>
                                    <td>${pwk:getStateById(order.state).name}</td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.address"/>:</td>
                                    <td>${order.address}</td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.shipping"/>:</td>
                                    <td>RM <fmt:formatNumber value="${order.shipPrice}" type="currency" pattern="###,##0.00"/></td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.company"/>:</td>
                                    <td>${order.deliverCompany}</td>
                                </tr>
                                <tr>
                                    <td><s:text name="order.detail.tracking"/>:</td>
                                    <td>${order.trackingNo}</td>
                                </tr>
                            </table>
                        </div>
                        <!-- Form End -->

                    </div>

                    <div class="float-right address" style="width: 500px;">
                        <span class="new-comment-heading"><s:text name="order.detail.detail"/></span>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2"><s:text name="order.detail.name"/></td>
                                <td><s:text name="order.detail.color"/></td>
                                <td><s:text name="order.detail.price"/></td>
                            </tr>
                            <c:forEach items="${order.orderItems}" var="item">
                                <tr>
                                    <td>${item.product.name}</td>
                                    <td>
                                        <c:forEach items="${item.product.picPath}" var="pic" begin="0" end="0">
                                            <img src="${pwk:getPicDomain()}/${pic.path}" height="80px" width="80px"/>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <c:forEach items="${item.color.picPath}" var="pic" begin="0" end="0">
                                            <img src="${pwk:getPicDomain()}/${pic.path}" height="20px" width="20px"/>
                                        </c:forEach>
                                    </td>
                                    <td>RM<fmt:formatNumber value="${item.product.price}" type="currency" pattern="###,##0.00"/></td>
                                </tr>
                            </c:forEach>
                        </table>
                        <br class="clear"/>
                    </div>
                    <br class="clear"/>
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
</body>
</html>
<%--<jsp:include page="paymentOption.jsp" flush="true"/>--%>