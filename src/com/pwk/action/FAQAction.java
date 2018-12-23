package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.FAQ;
import com.pwk.service.FAQService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-3
 * Time: 下午9:05
 * To change this template use File | Settings | File Templates.
 */
public class FAQAction extends BaseAction {

    @Resource
    private FAQService faqService;

    private static final Logger LOG = LogManager.getLogger(FAQAction.class.getName());

    public String addFAQ() throws Exception {
        try {
            String question = getRequest().getParameter("question");
            String answer = getRequest().getParameter("answer");
            String position = getRequest().getParameter("position");
            FAQ faq = new FAQ();
            faq.setQuestion(question);
            faq.setAnswer(answer);
            faq.setPosition(Integer.valueOf(position));
            faqService.add(faq);
            LOG.info("增加faq成功！");
            Message.returnMessage("增加faq成功！", "../../back/faq/faqList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("增加faq异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String updateFAQ() throws Exception {
        try {
            String id = getRequest().getParameter("id");
            String question = getRequest().getParameter("question");
            String answer = getRequest().getParameter("answer");
            String position = getRequest().getParameter("position");
            FAQ faq = faqService.getById(Integer.valueOf(id));
            faq.setQuestion(question);
            faq.setAnswer(answer);
            faq.setPosition(Integer.valueOf(position));
            faqService.update(faq);
            System.out.println("修改faq成功");
            LOG.info("删除颜色成功！");
            Message.returnMessage("修改成功！", "../../back/faq/faqList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("删除颜色成功！");
            e.printStackTrace();
        }
        return null;
    }

    public String deleteFAQ() throws Exception {
        try {
           String id = getRequest().getParameter("id");
            faqService.delete(Integer.valueOf(id));
            System.out.println("删除faq成功");
            LOG.info("删除faq成功！");
            getResponse().sendRedirect("../../back/faq/faqList.jsp");
        }catch (Exception e){
            LOG.error("删除faq异常！");
            e.printStackTrace();
        }
        return null;
    }
}
