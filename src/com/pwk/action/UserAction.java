package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.MailSenderInfo;
import com.pwk.entity.User;
import com.pwk.service.UserService;
import com.pwk.tools.*;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.annotation.Resource;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-8
 * Time: 下午8:16
 * To change this template use File | Settings | File Templates.
 */
public class UserAction extends BaseAction {

    @Resource
    private UserService userService;

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private static final Logger LOG = LogManager.getLogger(UserAction.class.getName());

    public String userAdd() {
        try {
            String validateCode = getRequest().getParameter("validateCode");
            boolean flag = ValidateCode.validate(validateCode,getRequest());
            if(!flag){
                Message.returnMessage("error validateCode", "reload", "ok", getResponse());
                return  null;
            }
            String loginName = getRequest().getParameter("loginName");
            String password = getRequest().getParameter("password");
            String password1 = getRequest().getParameter("password1");
            String name = getRequest().getParameter("name");
            String email = getRequest().getParameter("email");
            String phone = getRequest().getParameter("phone");
            String country = getRequest().getParameter("country");
            String state = getRequest().getParameter("state");
            String address = getRequest().getParameter("address");
            User users = userService.getByLoginname(loginName);
            if (users != null) {
                Message.returnMessage("cannot use this loginName", "", "ok", getResponse());
                return  null;
            }
            if (!StringUtils.equals(password1, password)) {
                Message.returnMessage("the password is not match", "", "ok", getResponse());
                return  null;
            }
            User user = new User();
            user.setLoginname(loginName);
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setCountry(country);
            user.setState(state);
            user.setAddress(address);
            user.setRegisterTime(Timestamp.valueOf(format.format(new Date())));
            userService.add(user);
            getRequest().getSession().setAttribute("user", user);
            userService.log(user.getId(),StringTools.getRealIp(getRequest()),Timestamp.valueOf(format.format(new Date())));
            LOG.info("用户添加成功="+user.getLoginname());
            //增加密码
            userService.addPassword(userService.getUserByLoginName(loginName).getId(),password);
            LOG.info("密码添加成功！");
            Message.returnMessage("register success", "../index.html", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("密码添加异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String findUniqueName() {
        try {
            String loginName = getRequest().getParameter("loginName");
            User users = userService.getByLoginname(loginName);
            if (users != null) {
                Message.returnMessage("", "", "error", getResponse());
            } else {
                Message.returnMessage("", "", "ok", getResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String changePassword() {
        try {
            String id = getRequest().getParameter("id");
            if(id==null){
                Message.returnMessage("no login","../index.html?t=login","ok",getResponse());
                return null;
            }
            String currentPassword = getRequest().getParameter("currentPassword");
            String newPassword = getRequest().getParameter("newPassword");
            String newPassword1 = getRequest().getParameter("newPassword1");
            if(!StringUtils.equals(newPassword,newPassword1)){
                Message.returnMessage("new password dose not match!","../changePassword.html","ok",getResponse());
                return null;
            }
            boolean flag = userService.verifyPassword(Integer.valueOf(id), currentPassword);
            if(!flag){
                Message.returnMessage("current password is wrong!","../changePassword.html","ok",getResponse());
                return  null;
            }
            //修改密码
            userService.updatePassword(Integer.valueOf(id),newPassword);
            //必须重新登录
            getRequest().getSession().removeAttribute("user");
            LOG.info("用户更新密码成功  用户id="+id);
            Message.returnMessage("change password success,please sign in again!","../index.html","ok",getResponse());
        }catch (Exception e){
            LOG.error("用户更新密码异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String login() {
        try {
            String loginName = getRequest().getParameter("loginName");
            String password = getRequest().getParameter("password");
            String returnUrl = getRequest().getParameter("returnUrl");
            User user = userService.getUserByLoginName(loginName);
            if(user==null){
                Message.returnMessage("user dose not exist!","","ok",getResponse());
                return null;
            }
            //验证密码
            boolean flag = userService.verifyPassword(user.getId(),password);
            if (flag) {
                getRequest().getSession().setAttribute("user", user);
                userService.log(user.getId(),StringTools.getRealIp(getRequest()),Timestamp.valueOf(format.format(new Date())));
                LOG.info("用户登录成功="+user.getLoginname());
                Message.returnMessage("", StringUtils.isBlank(returnUrl)?"reload":returnUrl, "ok", getResponse());
            }else{
                Message.returnMessage("login fail,please try again", "", "ok", getResponse());
            }
        } catch (Exception e) {
            LOG.error("用户登录异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String logout() throws IOException{
        getRequest().getSession().removeAttribute("user");
        getResponse().sendRedirect("../index.html");
        return null;
    }

    public String changeInformation(){
        try {
            String id = getRequest().getParameter("id");
            String email = getRequest().getParameter("email");
            String name = getRequest().getParameter("name");
            String phone = getRequest().getParameter("phone");
            String country = getRequest().getParameter("country");
            String state = getRequest().getParameter("state");
            String address = getRequest().getParameter("address");

            User user = userService.getUserById(Integer.valueOf(id));
            user.setEmail(email);
            user.setName(name);
            user.setPhone(phone);
            user.setCountry(country);
            user.setState(state);
            user.setAddress(address);

            userService.update(user);
            Message.returnMessage("success!", "", "ok", getResponse());
            LOG.info("修改用户信息成功 id="+id);
        }catch (Exception e){
            LOG.error("修改用户信息异常！");
            e.printStackTrace();
        }
        return  null;
    }

    public String forgetPassword(){
        try {
            String loginName = getRequest().getParameter("loginName");
            String email = getRequest().getParameter("email");
            String validateCode = getRequest().getParameter("validateCode");
            boolean flag = ValidateCode.validate(validateCode,getRequest());
            if(!flag){
                Message.returnMessage("error validateCode", "../forgetPassword.html", "ok", getResponse());
                return  null;
            }
            User user = userService.getByLoginname(loginName);
            if(user!=null){
                if(StringUtils.equals(email,user.getEmail())){
                    int newPassword = (int)((Math.random()*9+1)*100000);
                    userService.updatePassword(user.getId(),String.valueOf(newPassword));

                    StringBuilder content = new StringBuilder();
                    MailSenderInfo mailInfo = new MailSenderInfo();
                    mailInfo.setSubject("forget password");
                    content.append("Your account("+user.getLoginname()+") password has been changed to "+newPassword);
                    content.append("</br></br>");
                    content.append("<a href='http://www.myparisbags.com'>MyParisBags</a>");
                    mailInfo.setContent(content.toString());

                    mailInfo.setToAddress(email);
                    GmailSender.send(mailInfo);
                    LOG.info("重置密码邮件发送成功！");
                    Message.returnMessage("please check your email and get the new password","","ok",getResponse());
                }else{
                    Message.returnMessage("email is not correct","../forgetPassword.html","ok",getResponse());
                    return null;
                }
            }else{
                Message.returnMessage("loginName is not exist","../forgetPassword.html","ok",getResponse());
                return null;
            }
        }catch (Exception e){
            LOG.error("重置密码邮件发送异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String unsubscribe(){
        try {
            String id = getRequest().getParameter("id");
            User user = userService.getUserById(Integer.valueOf(id));
            user.setEmailStatus(0);
            userService.update(user);
            LOG.info("unsubscribe success");
        }catch (Exception e){
            LOG.error("unsubscribe error");
            e.printStackTrace();
        }
        return null;
    }

    public String initEmailStatus(){
        try {
            List<User> users = userService.getAllUser();
            for(User user:users){
                user.setEmailStatus(1);
                userService.update(user);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
