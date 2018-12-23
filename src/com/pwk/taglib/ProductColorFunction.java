package com.pwk.taglib;

import com.pwk.entity.Color;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-11
 * Time: 下午9:44
 * To change this template use File | Settings | File Templates.
 */
public class ProductColorFunction {
    public static List<Color> getAll(){
        return Engine.colorService.getAllColor();
    }
}
