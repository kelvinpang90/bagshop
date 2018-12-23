<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<style>
    .c {
        background-color: #FFFFFF;
        background-image: url("../images/bkg.jpg");
        position: fixed;
        top: 50%;
        left: 50%;
        margin: -87px 0 0 -194px;
        z-index: 999;
        display: none;
        width: 350px;
        height: 170px;
    }
</style>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<div class="c" id="loginDiv">
    <form action="${pageContext.request.contextPath}/user/login.do" method="post" id="theForm1">
        <h2 style="text-align: center;color: #999999;margin-top: 5px;"><s:text name="user.login"/></h2>
        <div style="margin-left: 40px;">
            <s:text name="user.name"/>:
            <input type="text" name="loginName" id="loginName3">  <br>
            <font color="red" id="loginNameTip3"></font>
        </div>
        <div style="margin-left: 40px;margin-top: 10px;">
            &nbsp;&nbsp;&nbsp;<s:text name="user.password"/>:
            <input type="password" name="password" id="password3"> <br>
            <font color="red" id="passwordTip3"></font>
        </div>
        <div style="margin-top: 10px;margin-left: 60px;">
            <input type="submit" value="<s:text name="user.button.login"/>" class="sub_btn" style="float: left" onclick="return loginUser()"/> &nbsp; &nbsp;
            <input type="button" value="<s:text name="user.button.forget"/>" class="sub_btn" style="float: left;margin-left: 15px;" onclick="window.location.href='forgetPassword.html'"/> &nbsp; &nbsp;
            <input type="button" value="<s:text name="user.button.close"/>" class="sub_btn" style="float: left;margin-left: 15px;" onclick="$('#loginDiv').hide()"/>
        </div>
    </form>
</div>