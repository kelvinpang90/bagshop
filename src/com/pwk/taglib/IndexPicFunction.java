package com.pwk.taglib;

import com.pwk.entity.IndexPic;
import com.pwk.tools.Engine;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-21
 * Time: 下午8:49
 * To change this template use File | Settings | File Templates.
 */
public class IndexPicFunction {
    public static IndexPic getById(int id){
        return Engine.indexPicService.getById(id);
    }
}
