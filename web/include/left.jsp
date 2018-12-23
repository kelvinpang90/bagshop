<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div id="lhs" class="left-side float-left">
    <h3 class="active"><s:text name="product.brand"/></h3>
    <ul>
        <c:set value="${pwk:getBrandsByStatus(1)}" var="brands"/>
        <c:forEach items="${brands}" var="brand">
            <c:if test="${brand.id eq product.brand.id}">
                <li>${brand.brandName}</li>
            </c:if>
            <c:if test="${brand.id ne product.brand.id}">
                <li><a href="grid.html?bId=${brand.id}">${brand.brandName}</a></li>
            </c:if>
        </c:forEach>
    </ul>

    <%--<h3 class="active">Price Range</h3>--%>

    <!-- Price Slider Begin -->
    <div class="price-range">
        <fieldset>
            <label for="valueA">From:</label>
            <select name="valueA" id="valueA">
                <option value="$0">$0</option>
                <option value="$10">$10</option>
                <option value="$20">$20</option>
                <option value="$30" selected="selected">$30</option>
                <option value="$40">$40</option>
                <option value="$50">$50</option>
                <option value="$100">$100</option>
                <option value="$200">$200</option>
                <option value="$400">$400</option>
                <option value="$600">$600</option>
            </select>

            <label for="valueB">To:</label>
            <select name="valueB" id="valueB">
                <option value="$0">$0</option>
                <option value="$10">$10</option>
                <option value="$20">$20</option>
                <option value="$30">$30</option>
                <option value="$40">$40</option>
                <option value="$50">$50</option>
                <option value="$100" selected="selected">$100</option>
                <option value="$200">$200</option>
                <option value="$400">$400</option>
                <option value="$600">$600</option>
            </select>
        </fieldset>
    </div>
    <!-- Price Slider End -->

    <!-- Featured Products Begin -->
    <h3 class="active"><s:text name="product.recommend"/></h3>
    <c:set value="${pwk:getHotSaleByBrandId(product.brand.id,1 ,7 )}" var="hotSales"/>
    <div class="featured-product">
        <c:forEach items="${hotSales}" var="hotSale">
            <div class="featured-product-item">
                <a href="${pageContext.request.contextPath}/details_${hotSale.product.id}.html" class="float-left" target="_blank"><img src="${pageContext.request.contextPath}/${hotSale.product.pic}"  height="80px" width="80px" border="0" /></a>
                <span class="title"><a href="${pageContext.request.contextPath}/details_${hotSale.product.id}.html" target="_blank">${hotSale.product.name}</a></span>
                <span class="price">RM ${hotSale.product.price}</span>
            </div>
            <br class="clear"/>
        </c:forEach>
    </div>
    <!-- Featured Products Begin -->

</div>