<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getFAQByList()}" var="FAQs"/>
<html>
<head>
    <title>FAQ List</title>
</head>
<body>
    <div>
        <h4>FAQ List</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>Count</th>
                <th>Question</th>
                <th>Answer</th>
                <th>Operation</th>
            </tr>
            <c:forEach items="${FAQs}" var="faq" varStatus="vs">
                <tr>
                    <td class="td2">${vs.count}</td>
                    <td class="td2">${fn:substring(faq.question,0 ,50 )}</td>
                    <td class="td2">${fn:substring(faq.answer,0 ,50 )}</td>
                    <td class="td2">
                        <a href="${pageContext.request.contextPath}/back/faq/faqUpdate.jsp?id=${faq.id}" class="btn btn-danger">Modify</a>
                        <a href="javascript:if(confirm('sure to delete？')){window.location.href='${pageContext.request.contextPath}/faq/deleteFAQ.do?id=${faq.id}'}" class="btn btn-success">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>