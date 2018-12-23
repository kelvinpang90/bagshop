package com.pwk.service;

import com.pwk.entity.AboutUs;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-12
 * Time: 下午9:30
 * To change this template use File | Settings | File Templates.
 */
public interface AboutUsService {
    public void add(AboutUs aboutUs);
    public void update(AboutUs us);
    public AboutUs getAboutUs();
}
