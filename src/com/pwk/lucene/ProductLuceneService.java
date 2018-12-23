package com.pwk.lucene;

import com.pwk.entity.Product;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-3-9
 * Time: 下午3:06
 * To change this template use File | Settings | File Templates.
 */
public interface ProductLuceneService {
    public void updateProductIndex(Product product);
    public void addProductIndex(Product product);
    public void addAllProductToIndex();
    public void deleteProductIndex(int id);

    public List<Product> searchByKeyword(String keyword,int page,int size,boolean status);
    public List<Product> searchByField_Precise(String fieldName,String keyword,int page,int size,boolean status);
    public List<Product> searchByField_Fuzzy(String fieldName,String keyword,int page, int size,boolean status);

    public int getTotalByKeyword(String keyword,boolean status);
    public int getTotalByField_Precise(String fieldName,String keyword,boolean status);
    public int getTotalByField_Fuzzy(String fieldName,String keyword,boolean status);
}
