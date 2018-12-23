package com.pwk.taglib;

import com.pwk.entity.Attribute;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
public class AttributeFunction {
    public static Attribute getById(int id){
        return Engine.attributeService.getById(id);
    }
    public static List<Attribute> getByList(int page,int size){
        return Engine.attributeService.getByList(page,size);
    }
    public static List<Attribute> getAll(){
        return Engine.attributeService.getAll();
    }
    public static int getTotal(){
        return Engine.attributeService.getTotal();
    }

}
