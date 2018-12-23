<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Add Category</title>
  <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/category/add.do" method="post" class="bs-example bs-example-form" role="form"
      id="theForm">
  <div class="input-group col-lg-3">
    <span class="input-group-addon">Category Name</span>
    <input type="text" name="name" id="name" class="form-control" placeholder="Bag,Shoe...">
  </div>
  <br>

  <div class="input-group col-lg-3">
    <span class="input-group-addon">Parent Category</span>
    <select name="categoryId" id="categoryId" class="form-control" onchange="getAttributeByCid()">
      <option value=""></option>
      <c:forEach items="${pwk:getAllCategory()}" var="category">
        <option value="${category.id}">${category.name}</option>
      </c:forEach>
    </select>
  </div>
  <br>
  <input type="submit" value="Confirm" class="btn btn-danger"/>
</form>
<jsp:include page="../exclude/message.jsp"/>
<script>
  function getAttributeByCid(){
    $("#attribute").empty();
    $.post('/category/getFeasibleAttributes.do',{categoryId:$("#categoryId").val()},function(data){
      $("#attribute").append(data);
    },'html');
  }
</script>
</body>
</html>