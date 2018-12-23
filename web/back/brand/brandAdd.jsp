<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<html>
<head>
    <title>Add Brand</title>
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
    </script>
</head>
<body>
    <form action="${pageContext.request.contextPath}/brand/brandAdd.do" method="post" class="bs-example bs-example-form" role="form"
          id="theForm">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand Name</span>
            <input type="text" name="name" id="name" class="form-control" placeholder="Brand Name">
        </div>
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Brand Order</span>
            <input type="text" name="order" id="order" class="form-control" placeholder="Brand Order">
        </div>
        <br>
        <div class="control-group">
            <div class="controls">
                <div id="fileQueue"></div>
                <input type="file" name="uploadify" id="uploadify"/>
            </div>
            <div class="controls" id="pic"></div>
        </div>
        <input type="submit" value="Confirm" class="btn btn-danger"/>
    </form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>