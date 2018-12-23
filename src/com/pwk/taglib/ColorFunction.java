package com.pwk.taglib;

import com.pwk.entity.Color;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-19
 * Time: 下午8:51
 * To change this template use File | Settings | File Templates.
 */
public class ColorFunction {
    public static Color getById(int id){
         return Engine.colorService.getById(id);
    }
    public static List<Color> getByList(){
        return Engine.colorService.getAllColor();
    }
}
