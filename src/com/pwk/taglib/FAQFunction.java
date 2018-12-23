package com.pwk.taglib;

import com.pwk.entity.FAQ;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-3
 * Time: 下午9:26
 * To change this template use File | Settings | File Templates.
 */
public class FAQFunction {
    public static FAQ getFAQById(int id){
        return Engine.faqService.getById(id);
    }
    public static List<FAQ> getByList(){
        return Engine.faqService.getAll();
    }
}
