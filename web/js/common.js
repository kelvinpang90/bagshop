//register page
$(document).ready(function () {
    var loginName = $("#loginName");
    var loginName1 = $("#loginName1");
    var loginNameTip = $("#loginNameTip");
    var loginNameTip1 = $("#loginNameTip1");
    var loginNameTip2 = $("#loginNameTip2");
    loginName.bind("blur", function () {
        if (loginName.val() == "" || loginName.val().length < 6) {
            loginNameTip.empty();
            loginNameTip2.empty();
            loginNameTip.append("At least 6 character");
        } else {
            loginNameTip.empty();
            loginNameTip2.empty();
            loginNameTip2.append("Checking...");
            $.post('/user/findUniqueName.do', {'loginName': loginName.val()}, function (data) {
                if (data.state == "ok") {
                    loginNameTip.empty();
                    loginNameTip2.empty();
                } else if (data.state == "error") {
                    loginNameTip.empty();
                    loginNameTip2.empty();
                    loginNameTip.append("Cannot use this loginName");
                } else {
                    loginNameTip.empty();
                    loginNameTip2.empty();
                    loginNameTip.append("Network error");
                }
            },"json");
        }
    });
    loginName.bind("click", function () {
        loginNameTip.empty();
        loginNameTip2.empty();
    });
    loginName1.bind("click", function () {
        loginNameTip1.empty();
    });
    var password = $("#password");
    var password1 = $("#password1");
    var password2 = $("#password2");
    var passwordTip = $("#passwordTip");
    var passwordTip1 = $("#passwordTip1");
    var password2Tip = $("#password2Tip");
    var passwordTip2 = $("#passwordTip2");
    var password2Tip2 = $("#password2Tip2");
    password.bind("click", function () {
        passwordTip.empty();
        passwordTip2.empty();
    });
    password1.bind("click", function () {
        passwordTip1.empty();
    });
    password2.bind("click", function () {
        password2Tip.empty();
        password2Tip2.empty();
    });
    password.bind("blur", function () {
        if (password.val() == '' || password.val().length < 6) {
            passwordTip.empty();
            passwordTip2.empty();
            passwordTip.append("At least 6 character");
        } else {
            passwordTip.empty();
            passwordTip2.empty();
            passwordTip2.append("ok");
        }
    });
    password2.bind("blur", function () {
        if (password2.val() == '' || password2.val() != password.val()) {
            password2Tip.empty();
            password2Tip2.empty();
            password2Tip.append("not match");
        } else {
            password2Tip.empty();
            password2Tip2.empty();
            password2Tip2.append("ok");
        }
    });
    var email = $("#email");
    var emailTip = $("#emailTip");
    var validateCode = $("#validateCode");
    var validateCodeTip = $("#validateCodeTip");
    email.bind("click",function(){
        emailTip.empty();
    });
    email.bind("blur",function(){
        if(email.val()==""){
            emailTip.append("Please input your email");
        }
    });
    validateCode.bind("click",function(){
        validateCodeTip.empty();
    });
    validateCode.bind("blur",function(){
        if(validateCode.val()==""){
            validateCodeTip.append("Please input the validateCode");
        }
    });
    $("#theForm").ajaxForm({
        success: function (json, statusText, xhr, $form) {
            if (json.msg != '') {
                alert(json.msg);
            }
            if (json.url != '' && json.url != null && json.url!='reload') {
                window.location.href = decodeURI(json.url);
            }else if(json.url == 'reload'){
                window.location.reload();
            }
        },
        dataType: 'json'
    });
    $("#theForm1").ajaxForm({
        success: function (json, statusText, xhr, $form) {
            if (json.msg != '') {
                alert(json.msg);
            }
            if (json.url != '' && json.url != null && json.url!='reload') {
                window.location.href = decodeURI(json.url);
            }else if(json.url == 'reload'){
                window.location.reload();
            }
        },
        dataType: 'json'
    });
});




