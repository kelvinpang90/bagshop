<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set value="${pwk:getUserByRequest(pageContext.request)}" var="user"/>
<c:if test="${empty user}">
    <c:redirect url="${pageContext.request.contextPath}/index.html?t=login&url=/cart.html"/>
</c:if>
<c:set value="${pwk:getShoppingCartByUserId(pageContext.request)}" var="carts"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Shopping Cart &middot; My Paris Bags</title>
<!-- Main style -->
<link rel="stylesheet" href="css/main.css" type="text/css" />

<!-- Fancybox style -->
<link rel="stylesheet" href="fancybox/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

<!-- Product slider style -->
<link rel="stylesheet" href="css/product-slider.css" type="text/css" />

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
					<li><a href="index.html">Home</a></li>
					<li class="last">Shopping Cart</li>
				</ul>
				<br class="clear"/>
			</div>
			
			<!-- Main Begin -->
			
			<div class="full-width-content">
				<h3>Shopping Cart</h3>
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td class="remove"><span class="heading">Remove</span></td>
						<td class="thumbnail" width="200px"></td>
						<td class="product-name" style="text-align: center"><span class="heading">Products</span></td>
						<td class="product-name" style="text-align: center"><span class="heading">Attributes</span></td>
						<td class="quantity"><span class="heading">Color</span></td>
						<td class="price"><span class="heading">Price</span></td>
					</tr>
                    <c:forEach items="${carts}" var="cart">
                        <tr>
                            <td class="remove"><a href="javascript:void(0)" onclick="removeCart(this,${cart.id})"><img src="images/delete_icon.png" border="0"/></a></td>
                            <td class="thumbnail" width="200px" style="text-align: right"><a href="details_${cart.product.id}.html" target="_blank">
                                <c:forEach items="${cart.product.picPath}" var="pic" begin="0" end="0">
                                    <img src="${pwk:getPicDomain()}/${pic.miniPath}" style="width: 80px;height: 80px;"/>
                                </c:forEach>
                            </a></td>
                            <td class="product-name" style="text-align: center"><a href="details_${cart.product.id}.html" target="_blank">${cart.product.name}</a> </td>
                            <td class="product-name" style="text-align: center" id="attribute">
								<c:forEach items="${pwk:StringToJsonArray(cart.attributes)}" var="attribute">
									${attribute.name}:${attribute.value}
									<br>
								</c:forEach>
							</td>
                            <td class="quantity">
                                <c:forEach items="${cart.color.picPath}" var="pic" begin="0" end="0">
                                     <img src="${pwk:getPicDomain()}/${pic.path}" alt="${cart.color.name}" style="width: 30px;height: 30px;" title="${cart.color.name}">
                                </c:forEach>
                            </td>
                            <td class="price">RM <fmt:formatNumber value="${cart.product.price+cart.additionalPrice}" type="currency" pattern="###,##0.00"/></td>
                        </tr>
                    </c:forEach>
					<tr class="promo">
						<td colspan="4" class="unit-price"></td>
						<td class="quantity"></td>
						<td class="price"></td>
					</tr>
					<tr>
						<td colspan="4" class="unit-price"></td>
						<td class="quantity"><span class="summary">Total</span></td>
						<td class="price"><span class="summary">RM <fmt:formatNumber value="${pwk:getTotalPriceByUser(pageContext.request)}" type="currency" pattern="###,##0.00"/></span></td>
					</tr>
					<tr class="last submit">
						<td colspan="5" class="unit-price"></td>
						<td class="price">
							<a href="${pageContext.request.contextPath}/orderConfirm.html" class="general-button-big cart-button"><span class="button-big">Check Out</span></a>
						</td>
					</tr>
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

</body>
</html>