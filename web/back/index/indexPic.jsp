<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getIndexPicById(1)}" var="pic1"/>
<c:set value="${pwk:getIndexPicById(2)}" var="pic2"/>
<c:set value="${pwk:getIndexPicById(3)}" var="pic3"/>
<c:set value="${pwk:getIndexPicById(4)}" var="pic4"/>
<html>
<head>
    <title>Rotation Picture</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
</head>
<body>
    <form action="${pageContext.request.contextPath}/indexPic/updateIndexPic.do" method="post" class="form-horizontal"
          id="theForm">
        <div class="control-group">
            <label class="control-label" for="description1">Rotation Picture(1)</label>

            <div class="controls">
                <input type="text" name="description1" id="description1" class="input-medium" placeholder="description">
            </div>

            <div class="control-group" id="upload1">
                <label class="control-label" for="uploadify1">Picture</label>
                <input type="hidden" id="picPath1" name="picPath1">
                <div class="controls" id="pic">
                        <c:if test="${empty pic1}">
                            <div id="fileQueue1"></div>
                            <input type="file" name="uploadify1" id="uploadify1"/>
                        </c:if>
                        <c:if test="${not empty pic1}">
                            <c:forEach items="${pwk:getPics(pic1.pic)}" var="picPath">
                                <img src="${pageContext.request.contextPath}/${picPath}" width="75px" height="33px"/>
                            </c:forEach>
                            <a href="javascript:deletePic()">Delete</a>
                        </c:if>
                </div>
                <div class="controls" id="pic1"></div>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="description2">Rotation Picture(2)</label>

            <div class="controls">
                <input type="text" name="description2" id="description2" class="input-medium" placeholder="description">
            </div>

            <div class="control-group" id="upload2">
                <label class="control-label" for="uploadify2">Picture</label>
                <input type="hidden" id="picPath2" name="picPath2">
                <div class="controls">
                    <div id="fileQueue2"></div>
                    <input type="file" name="uploadify2" id="uploadify2"/>
                </div>
                <div class="controls" id="pic2"></div>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="description3">Rotation Picture(3)</label>

            <div class="controls">
                <input type="text" name="description3" id="description3" class="input-medium" placeholder="description">
            </div>

            <div class="control-group" id="upload3">
                <label class="control-label" for="uploadify3">Picture</label>
                <input type="hidden" id="picPath3" name="picPath3">
                <div class="controls">
                    <div id="fileQueue3"></div>
                    <input type="file" name="uploadify3" id="uploadify3"/>
                </div>
                <div class="controls" id="pic3"></div>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="description3">Rotation Picture(4)</label>

            <div class="controls">
                <input type="text" name="description4" id="description4" class="input-medium" placeholder="description">
            </div>

            <div class="control-group" id="upload4">
                <label class="control-label" for="uploadify4">Picture</label>
                <input type="hidden" id="picPath4" name="picPath4">
                <div class="controls">
                    <div id="fileQueue4"></div>
                    <input type="file" name="uploadify4" id="uploadify4"/>
                </div>
                <div class="controls" id="pic4"></div>
            </div>
        </div>
        <div class="form-search">
            <input type="submit" value="Confirm" class="btn btn-danger" />
        </div>
    </form>
<jsp:include page="../exclude/message.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#uploadify1").uploadify({
            'fileObjName': 'uploadify1',
            'fileTypeDesc':'*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
            'uploadLimit': 3,
            'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            'uploader': '${pageContext.request.contextPath}/indexPicUpload',
            'onUploadSuccess': function (file, data, response) {
                $("#msg").html("upload picture success！");
                $("#infoModal").modal();
                var picPath = $("#picPath1").val();
                picPath += data;
                $("#picPath1").attr("value",picPath);
                $("#pic1").append("<img src=" + "${pageContext.request.contextPath}/" + data + " width='75px' height='33px'>");
            }
        });
        $("#uploadify2").uploadify({
            'fileObjName': 'uploadify2',
            'fileTypeDesc':'*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
            'uploadLimit': 3,
            'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            'uploader': '${pageContext.request.contextPath}/indexPicUpload',
            'onUploadSuccess': function (file, data, response) {
                $("#msg").html("upload picture success！");
                $("#infoModal").modal();
                var picPath = $("#picPath2").val();
                picPath += data;
                $("#picPath2").attr("value",picPath);
                $("#pic2").append("<img src=" + "${pageContext.request.contextPath}/" + data + " width='75px' height='33px'>");
            }
        });
        $("#uploadify3").uploadify({
            'fileObjName': 'uploadify3',
            'fileTypeDesc':'*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
            'uploadLimit': 3,
            'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            'uploader': '${pageContext.request.contextPath}/indexPicUpload',
            'onUploadSuccess': function (file, data, response) {
                $("#msg").html("upload picture success！");
                $("#infoModal").modal();
                var picPath = $("#picPath3").val();
                picPath += data;
                $("#picPath3").attr("value",picPath);
                $("#pic3").append("<img src=" + "${pageContext.request.contextPath}/" + data + " width='75px' height='33px'>");
            }
        });
        $("#uploadify4").uploadify({
            'fileObjName': 'uploadify4',
            'fileTypeDesc':'*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
            'uploadLimit': 3,
            'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            'uploader': '${pageContext.request.contextPath}/indexPicUpload',
            'onUploadSuccess': function (file, data, response) {
                $("#msg").html("upload picture success！");
                $("#infoModal").modal();
                var picPath = $("#picPath4").val();
                picPath += data;
                $("#picPath4").attr("value",picPath);
                $("#pic4").append("<img src=" + "${pageContext.request.contextPath}/" + data + " width='75px' height='33px'>");
            }
        });
    });
    function deletePic(obj){
        if(obj == 1){
            $("#pic1").empty();
            $("#picPath1").attr("value", "");
            $("#upload1").append("<div class='controls' id='upload'> <div id='fileQueue'></div><input type='file' name='uploadify' id='uploadify'/></div>");
        }
    }
</script>
</body>
</html>