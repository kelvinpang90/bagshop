<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<c:set value="${pwk:getOrderById(param.id,pageContext.request)}" var="order"/>
<html>
<head>
    <title>Order Detail</title>
</head>
<body>
    <div class="control-group">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Order Id</span>
            <input type="text" name="id" id="id" class="form-control" value="${order.id}" disabled>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Order Date</span>
            <input type="text" name="createDate" id="createDate" class="form-control" value="${order.createDate}"
                   disabled>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Full Name</span>
            <input type="text" name="fullName" id="fullName" class="form-control" value="${order.fullName}" disabled>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Phone</span>
            <input type="text" name="phone" id="phone" class="form-control" value="${order.phone}" disabled>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Country</span>
            <select id="country" name="country" class="form-control">
                <option></option>
            </select>
        </div>
        <br>
        <div class="input-group col-lg-3" id="stateDiv">
            <span class="input-group-addon">State</span>
            <select id="state" name="state" class="form-control">
                <option></option>
            </select>
        </div>
        <br>
        <div class="input-group col-lg-6">
            <span class="input-group-addon">Address</span>
            <input type="text" name="address" id="address" class="form-control" value="${order.address}" disabled>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Email</span>
            <input type="text" name="email" id="email" class="form-control" value="${order.email}" disabled>
        </div>
        <br>
    </div>
    <div class="controls">
        <label class="control-label">Product</label>
    </div>
    <div class="controls">
        <table width="50%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Name</th>
                <th>Picture</th>
                <th>Price</th>
                <th>Color</th>
                <th>Attributes</th>
                <th>Additional Price</th>
            </tr>
            <c:forEach items="${order.orderItems}" var="item">
                <tr>
                <td><a href="${pageContext.request.contextPath}/details_${item.product.id}.html" target="_blank">${item.product.name}</a> </td>
                <td>
                    <c:forEach items="${item.product.picPath}" var="pic" begin="0" end="0">
                        <img src="${pwk:getPicDomain()}/${pic.miniPath}" height="80px" width="80px"/>
                    </c:forEach>
                </td>
                <td>RM ${item.product.price}</td>
                <td>${item.color.name}</td>
                <td>
                    <c:forEach items="${pwk:StringToJsonArray(item.attributes)}" var="attribute">
                        ${attribute.name}:${attribute.value}<br>
                    </c:forEach>
                </td>
                    <td>RM ${item.additionalPrice}</td>
                </tr>
            </c:forEach>
        </table>
        <c:if test="${order.status eq 0}">
            <div class="input-group col-lg-9">
                <label class="control-label" for="totalPrice">Total Price:</label>
                <div class="input-group col-lg-9">
                    <span class="input-group-addon">RM</span>
                    <input type="text" name="totalPrice" id="totalPrice" class="form-control" value="${order.totalPrice}">
                    <span class="input-group-addon">+RM</span>
                    <input type="text" name="shipPrice" id="shipPrice" class="form-control" value="${order.shipPrice}"/>
                    <span class="input-group-addon">=RM${order.totalPrice+order.shipPrice}</span>
                </div>
                <a href="javascript:changePrice()" class="btn btn-danger">Save</a>
            </div>
        </c:if>
        <c:if test="${order.status eq 1}">
            <div class="input-group col-lg-9">
                <span class="input-group-addon">Delivery Company:</span>
                <input name="deliveryCompany" id="deliveryCompany" type="text" class="form-control" value="${empty order.deliverCompany?'Poslaju':order.deliverCompany}"><br>
                <span class="input-group-addon">Tracking Number:</span>
                <input type="text" name="trackingNumber" id="trackingNumber" value="${order.trackingNo}" class="form-control">
            </div>
            <a href="javascript:changeDeliveryInfo()" class="btn btn-danger">Save</a>
        </c:if>
    </div>
<jsp:include page="../exclude/message.jsp"/>
<script>
    $(document).ready(function(){
        $.post("/location/loadCountry.do",{"countryId":${empty order.user.country?0:order.user.country}},function(data){
            $("#country").append(data);
        },"html");
        $.post("/location/loadState.do",{"countryId":${empty order.user.country?0:order.user.country},"userId":${order.user.id}},function(data){
            $("#state").empty().append(data);
            $("#stateDiv").show();
        },"html");
    });
    function changePrice(){
        var totalPrice = $("#totalPrice").val();
        var shipPrice = $("#shipPrice").val();
        $.post("/order/changePriceByAdmin.do",{"id":${param.id},"totalPrice":totalPrice,"shipPrice":shipPrice},function(data){
            if(data == "ok"){
                alert("success");
            }else{
                alert(data);
            }
        });
    }
    function changeDeliveryInfo(){
        var deliveryCompanyId = $("#deliveryCompanyId").val();
        var deliveryCompany = $("#deliveryCompany").val();
        var trackingNumber = $("#trackingNumber").val();
        $.post("/order/changeDeliveryInfoByAdmin.do",{"id":${param.id},"deliveryCompanyId":deliveryCompanyId,"deliveryCompany":deliveryCompany,"trackingNumber":trackingNumber},function(data){
            if(data == "ok"){
                alert("success");
            }else{
                alert(data);
            }
        });
    }
</script>
</body>
</html>