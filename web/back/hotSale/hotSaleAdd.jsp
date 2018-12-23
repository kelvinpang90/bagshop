<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getAllBrand()}" var="brands"/>
<html>
<head>
    <title>Add HotSale</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/hotSale/addHotSale.do" method="post" class="bs-example bs-example-form" role="form" onsubmit="return checkForm()" id="theForm">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand&Product</span>
            <select name="brandId" id="brandId" onchange="getProductByBrandId()" class="form-control">
                <option></option>
                <c:forEach items="${brands}" var="brand">
                    <option value="${brand.id}">${brand.brandName}</option>
                </c:forEach>
            </select>
            <span id="content"></span>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Position</span><input type="text" name="position" id="position" class="form-control" placeholder="1,2,3,4,5......">
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