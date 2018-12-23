<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getProductBy_bId_cId_keyword(param.bId,param.cId,param.keyword, param.p, param.s,true)}" var="products"/>
<c:set value="${pwk:getTotalBy_bId_cId_keyword(param.bId,param.cId,param.keyword,true)}" var="total"/>
<c:set value="${pwk:getAllBrand()}" var="brands"/>
<c:set value="${pwk:getAllCategory()}" var="categories"/>
<html>
<head>
    <title>Product List</title>
    <link href="${pageContext.request.contextPath}/bootstrap/css/typeahead.css" rel="stylesheet">
</head>
<body>
    <div>
        <h4>Product List    <a href="productAdd.jsp" class="btn btn-danger">Add Product</a></h4>
        <div class="input-group col-lg-6">
            <select name="brandId" id="brandId" class="form-control" style="width:30%;">
                <option value="0" ${empty param.bId?'selected':''}></option>
                <c:forEach items="${brands}" var="brand">
                    <option value="${brand.id}" ${brand.id eq param.bId?'selected':''}>${brand.brandName}</option>
                </c:forEach>
            </select>
            <select name="categoryId" id="categoryId" class="form-control" style="width:30%;">
                <option value="0" ${empty param.cId?'selected':''}></option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.id}" ${category.id eq param.cId?'selected':''}>${category.name}</option>
                </c:forEach>
            </select>
            <input type="text" name="keyword" class="form-control" placeholder="keyword" value="${param.keyword}" id="keyword" style="width:30%;">
            <a class="btn btn-danger" href="javascript:searchProducts()">Search</a>
        </div>
        <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="table table-condensed table-striped table-hover">
            <tr>
                <th width="5%">Count</th>
                <th>Product Name</th>
                <th width="8%">Brand</th>
                <th width="5%">Category</th>
                <th width="8%">Picture</th>
                <th width="5%">Price</th>
                <th width="5%">Colors</th>
                <th width="8%">Attributes</th>
                <th width="8%">Refresh Time</th>
                <th width="27%">Operation</th>
            </tr>
            <c:forEach items="${products}" var="product" varStatus="vs">
                <tr>
                    <td class="td2">${vs.count}</td>
                    <td class="td2">
                        <a href="${pageContext.request.contextPath}/details_${product.id}.html" target="_blank">${product.name}</a>
                        <a href="http://wap.myparisbags.com/details_${product.id}.html" target="_blank" style="color: darkgreen">(mobile)</a>
                    </td>
                    <td class="td2">${product.brand.brandName}</td>
                    <td class="td2">${product.category.name}</td>
                    <td class="td2">
                        <c:forEach items="${product.picPath}" var="pic" begin="0" end="0">
                             <img src="${pwk:getPicOriDomain()}/${pic.miniPath}" style="height: 80px;width: 80px;"/>
                        </c:forEach>
                    </td>
                    <td class="td2">RM ${product.price}</td>
                    <td class="td2">
                        <c:forEach items="${product.colors}" var="color">
                            <c:forEach items="${color.picPath}" var="pic" begin="0" end="0">
                                <img src="${pwk:getPicOriDomain()}/${pic.path}" style="height: 15px;width: 15px;" title="${color.name}"/>
                            </c:forEach>
                        </c:forEach>
                    </td>
                    <td class="td2">
                        <c:forEach items="${product.attributes}" var="attribute">
                            ${attribute.name}:
                            <c:forEach items="${attribute.parameters}" var="parameter">
                                ${parameter.name}&nbsp;
                            </c:forEach>
                        </c:forEach>
                    </td>
                    <td class="td2">${product.updateDate}</td>
                    <td class="td2">
                        <a href="${pageContext.request.contextPath}/back/product/productUpdate.jsp?id=${product.id}" target="_blank"
                           class="btn btn-info">Modify</a>
                        <a href="${pageContext.request.contextPath}/product/refreshProduct.do?id=${product.id}"
                           class="btn btn-primary">Refresh</a>
                        <c:if test="${product.status eq 0}">
                            <a href="javascript:void(0)" onclick="onOff('${product.id}',1)"
                               class="btn btn-success">On</a>
                        </c:if>
                        <c:if test="${product.status eq 1}">
                            <a href="javascript:void(0)" onclick="onOff('${product.id}',0)"
                               class="btn btn-warning">Off</a>
                        </c:if>
                        <c:if test="${product.stockStatus eq 0}">
                            <a href="javascript:void(0)" onclick="stock('${product.id}',1)"
                               class="btn btn-success">Stock</a>
                        </c:if>
                        <c:if test="${product.stockStatus eq 1}">
                            <a href="javascript:void(0)" onclick="stock('${product.id}',0)"
                               class="btn btn-warning">Stockout</a>
                        </c:if>
                        <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/product/productDelete.do?id=${product.id}'}"
                           class="btn btn-danger">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

<ul id="page"></ul>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap3-typeahead.min.js"></script>
<script type='text/javascript'>
    var options = {
        bootstrapMajorVersion:3,
        alignment: 'center',
        currentPage: ${empty param.p?1:param.p},
        totalPages: ${(total+20)/20},
        numberOfPages: 20,
        pageUrl: function (type, page, current) {
            return "${pageContext.request.contextPath}/back/product/productList.jsp?s=20&p=" + page+"&bId=${param.bId}&cId=${param.cId}&keyword=${param.keyword}";
        }
    };

    $('#page').bootstrapPaginator(options);

    function searchProducts(){
        var bid = $("#brandId").val();
        var cid = $("#categoryId").val();
        var keyword = $("#keyword").val();
        window.location.href = "${pageContext.request.contextPath}/back/product/productList.jsp?bId="+bid+"&cId="+cid+"&keyword="+keyword;
    }

    $(document).ready(function(){
        $("#keyword").typeahead({
            delay:200,
            source:function(query,process){
                return $.ajax({
                    url: "/product/getProductName.do",
                    type: 'post',
                    data: { 'keyword': query },
                    dataType: 'json',
                    success: function (jsonResult) {
                        var resultList = jsonResult.map(function (item) {
                            var aItem = item.name;
                            return JSON.stringify(aItem).replace(/["']/g, "");
                        });
                        return process(resultList);
                    }
                });
            },
            autoSelect: true});
    });

    function onOff(id,status){
        $.post("${pageContext.request.contextPath}/product/setProductStatus.do",{'id':id,'status':status},function(data){
            window.location.reload();
        });
    }

    function stock(id,status){
        $.post("${pageContext.request.contextPath}/product/setStockStatus.do",{'id':id,'status':status},function(data){
            window.location.reload();
        });
    }
</script>


<jsp:include page="../exclude/message.jsp"/>
</body>
</html>