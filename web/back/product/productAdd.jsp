<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getAllBrand()}" var="brands"/>
<c:set value="${pwk:getAllCategory()}" var="categorys"/>
<html>
<head>
    <title>Add Product</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#uploadify").uploadify({
                'id': 'uploadify',
                'fileObjName': 'uploadImages',
                'fileExt':'*.jpg;*.gif;*.jpeg;*.png;*.bmp',
                'fileDesc': 'Image Files',
                'uploadLimit': 4,
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=product',
                'onUploadSuccess': function (file, data, response) {
                    var json = eval ("(" + data + ")");
                    $("#pic").append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    $("#pic").append("<img src=" + "${pwk:getPicOriDomain()}/" + json.picPath + " style='width:150px;height:150px;'>");
                }
            });
        });
    </script>
</head>
<body>
    <form action="${pageContext.request.contextPath}/product/productAdd.do" method="post" enctype="multipart/form-data"
          id="theForm" name="theForm" class="bs-example bs-example-form" role="form">

        <div class="input-group col-lg-7">
            <span class="input-group-addon">Product Name</span> <input type="text" name="productName" id="productName" class="form-control" placeholder="Product Name">
        </div>
        <br>
        <div class="input-group col-lg-2">
                <span class="input-group-addon">Price RM:</span><input type="text" name="price" id="price" class="form-control" placeholder="Price">
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand</span>
            <select name="brandId" id="brandId" class="form-control">
                <option value=""></option>
                <c:forEach items="${brands}" var="brand">
                    <option value="${brand.id}">${brand.brandName}</option>
                </c:forEach>
            </select>
        </div>
        <br>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Category</span>
            <select name="categoryId" id="categoryId" class="form-control">
                <option value=""></option>
                <c:forEach items="${categorys}" var="category">
                    <option value="${category.id}">${category.name}</option>
                </c:forEach>
            </select>
        </div>
        <br>
        <div class="input-group">
            <span class="input-group-addon">Picture</span>
            <div class="controls">
                <div id="fileQueue"></div>
                <input type="file" name="uploadify" id="uploadify"/>
            </div>
            <div class="controls" id="pic"></div>
        </div>
        <br>

        <div class="input-group">
            <span class="input-group-addon">Color</span>
            <c:forEach items="${pwk:getAllColor()}" var="color">
                <input type="checkbox" value="${color.id}" name="colorId">${color.name}
                <c:forEach items="${color.picPath}" var="pic" begin="0" end="0">
                    <img src="${pwk:getPicOriDomain()}/${pic.path}" style="height: 50px;width: 50px;"/>
                </c:forEach>&nbsp;
                &nbsp;
            </c:forEach>
        </div>
        <br>

        <div class="input-group  col-lg-3" id="attribute">
            <span class="input-group-addon">Attribute</span>
            <input type="button" id="add" value="Add Attribute" class="btn btn-primary" onclick="addAttribute()"/>
        </div>
        <br>

        <div>
            <label class="control-label" for="description">Description</label>
            <textarea rows="30" cols="50" name="content" id="content"></textarea>
            <input type="hidden" name="description" id="description">
        </div>
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

        function addParameter() {
            amount++;
            $("#parameters").append("<span><input type='text' name='p" + amount + "' id='p" + amount + "' class='form-control' placeholder='Large,Medium...' style='width:50%'>")
                    .append("<input type='text' name='price" + amount + "' id='price" + amount + "' class='form-control' placeholder='Additional Price...' style='width:50%'></span>").append("<br>");
        }
    </script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>