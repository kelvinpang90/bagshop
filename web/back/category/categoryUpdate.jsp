<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getCategoryById(param.id)}" var="category"/>
<html>
<head>
  <title>Update Category</title>
  <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/category/update.do" method="post" class="bs-example bs-example-form" role="form"
      id="theForm">
  <input type="hidden" name="id" value="${category.id}">

  <div class="input-group col-lg-3">
    <span class="input-group-addon">Category Name</span>
    <input type="text" name="name" id="name" class="form-control" value="${category.name}" placeholder="Bag,Shoe...">
  </div>
  <br>
  <div class="input-group col-lg-3">
    <span class="input-group-addon">Parent Category</span>
    <select name="categoryId" id="categoryId" class="form-control" onchange="getAttributeByCid()">
      <option value=""></option>
      <c:forEach items="${pwk:getAllCategory()}" var="category1">
        <c:if test="${category1.id ne category.id}">
          <option value="${category1.id}" ${category1.id eq category.parentId?'selected':''}>${category1.name}</option>
        </c:if>
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