<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
    if(navigator.platform.indexOf('Win32')!=-1||navigator.platform.indexOf('Mac')!=-1){

    }else{
        if('${pageContext.request.requestURI}'.indexOf("details")!=-1){
            window.location.href = "http://wap.myparisbags.com/details_${param.id}.html";
        }else{
            window.location.href = "http://wap.myparisbags.com${pageContext.request.requestURI}?${pageContext.request.queryString}";
        }
    }
</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-51323420-5', 'auto');
  ga('require', 'displayfeatures');
  ga('send', 'pageview');

</script>
<c:set value="${pwk:getUserByRequest(pageContext.request)}" var="user"/>
<div id="header-top">
    <p>
        ${pwk:getIndexInfoById(1).content}
    </p>
</div>

<div class="header-main">
    <div class="logo logoMessage">
        <a href="${pageContext.request.contextPath}/index.html" name="top">My Paris Bags</a>
    </div>

    <div class="login-block">
        <c:if test="${empty user}">
            <span class="account"><a href="${pageContext.request.contextPath}/register.html" class="account">Register</a></span>
            <span class="account"><a href="javascript:login()" class="account">Login</a></span>
        </c:if>
        <c:if test="${not empty user}">
            <span class="order"><a href="${pageContext.request.contextPath}/order.html" class="cart">My ParisBags</a></span>
            <span class="cart"><a href="${pageContext.request.contextPath}/cart.html" class="cart">Card (${pwk:getCountByUserId(pageContext.request)})</a></span>
            <span class="account"><a href="${pageContext.request.contextPath}/user/logout.do" class="account">Logout</a></span>
        </c:if>
    </div>
</div>

<div id="navigation">

    <div class="search-container">
        <div class="search-inner">
                <input type="text" id="keyword" value="${empty param.keyword||param.keyword eq '0'?'I am looking for...':param.keyword}" onfocus="if(this.value=='I am looking for...'){this.value=''};" onblur="if(this.value==''){this.value='I am looking for...'};" class="search-field" name="keyword" disabled>
                <input type="button" id="s_submit" value="" class="search-btn" onclick="setKeyword()" disabled>
        </div>
    </div>
    <div class="navigation-inner">
        <!-- Navigation start -->
        <ul class="sf-menu">
            <li class="nav-item"><a href="javascript:void(0)">Brands</a>
                <ul>
                    <c:forEach items="${pwk:getBrandsByStatus(1)}" var="brand">
                        <li class="sfish-navgiation-item">
                            <a href="${pageContext.request.contextPath}/grid_${brand.id}.html">${brand.brandName}</a>
                        </li>
                    </c:forEach>
                </ul>
            </li>
            <c:forEach items="${pwk:getAllCategory()}" var="category">
                <li>
                    <a href="${pageContext.request.contextPath}/grid_c_${category.id}.html">${category.name}</a>
                </li>
            </c:forEach>
            <li><a href="${pageContext.request.contextPath}/aboutUs.html">About Us</a> </li>
            <li><a href="${pageContext.request.contextPath}/review.html" style="color:wheat;">Customer Review</a> </li>
        </ul>
        <!-- Navigation end -->

    </div>

</div>
<script>
    function setKeyword(){
        var keyword = $("#keyword");
        if(keyword.val()=="I am looking for..."){
            keyword.attr("value","0");
        }
        self.location="${pageContext.request.contextPath}/grid__"+keyword.val()+".html";
    }
</script>
<jsp:include page="login.jsp" flush="true"/>