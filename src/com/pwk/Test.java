package com.pwk;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-25
 * Time: 下午7:24
 * To change this template use File | Settings | File Templates.
 */
public class Test {
    public static void main(String[] args){
        VelocityEngine ve = new VelocityEngine();
        ve.init();
        Template template = ve.getTemplate("pay.vm");

        VelocityContext context = new VelocityContext();
        context.put("paypal","https://www.paypal.com/cgi-bin/webscr");
        context.put("cmd","_xclick");
        context.put("business","pengwenkai@hotmail.com");
        context.put("item_name","order information");
        context.put("amount",100);
        context.put("currency_code","MYR");
        context.put("notify_url","http://www.myparisbags.com/order/return.do");
    }
    public void lucene(){

    }
}
