package com.pwk.taglib;

import com.pwk.entity.AboutUs;
import com.pwk.tools.Engine;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-13
 * Time: 下午8:02
 * To change this template use File | Settings | File Templates.
 */
public class AboutUsFunction {
    public static AboutUs get(){
        return Engine.aboutUsService.getAboutUs();
    }
}
