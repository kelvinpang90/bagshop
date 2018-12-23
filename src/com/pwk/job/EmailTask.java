package com.pwk.job;

import com.pwk.entity.MailSenderInfo;
import com.pwk.entity.User;
import com.pwk.service.UserService;
import com.pwk.tools.GmailSender;
import org.apache.commons.lang3.StringUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.TimerTask;

/**
 * Created by wenkai.peng on 1/20/2015.
 */
public class EmailTask extends TimerTask {
    @Resource
    private UserService userService;
    private String content;
    private String title;
    public EmailTask(String title,String content){
        this.content = content;
        this.title = title;
    }
    @Override
    public void run() {
        MailSenderInfo mailSenderInfo = new MailSenderInfo();
        mailSenderInfo.setSubject(title);
        List<User> users = userService.getAllUser();
        for(User user:users){
            if(StringUtils.isNotBlank(user.getEmail())&&user.getEmailStatus()==1){
                mailSenderInfo.setToAddress(user.getEmail());
                content += "<p>If you don&#39;t want to receive newsletters from <a href=\"http://www.myparisbags.com\">MyParisBags</a> anymore,please click <a href=\"http://www.myparsbags.com/user/unsubscribe.do?id="+user.getId()+"\">unsubscribe</a></p>";
                mailSenderInfo.setContent(content);
                try {
                    GmailSender.send(mailSenderInfo);
                }catch (Exception e){
                    e.printStackTrace();
                }
                try {
                    Thread.sleep(30000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        //exit process
        System.gc();
    }
}
