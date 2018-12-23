package com.pwk.listener;

import com.pwk.service.PV_Service;
import com.pwk.service.impl.PV_ServiceImpl;

import javax.servlet.*;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by wenkai.peng on 1/22/2015.
 */
public class OnlineListener implements HttpSessionListener {

    private int count = 0;
    private ServletContext context = null;

    private void setContext (HttpSessionEvent httpSessionEvent){
        httpSessionEvent.getSession().getServletContext().setAttribute("online", count);
    }
    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        try {
            count++;
            setContext(httpSessionEvent);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        count--;
        setContext(httpSessionEvent);
    }
}
