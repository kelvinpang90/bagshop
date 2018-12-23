package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.job.EmailTask;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;

/**
 * Created by wenkai.peng on 1/19/2015.
 */
public class TimerAction extends BaseAction {

    private static final Logger LOG = LogManager.getLogger(PVAction.class.getName());

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String email(){
        try {
            String dateStr = getRequest().getParameter("date");
            Date date = format.parse(dateStr);
            String content = getRequest().getParameter("description");
            String title = getRequest().getParameter("title");
            EmailTask task = new EmailTask(title,content);

            Timer timer = new Timer();
            timer.schedule(task,date);
            Message.returnMessage("Success","../../back/email/emailAdd.jsp","ok",getResponse());
            LOG.info("添加推送邮件成功");
        }catch (Exception e){
            LOG.error("添加推送邮件失败");
            e.printStackTrace();
        }
        return null;
    }


}
