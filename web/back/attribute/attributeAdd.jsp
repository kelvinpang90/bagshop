<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<html>
<head>
  <title>Add Attribute</title>
  <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
  <script type="text/javascript">
    var amount = 2;
    $(document).ready(function () {
        $("#add").bind('click',function(){
          if(amount<=10){
            $("#parameters").append("<input type='text' name='p"+amount+"' id='p"+amount+"' class='form-control' placeholder='Big,Medium...'>")
                    .append("<input type='text' name='price"+amount+"' id='price"+amount+"' class='form-control' placeholder='Additional Price...'>").append("<br>");
            amount++;
          }else{
            alert("Maximum parameter is 10");
          }
        });
    });
  </script>
</head>
<body>
<form action="${pageContext.request.contextPath}/attribute/add.do" method="post" class="bs-example bs-example-form" role="form"
      id="theForm">
  <div class="input-group col-lg-3">
    <span class="input-group-addon">Attribute Name</span>
    <input type="text" name="name" id="name" class="form-control" placeholder="Size,Color...">
  </div>
  <br>
  <div class="input-group col-lg-3" id="parameters">
    <span class="input-group-addon">Parameters</span>
    <input type="text" name="p1" id="p1" class="form-control" placeholder="Big,Medium...">
    <input type="text" name="price1" id="price1" class="form-control" placeholder="Additional Price...">
  </div>
  <input type="button" id="add" value="Add" class="btn btn-default"/>
  <br>
  <input type="submit" value="Confirm" class="btn btn-danger"/>
</form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>