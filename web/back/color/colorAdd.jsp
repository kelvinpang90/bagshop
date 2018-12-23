<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<html>
<head>
    <title>Add Color</title>
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
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=color',
                'onUploadSuccess': function (file, data, response) {
                    var json = eval ("(" + data + ")");
                    $("#pic").append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    $("#pic").append("<img src=" + "${pwk:getPicDomain()}/" + json.picPath + " style='width:150px;height:150px;'>");
                }
            });
        });
    </script>
</head>
<body>
    <form action="${pageContext.request.contextPath}/color/addColor.do" method="post" class="bs-example bs-example-form" role="form"
          id="theForm">
        <div class="input-group col-lg-3">
            <span class="input-group-addon">Color Name</span>
            <input type="text" name="color" id="color" class="form-control" placeholder="Color Name">
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