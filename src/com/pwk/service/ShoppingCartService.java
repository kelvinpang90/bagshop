package com.pwk.service;

import com.pwk.entity.ShoppingCart;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-10
 * Time: 下午4:10
 * To change this template use File | Settings | File Templates.
 */
public interface ShoppingCartService {
    public void add(ShoppingCart shoppingCart);
    public void delete(int id);
    public void update(ShoppingCart shoppingCart);
    public ShoppingCart getById(int id);
    public List<ShoppingCart> getByUserId(int userId);
    public int getCountByUserId(int userId);

    /**
     * 根据用户id，商品id，颜色id获取购物车中的商品
     * @param productId
     * @param userId
     * @param colorId
     * @return
     */
    public ShoppingCart getCartByProduct(int productId,int userId,int colorId);
    public float getTotalPrice(int userId);
    public void deleteByUserId(int userId);
}
