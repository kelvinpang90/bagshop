package com.pwk.taglib;

import com.pwk.entity.Category;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
public class CategoryFunction {
    public static Category getById(int id){
        return Engine.categoryService.getById(id);
    }
    public static List<Category> getByList(int page,int size){
        return Engine.categoryService.getByList(page,size);
    }
    public static List<Category>  getAll(){
        try {
            return Engine.categoryService.getAll();
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static int getTotal(){
        return Engine.categoryService.getTotal();
    }
}
