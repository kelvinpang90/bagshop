<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pwk:getHotSaleById(param.id)}" var="hotSale"/>
<c:set value="${pwk:getAllBrand()}" var="brands"/>
<c:set value="${pwk:getProductByBrandId(hotSale.product.brand.id,1 ,fn:length(brands) ,false )}" var="products"/>
<html>
<head>
    <title>Modify HotSale</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/hotSale/updateHotSale.do" method="post" class="form-horizontal" id="theForm" onsubmit="return checkForm()">
        <div class="input-group col-lg-3">
            <input type="hidden" name="id" value="${hotSale.id}">
            <span class="input-group-addon">Brand&Product</span>
            <select name="brandId" id="brandId" onchange="getProductByBrandId()" class="form-control">
                <option></option>
                <c:forEach items="${brands}" var="brand">
                    <option value="${brand.id}" ${(brand.id eq hotSale.product.brand.id)?'selected':''}>${brand.brandName}</option>
                </c:forEach>
            </select>
            <span id="content">
                <select name='productId' id='productId' class='form-control'>
                    <c:forEach items="${products}" var="product">
                        <option value="${product.id}" ${(product.id eq hotSale.product.id)?'selected':''}>${product.name}</option>
                    </c:forEach>
                </select>
            </span>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Position</span><input type="text" name="position" id="position" class="form-control" placeholder="1,2,3,4,5......" value="${hotSale.position}">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <input type="submit" value="Confirm" class="btn btn-danger"/>
        </div>
    </form>
<jsp:include page="../exclude/message.jsp"/>
    <script type="text/javascript">
        function getProductByBrandId() {
            $("#content").empty();
            var brandId = $("#brandId").val();
            if (brandId == "")
                return;
            $.post('${pageContext.request.contextPath}/product/getProductByBrandId.do', {'brandId': brandId}, function (data) {
                $("#content").append(data);
            },'html');
        }
        function checkForm() {
            var productId = $("#productId").val();
            var position = $("#position").val();
            if (productId == "") {
                alert("product can not be empty");
                return false;
            }
            if (position == "") {
                alert("position can not be empty");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>