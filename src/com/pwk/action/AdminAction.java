package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Admin;
import com.pwk.service.AdminService;
import com.pwk.tools.DigestTool;
import com.pwk.tools.Message;
import com.pwk.tools.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-25
 * Time: 下午6:45
 * To change this template use File | Settings | File Templates.
 */
public class AdminAction extends BaseAction {

    @Resource
    private AdminService adminService;

    private static final Logger LOG = LogManager.getLogger(AdminAction.class.getName());

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String changePassword() {
        try {
            Admin admin = (Admin) getSession().getAttribute("admin");
            int id = admin.getId();
            String oldPassword = getRequest().getParameter("oldPassword");
            String newPassword = getRequest().getParameter("newPassword");
            String newPassword1 = getRequest().getParameter("newPassword1");
            if (!StringUtils.equals(newPassword, newPassword1)) {
                Message.returnMessage("新密码不一致！", "", "err", getResponse());
                return null;
            }

            if (!StringUtils.equals(DigestTool.digest(oldPassword), admin.getPassword())) {
                Message.returnMessage("旧密码不正确！", "", "err", getResponse());
                return null;
            }
            adminService.changePassword(id, DigestTool.digest(newPassword));
            LOG.info("admin修改密码成功！");
            Message.returnMessage("修改密码成功！", "../login/index.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("admin修改密码异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String login() {
        try {
            String loginName = getRequest().getParameter("loginName");
            String password = getRequest().getParameter("password");
            Admin admin = adminService.login(loginName,DigestTool.digest(password));
            if (admin == null) {
                LOG.error("admin登录失败！");
                return null;
            }
            getRequest().getSession().setAttribute("admin", admin);
            adminService.log(admin.getId(), Timestamp.valueOf(format.format(new Date())), StringTools.getRealIp(getRequest()));
            LOG.info("admin登录成功！");
            getResponse().sendRedirect("../back/payment/paymentList.jsp");
        } catch (Exception e) {
            LOG.error("admin登录异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String loginOut() {
        try {
            getRequest().getSession().removeAttribute("admin");
            LOG.info("admin登出成功！");
            getResponse().sendRedirect("../login/index.jsp");
        } catch (Exception e) {
            LOG.error("admin登出成功！");
            e.printStackTrace();
        }
        return null;
    }

    public String reset() {
        try {
            adminService.changePassword(1,DigestTool.digest("123456"));
            LOG.info("admin重置密码成功！");
            Message.returnMessage("", "../login/index.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("admin重置密码异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String changeMessage() {
        try {
            Admin admin = adminService.getUniqueAdmin();
            admin.setBandAccount(getRequest().getParameter("bandAccount"));
            admin.setEmail(getRequest().getParameter("email"));
            admin.setContactNumber(getRequest().getParameter("contactNumber"));
            admin.setContactPerson(getRequest().getParameter("contactPerson"));
            admin.setFullName(getRequest().getParameter("fullName"));
            adminService.update(admin);
            getRequest().getSession().setAttribute("admin", admin);
            LOG.info("admin修改资料成功！");
            Message.returnMessage("修改成功！", "../back/changeMessage.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("admin修改资料异常！");
            e.printStackTrace();
        }
        return null;
    }
}
