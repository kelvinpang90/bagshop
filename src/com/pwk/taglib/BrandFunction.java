package com.pwk.taglib;

import com.pwk.entity.Brand;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-20
 * Time: 下午4:36
 * To change this template use File | Settings | File Templates.
 */
public class BrandFunction {
    public static List<Brand> getAllBrand(){
        return Engine.brandService.getAllBrand();
    }
    public static Brand getById(int id){
        return Engine.brandService.getBrandById(id);
    }
    public static List<Brand> getBrandsByStatus(int status){
        return Engine.brandService.getBrandsByStatus(status);
    }
}
