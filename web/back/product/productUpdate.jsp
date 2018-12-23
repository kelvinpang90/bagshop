<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pwk:getAllBrand()}" var="brands"/>
<c:set value="${pwk:getAllCategory()}" var="categorys"/>
<c:set value="${pwk:getProductById(param.id,true)}" var="product"/>
<html>
<head>
    <title>Modify Product</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        function deleteDom(obj){
            var dom = $(obj).parent();
            dom.empty();
            dom.append("<div id='fileQueue'></div><input type='file' name='uploadify' id='uploadify'/>");
            $("#uploadify").uploadify({
                'id': 'uploadify',
                'fileObjName': 'uploadImages',
                'fileDesc': 'Image Files',
                'fileExt':'*.jpg;*.gif;*.jpeg;*.png;*.bmp',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=product',
                'uploadLimit' : 1,
                'onUploadSuccess': function (file, data, response) {
                    dom.empty();
                    var json = eval ("(" + data + ")");
                    dom.append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    dom.append("<img src=" + "${pwk:getPicOriDomain()}/" + json.picPath + " style='width:150px;height:150px;'>");
                    dom.append("<a href='javascript:void(0)' onclick='deleteDom(this)'>Delete</a>");
                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#uploadify1").uploadify({
                'id': 'uploadify1',
                'fileObjName': 'uploadImages',
                'fileExt':'*.jpg;*.gif;*.jpeg;*.png;*.bmp',
                'fileDesc': 'Image Files',
                'uploadLimit': ${4-fn:length(product.picPath)},
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=product',
                'onUploadSuccess': function (file, data, response) {
                    var json = eval ("(" + data + ")");
                    var picDom = $("#uploadify1").parent();
                    picDom.append("<div class='controls'><input type='hidden' name='picId' value='"+json.picId+"'/><img src=" + "${pwk:getPicOriDomain()}/" + json.picPath + " style='width:150px;height:150px;'> <a href='javascript:void(0)' onclick='deleteDom(this)'>Delete</a></div>");
                }
            });
        });
    </script>
</head>
<body>
    <form action="${pageContext.request.contextPath}/product/productUpdate.do" method="post"
          enctype="multipart/form-data" id="theForm" class="bs-example bs-example-form" role="form">
        <input type="hidden" name="id" value="${product.id}">

        <div class="input-group col-lg-7">
            <span class="input-group-addon">Product Name</span><input type="text" name="productName" id="productName" class="form-control" placeholder="Product Name" value="${product.name}">
        </div>
        <br>
        <div class="input-group col-lg-2">
            <span class="input-group-addon">Price RM:</span><input type="text" name="price" id="price" class="form-control" placeholder="Price" value="${product.price}">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand</span>
            <select name="brandId" id="brandId" class="form-control">
                <c:forEach items="${brands}" var="brand">
                    <option value="${brand.id}" ${product.brand.id==brand.id?'selected':''}>${brand.brandName}</option>
                </c:forEach>
            </select>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Category</span>
            <select name="categoryId" id="categoryId" class="form-control" onchange="getAttributeByCid();">
                <option></option>
                <c:forEach items="${categorys}" var="category">
                    <option value="${category.id}" ${product.category.id==category.id?'selected':''}>${category.name}</option>
                </c:forEach>
            </select>
        </div>
        <br>

        <div class="input-group" id="upload">
            <c:forEach items="${product.picPath}" var="pic">
                <div class="controls">
                    <input type="hidden" name="picId" value="${pic.id}">
                    <img src="${pwk:getPicOriDomain()}/${pic.path}" style="height: 150px;width: 150px;"/>
                    <a href="javascript:void(0)" onclick="deleteDom(this)">Delete</a>
                </div>
            </c:forEach>
            <c:if test="${fn:length(product.picPath) ne 4}">
                <div class="controls">
                    <div id='fileQueue'></div>
                    <input type='file' name='uploadify' id='uploadify1'/>
                </div>
            </c:if>
        </div>
        <br>

        <div class="input-group">
            <span class="input-group-addon">Color</span>
            <c:forEach items="${pwk:getAllColor()}" var="colors">
                <input type="checkbox" value="${colors.id}" name="colorId" <c:forEach items="${product.colors}" var="color"><c:if test="${color.id eq colors.id}">checked</c:if></c:forEach>/>
                ${colors.name}
                <c:forEach items="${colors.picPath}" var="pic" begin="0" end="0">
                    <img src="${pwk:getPicOriDomain()}/${pic.path}" style="height: 50px;width: 50px;"/>
                </c:forEach>&nbsp;
            </c:forEach>
        </div>
        <br>

        <input type="button" id="add" value="Add Attribute" class="btn btn-primary" onclick="addAttribute()"/>
        <br>
        <br>
        <div class="input-group  col-lg-5" id="attribute">
            <span class="input-group-addon">Attribute</span>
            <c:forEach items="${product.attributes}" var="attribute">
                <span>
                    <input type="hidden" name="attributeId" value="${attribute.id}">
                    ${attribute.name}:
                    <c:forEach items="${attribute.parameters}" var="parameter">
                        ${parameter.name}&nbsp;
                    </c:forEach>
                    <input type="button" value="Update" class="btn btn-warning" onclick="updateAttribute('${attribute.id}','${attribute.name}',this)"/>
                    <input type="button" value="Delete" class="btn btn-danger" onclick="deleteAttribute(${attribute.id},this)"/>
               </span>
            </c:forEach>
        </div>
        <br>

        <div class="control-group">
            <label class="control-label" for="content">Description</label>
        </div>
        <textarea rows="30" cols="50" name="content" id="content">${product.description}</textarea>
        <input type="hidden" name="description" id="description">
        <script type="text/javascript">
            var editor;
            $(document).ready(function () {
                editor = CKEDITOR.replace('content');
            })
        </script>
        <div class="form-search">
            <input type="submit" value="Confirm" class="btn btn-danger" onclick="return validateForm()"/>
        </div>
    </form>
