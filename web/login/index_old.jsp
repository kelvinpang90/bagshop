<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.getSession().removeAttribute("admin");
%>
<html>
<head>
    <title>Login</title>
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }
        .form-signin {
            max-width: 300px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            box-shadow: 0 1px 2px rgba(0,0,0,.05);
        }
        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }
        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }
    </style>
    <script src="<%=request.getContextPath()%>/bootstrap/js/jquery.js"></script>
</head>
<body>
<div class="container">

    <form class="form-signin" action="<%=request.getContextPath()%>/admin/login.do" method="post" id="theForm">
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="text" class="input-block-level" placeholder="loginName" name="loginName">
        <input type="password" class="input-block-level" placeholder="password" name="password">
        <button class="btn btn-large btn-primary" type="submit">Sign in</button>
        <a href="<%=request.getContextPath()%>/admin/reset.do">reset</a>
    </form>


</div> <!-- /container -->
<jsp:include page="../back/exclude/message.jsp"/>
</body>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
</html>