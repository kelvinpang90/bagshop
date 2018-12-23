<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pwk:getBrandById(param.id)}" var="brand"/>
<html>
<head>
    <title>Modify Brand</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#uploadify").uploadify({
                'id': 'uploadify',
                'fileObjName': 'uploadImages',
                'fileExt':'*.jpg;*.gif;*.jpeg;*.png;*.bmp',
                'fileDesc': 'Image Files',
                'uploadLimit': 1,
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=brand',
                'onUploadSuccess': function (file, data, response) {
                    var json = eval ("(" + data + ")");
                    $("#pic").append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    $("#pic").append("<img src=" + "${pwk:getPicDomain()}/" + json.picPath + " style='width:200px;height:100px;'>");
                }
            });
        });

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
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=brand',
                'uploadLimit' : 1,
                'onUploadSuccess': function (file, data, response) {
                    dom.empty();
                    var json = eval ("(" + data + ")");
                    dom.append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    dom.append("<img src=" + "${pwk:getPicDomain()}/" + json.picPath + " style='width:200px;height:100px;'>");
                    dom.append("<a href='javascript:void(0)' onclick='deleteDom(this)'>Delete</a>");
                }
            });
        }
    </script>
</head>
<body>
    <form action="${pageContext.request.contextPath}/brand/brandUpdate.do" method="post" class="form-horizontal"
          id="theForm">
        <input type="hidden" name="id" value="${brand.id}">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand Name</span>
            <input type="text" name="brandName" id="name" class="form-control" placeholder="Brand Name" value="${brand.brandName}">
        </div>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand Order</span>
            <input type="text" name="order" id="order" class="form-control" placeholder="Brand Order" value="${brand.position}">
        </div>
        <div class="control-group" id="upload">
            <c:forEach items="${brand.picPath}" var="pic">
                <div class="controls">
                    <input type="hidden" name="picId" value="${pic.id}">
                    <img src="${pwk:getPicDomain()}/${pic.path}" style="height: 100px;width: 200px;"/>
                    <a href="javascript:void(0)" onclick="deleteDom(this)">Delete</a>
                </div>
            </c:forEach>
            <c:if test="${fn:length(brand.picPath) eq 0}">
                <div class="control-group">
                    <div class="controls">
                        <div id="fileQueue"></div>
                        <input type="file" name="uploadify" id="uploadify"/>
                    </div>
                    <div class="controls" id="pic"></div>
                </div>
            </c:if>
        </div>
        <input type="submit" value="Confirm" class="btn btn-danger"/>
    </form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>