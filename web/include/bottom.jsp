<%@ page import="com.pwk.listener.OnlineListener" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<div id="footer">
    <div class="footer-main">

        <div class="back-to-top"><a href="#top"><img src="${pageContext.request.contextPath}/images/top.png" alt="Back to top" border="0"/></a></div>

        <div class="left-column float-left">
            <h5>FAQ</h5>

            <ul class="footer-nav">
                <c:forEach items="${pwk:getFAQByList()}" var="faq" varStatus="vs" begin="0" end="5">
                    <c:if test="${vs.count eq 1}">
                        <li class="first"><a href="faq_${faq.id}.html">${faq.question}</a></li>
                    </c:if>
                    <c:if test="${vs.count ne 1}">
                        <li><a href="faq_${faq.id}.html">${faq.question}</a></li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <div class="middle-column float-left">
            <h5>Copyright</h5>
            <p>&copy; Copyright reserved to <span style="color: #ce5d86"><a href="http://www.myparisbags.com">My Paris Bags</a></span><br>Design & develop by <span style="color: #ce5d86"><a href="http://www.mywebsitestudio.com">My Website Studio</a></span></p>
        </div>
        <div class="left-column float-right">
            <h5>Visitor</h5>
            <c:set value="${pwk:getPVSum()}" var="pv"/>
            <p>Online Users : <span style="color:#ce5d86"><%=session.getServletContext().getAttribute("online")%></span><br>
            You are the <span style="color:#ce5d86">${pv.get('date').get(0).get(0)+pv.get('date').get(0).get(1)}</span> visitor today</p>
        </div>
    </div>
</div>
<script type="application/javascript">
    $(document).ready(function(){
        $.post("/pv/add.do",{'page':'${pageContext.request.requestURI}','device':'pc'});
    });
</script>