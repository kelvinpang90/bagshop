<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pwk:getIndexProductById(param.id)}" var="indexProduct"/>
<c:set value="${pwk:getAllBrand()}" var="brands"/>
<c:set value="${pwk:getProductByBrandId(indexProduct.product.brand.id,1 ,fn:length(brands) ,false )}" var="products"/>
<html>
<head>
    <title>Modify Index Product</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/indexProduct/updateIndexProduct.do" method="post" class="form-horizontal" id="theForm" onsubmit="return checkForm()">
        <input type="hidden" name="id" value="${indexProduct.id}">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand&Product</span>
            <select name="brandId" id="brandId" onchange="getProductByBrandId()" class="form-control">
                <option></option>
                <c:forEach items="${brands}" var="brand">
                    <option value="${brand.id}" ${(brand.id eq indexProduct.product.brand.id)?'selected':''}>${brand.brandName}</option>
                </c:forEach>
            </select>
            <span id="content">
                 <select name='productId' id='productId' class='form-control'>
                     <c:forEach items="${products}" var="product">
                         <option value="${product.id}" ${(product.id eq indexProduct.product.id)?'selected':''}>${product.name}</option>
                     </c:forEach>
                 </select>
            </span>
        </div>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Position</span>
            <input type="text" name="position" id="position" class="form-control" placeholder="1,2,3,4,5......" value="${indexProduct.position}">
        </div>
        <div class="form-search">
            <input type="submit" value="Confirm" class="btn btn-danger"/>
        </div>
    </form>
<jsp:include page="../exclude/message.jsp"/>
<script type="text/javascript">
    function checkForm() {
        var position = $("#position").val();
        if (position == "") {
            alert("position can not be empty");
            return false;
        }
        return true;
    }
    function getProductByBrandId() {
        $("#content").empty();
        var brandId = $("#brandId").val();
        if (brandId == "")
            return;
        $.post('${pageContext.request.contextPath}/product/getProductByBrandId.do', {'brandId': brandId}, function (data) {
            $("#content").append(data);
        },'html');
    }
</script>
</body>
</html>