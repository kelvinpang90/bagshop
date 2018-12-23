<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getAttributeById(param.id)}" var="attribute"/>
<html>
<head>
  <title>Update Attribute</title>
  <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
  <script type="text/javascript">
    var amount = ${attribute.parameters.size()+1};
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
<form action="${pageContext.request.contextPath}/attribute/update.do" method="post" class="bs-example bs-example-form" role="form"
      id="theForm">
  <input type="hidden" name="id" value="${attribute.id}">
  <div class="input-group col-lg-3">
    <span class="input-group-addon">Attribute Name</span>
    <input type="text" name="name" id="name" class="form-control" value="${attribute.name}" placeholder="Size,Color...">
  </div>
  <br>
  <div class="input-group col-lg-3" id="parameters">
    <span class="input-group-addon">Parameters</span>
    <c:forEach items="${attribute.parameters}" var="parameter" varStatus="vs">
      <input type="text" name="p${vs.count}" id="p${vs.count}" value="${parameter.name}" class="form-control" placeholder="Big,Medium...">
      <input type="text" name="price${vs.count}" id="price${vs.count}" value="${parameter.additionalPrice}" class="form-control" placeholder="Additional Price...">
      <br>
    </c:forEach>
  </div>
  <br>
  <input type="submit" value="Confirm" class="btn btn-danger"/>
</form>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>