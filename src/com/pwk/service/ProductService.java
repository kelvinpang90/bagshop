package com.pwk.service;

import com.pwk.entity.Product;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-17
 * Time: 下午10:21
 * To change this template use File | Settings | File Templates.
 */
public interface ProductService {
    public void add(Product product);
    public void update(Product product);
    public void delete(int id);
    public Product getProductById(int id,boolean status);

    public List<Product> getProductByList(int page,int size,boolean status);
    public List<Product> getAllProducts(boolean status);
    public List<Product> getProductByBrandId(Integer brandId,int page,int size,boolean status);
    public List<Product> getProductByCategoryId(Integer categoryId,int page,int size,boolean status);
    public List<Product> getProductByRand(Integer brandId,int page,int size,boolean status);
    public List<Product> getProductByKeyword(String keyword,int page,int size,boolean status);
    public List<Product> getProductBy_bId_cId_keyword(Integer brandId,Integer categoryId,String keyword,int page, int size,boolean status);

    public int getTotal(boolean status);
    public int getTotalBybId(Integer brandId,boolean status);
    public int getTotalByKeyword(String keyword,boolean status);
    public int getTotalBy_bid_cId_keyword(Integer brandId,Integer categoryId,String keyword,boolean status);

    public void deleteProductColorLink(Integer productId);

}
