package com.pwk.taglib;

import com.pwk.entity.IndexProduct;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午7:15
 * To change this template use File | Settings | File Templates.
 */
public class IndexProductFunction {
    public static IndexProduct getById(int id){
        return Engine.indexProductService.getById(id);
    }
    public static List<IndexProduct> getByList(int page,int size){
        return Engine.indexProductService.getByList(page,size);
    }
    public static int getTotal(){
        return Engine.indexProductService.getTotal();
    }
}
