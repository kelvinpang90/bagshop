package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.AboutUs;
import com.pwk.service.AboutUsService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-13
 * Time: 下午7:58
 * To change this template use File | Settings | File Templates.
 */
public class AboutUsAction extends BaseAction {

    private static final Logger LOG = LogManager.getLogger(AboutUsAction.class.getName());
    @Resource
    public AboutUsService aboutUsService;

    public String update() {
        try {
            String content = getRequest().getParameter("content");
            AboutUs aboutUs = aboutUsService.getAboutUs();
            aboutUs.setContent(content);
            aboutUsService.update(aboutUs);
            LOG.info("aboutUs修改成功！");
            Message.returnMessage("修改成功","","ok",getResponse());
        }catch (Exception e){
            LOG.error("aboutUs修改异常！");
            e.printStackTrace();
        }
        return null;
    }
}