<script type="text/javascript">
    function validateForm() {
        var productName = $("#productName").val();
        var price = $("#price").val();
        var type = $("#type").val();
        var brandId = $("#brandId").val();
        var description = $("#description");
        description.attr("value", editor.document.getBody().getHtml());
        if (productName == "") {
            alert("productName can not be empty");
            return false;
        }
        if (price == "") {
            alert("price can not be empty");
            return false;
        }
        if (type == "") {
            alert("type can not be empty");
            return false;
        }
        if (brandId == "") {
            alert("brand can not be empty");
            return false;
        }
        if (description.val() == "") {
            alert("description can not be empty");
            return false;
        }
        return true;
    }
</script>
    <script type="text/javascript">
        var amount = 1;
        function addAttribute() {
            $("#add").hide();
            var attribute = $("#attribute");
            attribute.append("<div>" +
            "<form action='/attribute/add.do' method='post' id='attributeForm'>" +
            "<span>" +
            "<input type='text' name='name' id='name' class='form-control' placeholder='Size,Pattern...' >" +
            "</span>" +
            "<span id='parameters'>" +
            "<span><input type='text' name='p" + amount + "' id='p" + amount + "' class='form-control' placeholder='Large,Medium...' style='width:50%'>" +
            "<input type='text' name='price" + amount + "' id='price" + amount + "' class='form-control' placeholder='Additional Price...'  style='width:50%'></span>" +
            "</span>" +
            "<input type='button' value='Add Parameter' class='btn btn-warning' onclick='addParameter()'/>" +
            "<input type='submit' value='Save Attribute' class='btn btn-success'/>" +
            "</form>" +
            "</div>");

            $("#attributeForm").ajaxForm({
                success: function (json, statusText, xhr, $form) {
                    if (json.state == 'ok') {
                        $("#attributeForm").remove();
                        $("#theForm").append(json.msg);
                        $("#attribute").append(json.url);
                        amount = 1;
                        alert("save attribute success");
                    } else {
                        alert("save attribute fail");
                        $("#msg").html("attribute save fail");
                    }
                    $("#add").show();
                },
                dataType: 'json'
            });
        }

        var amount1 = 1;
        function updateAttribute(attributeId,attributeName,obj){
            $.post("/attribute/getParameterByAid.do",{'attributeId':attributeId},function(data){
                $("#add").hide();
                $(obj).parent().remove();
                var str = "";
                str += "<div>" +
                "<form action='/attribute/update.do' method='post' id='attributeForm1'>" +
                "<span>" +
                "<input type='text' name='name' id='name' class='form-control' placeholder='Size,Pattern...' value='"+attributeName+"'>" +
                "<input type='hidden' name='id' id='id' value='"+attributeId+"' >" +
                "</span>" +
                "<span id='parameters'>";

                for(var i = 0; i<data.length;i++){
                    str +="<span><input type='text' name='p" + amount1 + "' id='p" + amount1 + "' class='form-control' placeholder='Large,Medium...' style='width:50%' value='"+data[i].name+"'> " +
                    "<input type='text' name='price" + amount1 + "' id='price" + amount1 + "' class='form-control' placeholder='Additional Price...'  style='width:50%' value='"+data[i].additionalPrice+"'></span>";
                    amount1++;
                }
                str += "</span>" +
                "<input type='button' value='Add Parameter' class='btn btn-warning' onclick='addParameter1()'/>" +
                "<input type='submit' value='Save Attribute' class='btn btn-success'/>" +
                "</form>" +
                "</div>";

                $("#attribute").append(str);
                $("#attributeForm1").ajaxForm({
                    success: function (json, statusText, xhr, $form) {
                        if (json.state == 'ok') {
                            $("#attributeForm1").remove();
                            $("#theForm").append(json.msg);
                            $("#attribute").append(json.url);
                            amount1 = 1;
                            alert("update attribute success");
                        } else {
                            alert("update attribute fail");
                        }
                        $("#add").show();
                    },
                    dataType: 'json'
                });
            },'json');
        }

        function deleteAttribute(attributeId,obj){
            if(confirm("sure to delete attribute?")){
                $.post("/attribute/delete.do",{'id':attributeId},function(data){
                    if(data.state == 'ok'){
                        $(obj).parent().remove();
                        alert("success");
                    }else{
                        alert("error occur, please contact administrator");
                    }
                },'json');
            }
        }

        function addParameter() {
            amount++;
            $("#parameters").append("<span><input type='text' name='p" + amount + "' id='p" + amount + "' class='form-control' placeholder='Big,Medium...' style='width:50%'>")
                    .append("<input type='text' name='price" + amount + "' id='price" + amount + "' class='form-control' placeholder='Additional Price...' style='width:50%'></span>").append("<br>");
        }

        function addParameter1() {
            $("#parameters").append("<span><input type='text' name='p" + amount1 + "' id='p" + amount1 + "' class='form-control' placeholder='Big,Medium...' style='width:50%'>")
                    .append("<input type='text' name='price" + amount1 + "' id='price" + amount1 + "' class='form-control' placeholder='Additional Price...' style='width:50%'></span>").append("<br>");
            amount1++;
        }
    </script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>