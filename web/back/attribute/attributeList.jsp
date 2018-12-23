<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Attributes List</title>
</head>
<body>
<div>
  <h4>Attributes List</h4>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
    <tr>
      <th>Id</th>
      <th>Attributes Name</th>
      <th>Parameters</th>
      <th>Operation</th>
    </tr>
    <c:forEach items="${pwk:getAttributeByList(param.p, param.s)}" var="attribute">
      <tr>
        <td class="td2">${attribute.id}</td>
        <td class="td2">${attribute.name}</td>
        <td class="td2">
          <c:forEach items="${attribute.parameters}" var="parameter">
            ${parameter.name}&nbsp;
          </c:forEach>
        </td>
        <td class="td2">
          <a href="attributeUpdate.jsp?id=${attribute.id}" class="btn btn-info">Update</a>
          <a href="javascript:if(confirm('sure to delete?')){window.location.href='${pageContext.request.contextPath}/attribute/delete.do?id=${attribute.id}'}" class="btn btn-danger">Delete</a>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>
<ul id="page"></ul>
<script>
  var options = {
    bootstrapMajorVersion:3,
    alignment: 'center',
    currentPage: ${empty param.p?1:param.p},
    totalPages: ${(total+20)/20},
    pageUrl: function (type, page, current) {
      return "${pageContext.request.contextPath}/back/user/userList.jsp?s=20&p=" + page;
    }
  };

  $('#page').bootstrapPaginator(options);
</script>
<jsp:include page="../exclude/message.jsp"/>
</body>
</html>