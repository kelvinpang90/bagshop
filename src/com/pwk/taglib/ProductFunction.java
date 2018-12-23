package com.pwk.taglib;

import com.pwk.entity.Product;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-30
 * Time: 下午8:59
 * To change this template use File | Settings | File Templates.
 */
public class ProductFunction {
    public static Product getProductById(int id,boolean status){
        return Engine.productService.getProductById(id,status);
    }

    public static List<Product> getProductByList(int page,int size,boolean status){
        if(page == 0 || size == 0){
            page = 1;
            size = 10;
        }
        return Engine.productService.getProductByList(page,size,status);
    }
    public static int getTotal(boolean status){
        return Engine.productService.getTotal(status);
    }

    public static List<Product> getProductByBrandId(Integer id,Integer page,Integer size,boolean status){
        if(page == 0 || size == 0){
            page = 1;
            size = 10;
        }
        return Engine.productService.getProductByBrandId(id,page,size,status);
    }
    public static int getTotalBybId(int bId,boolean status){
        return Engine.productService.getTotalBybId(bId,status);
    }

    public static List<Product> getProductByKeyword(String keyword,int page,int size,boolean status){
        keyword = keyword.replace("0","");
        try {
            if(page == 0 || size == 0){
                page = 1;
                size = 10;
            }
            return Engine.productLuceneService.searchByKeyword(keyword,page,size,status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static int getTotalByKeyword(String keyword,boolean status){
        return Engine.productService.getTotalByKeyword(keyword,status);
    }

    public static List<Product> getProductBy_bId_cId_keyword(Integer brandId,Integer categoryId, String keyword,int page,int size,boolean status){
        if(page == 0 || size == 0){
            page = 1;
            size = 20;
        }
        return Engine.productService.getProductBy_bId_cId_keyword(brandId,categoryId,keyword,page,size,status);
    }

    public static int getTotalBy_bId_cId_keyword(Integer brandId,Integer categoryId, String keyword,boolean status){
        return Engine.productService.getTotalBy_bid_cId_keyword(brandId,categoryId,keyword,status);
    }

    public static List<Product> getProductByCid(Integer categoryId,int page,int size,boolean status){
        return Engine.productService.getProductByCategoryId(categoryId,page,size,status);
    }

}
