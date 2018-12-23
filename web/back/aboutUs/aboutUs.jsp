<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<html>
<head>
    <title>AboutUs</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
</head>
<body>
    <form method="post" action="${pageContext.request.contextPath}/aboutUs/update.do" id="theForm">
        <div class="control-group">
            <label class="control-label" for="content">AboutUs</label>
            <div class="controls">
            </div>
        </div>
        <div>
            <label class="control-label" for="description">Description</label>
            <textarea rows="30" cols="50" name="description" id="description">${pwk:getAboutUs().content}</textarea>
            <input type="hidden" name="content" id="content">
        </div>
        <script type="text/javascript">
            var editor;
            $(document).ready(function () {
                editor = CKEDITOR.replace('description');
            })
        </script>
        <div class="form-search">
            <input type="submit" value="confirm" class="btn btn-danger" onclick="return beforeSubmit()"/>
        </div>
    </form>
<script type="text/javascript">
    function beforeSubmit(){
        $("#content").attr("value",editor.document.getBody().getHtml()) ;
        var content = $("#content").val();
        if (content == "") {
            alert("can not be empty");
            return false;
        }
        return true;
    }
</script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>