//loginname,password,password2
function registerUser() {
    var loginName = $("#loginName");
    var password = $("#password");
    var password2 = $("#password2");
    var loginNameTip = $("#loginNameTip");
    var passwordTip = $("#passwordTip");
    var password2Tip = $("#password2Tip");
    if (loginName.val() == '' || loginName.val().length < 6) {
        loginNameTip.empty();
        loginNameTip.append("At least 6 character");
        loginName.focus();
        return false;
    }
    if (password.val() == '' || password.val().length < 6) {
        passwordTip.empty();
        passwordTip.append("At least 6 character");
        passwordTip.focus();
        return false;
    }
    if (password.val() != password2.val()) {
        password2Tip.empty();
        password2Tip.append("not match");
        password2Tip.focus();
        return false;
    }
    $("#theForm").submit();
}

function login(returnUrl) {
    if(returnUrl==""||returnUrl==null){
        $("#loginDiv").show();
    }else{
        $("#theForm1").append("<input type='hidden' name='returnUrl' value='" + returnUrl + "'>");
        $("#loginDiv").show();
    }
}
//loginname3,password3
function loginUser() {
    var loginName = $("#loginName3");
    var password = $("#password3");
    var loginNameTip = $("#loginNameTip3");
    var passwordTip = $("#passwordTip3");
    if (loginName.val() == '' || loginName.val().length<6) {
        loginNameTip.empty();
        loginNameTip.append("At least 6 character");
        return false;
    }
    if (password.val() == '' || password.val().length<6) {
        passwordTip.empty();
        passwordTip.append("At least 6 character");
        return false;
    }
    $("#theForm").submit();
}
//password1,loginname1
function loginUser1() {
    var loginName1 = $("#loginName1");
    var password1 = $("#password1");
    var loginNameTip = $("#loginNameTip1");
    var passwordTip = $("#passwordTip1");
    if (loginName1.val() == '' || loginName1.val().length<6) {
        loginNameTip.empty();
        loginNameTip.append("At least 6 character");
        return false;
    }
    if (password1.val() == '' || password1.val().length<6) {
        passwordTip.empty();
        passwordTip.append("At least 6 character");
        return false;
    }
    $("#theForm1").submit();
}

function addToCart(pid, count) {
    count = 1;
    var quantity = $("#quantity").val();
    if(quantity!=undefined&&quantity>1){
        if(/^\+?[1-9][0-9]*$/.test(quantity)&&quantity<=10)
         count = quantity;
    }
    var color = $("#colorVal").val();
    if(color==null||color==""){
        alert("Please select color!");
        return;
    }
    var attributes = [];
    var flag = true;
    $("select[name='attribute']").each(function(){
        var attribute = {};
        attribute.name = $(this).attr("title");
        if($(this).val() == null||$(this).val()==''){
            flag = false;
            alert('Please complete all selection');
        }
        attribute.value = $(this).val();
        attributes.push(attribute);
    });
    if(!flag) return;
    $.post("/shoppingCart/add.do", {'id': pid, 'count': count,'colorId':color,'attributes':JSON.stringify(attributes)}, function (data) {
        if (data.state == 'ok') {
            alert(data.msg);
        } else if (data.state == 'error') {
            alert(data.msg);
        } else if (data.state == 'login') {
            login();
        }
    }, "json");
}

function buyNow(pid, count) {
    count = 1;
    var quantity = $("#quantity").val();
    if(quantity!=undefined&&quantity>1){
        if(/^\+?[1-9][0-9]*$/.test(quantity)&&quantity<=10)
            count = quantity;
    }
    var color = $("#colorVal").val();
    if(color==null||color==""){
        alert("Please select color!");
        return;
    }
    $.post("/shoppingCart/add.do", {'id': pid, 'count': count,'colorId':color}, function (data) {
        if (data.state == 'ok') {
            window.location.href = "/cart.html";
        } else if (data.state == 'error') {
            alert(data.msg);
        } else if (data.state == 'login') {
            login();
        }
    }, "json");
}

function removeCart(obj,cartId){
    if(confirm("Are you sure to delete?")){
        $.post("/shoppingCart/delete.do",{'id':cartId},function(data){
            if(data.state=='ok'){
                alert("ok");
                window.location.reload();
            }else{
                alert("Fail to delete product from cart");
            }
        },"json");
    }
}
function validateCart(length){
    if(length==null||length<=0){
        alert("ShoppingCart is empty");
        return false;
    }
    return true;
}

function selectColor(colorId,colorName){
    var color = $("#color");
    color.empty();
    color.append(colorName);
    $("#colorVal").attr("value",colorId);
}
