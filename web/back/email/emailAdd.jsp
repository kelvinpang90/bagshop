<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Promotion Email</title>
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-datetimepicker.css" rel="stylesheet">

</head>
<body>
<form action="${pageContext.request.contextPath}/timer/email.do" method="post" class="bs-example bs-example-form" onsubmit="return validateForm()"
      id="theForm">
  <div class="input-group col-lg-3">
    <span class="input-group-addon">Email Title</span>
      <input type="text" name="title" id="title" class="form-control" placeholder="Email Title">
  </div>
  <br>
  <div class="input-group date col-lg-3">
    <div class='input-group date' id='datetimepicker'>
      <input type='text' class="form-control" data-date-format="YYYY-MM-dd - HH:ii:ss" name="date" />
      <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
    </div>
  </div>
  <br>
  <div>
    <label class="control-label" for="description">Content</label>
    <textarea rows="30" cols="50" name="content" id="content"></textarea>
    <input type="hidden" name="description" id="description">
  </div>
  <script type="text/javascript">
    var editor;
    $(document).ready(function () {
      editor = CKEDITOR.replace('content');
    })
  </script>
  <br>
  <div class="control-group">
    <input type="submit" value="Save" class="btn btn-danger"/>
  </div>
</form>
<jsp:include page="../exclude/message.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
<script type="text/javascript">
  $(function () {
    $('#datetimepicker').datetimepicker({
      format: 'yyyy-MM-dd hh:mm:ss',
      language: 'zh-CN'
    });
  });
</script>
<script>
  function validateForm(){
    var title = $("#title");
    var projectTime = $("#date");
    var description = $("#description");
    description.attr("value", editor.document.getBody().getHtml());
    if(title.val()==""){
      alert("Please enter title");
      title.focus();
      return false;
    }
    if(projectTime.val()==""){
      alert("please select date");
      projectTime.focus();
      return false;
    }
    if (description == "") {
      alert("description can not be empty");
      return false;
    }
    return true;
  }
</script>
</body>

</html>