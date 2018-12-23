package com.pwk.taglib;

import com.pwk.entity.IndexInfo;
import com.pwk.tools.Engine;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-21
 * Time: 下午8:48
 * To change this template use File | Settings | File Templates.
 */
public class IndexInfoFunction {
    public static IndexInfo getById(int id){
        return Engine.indexInfoService.getById(id);
    }
}
