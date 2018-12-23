package com.pwk.service.impl;

import com.pwk.entity.ShoppingCart;
import com.pwk.service.ShoppingCartService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-10
 * Time: 下午4:14
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class ShoppingCartServiceImpl implements ShoppingCartService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void add(ShoppingCart shoppingCart) {
        sessionFactory.getCurrentSession().save(shoppingCart);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public void update(ShoppingCart shoppingCart) {
        sessionFactory.getCurrentSession().update(shoppingCart);
    }

    @Override
    public List<ShoppingCart> getByUserId(int userId) {
        Query query = sessionFactory.getCurrentSession().createQuery("from ShoppingCart sc where sc.user.id=:id");
        query.setParameter("id",userId, Hibernate.INTEGER);
        return query.list();
    }

    @Override
    public ShoppingCart getById(int id) {
        return (ShoppingCart)sessionFactory.getCurrentSession().get(ShoppingCart.class,id);
    }

    @Override
    public int getCountByUserId(int userId) {
        return this.getByUserId(userId).size();
    }

    @Override
    public ShoppingCart getCartByProduct(int productId, int userId,int colorId) {
        Query query = sessionFactory.getCurrentSession().createQuery("from ShoppingCart sc where sc.user.id=:userId and sc.product.id=:productId and sc.color.id=:colorId");
        query.setParameter("userId",userId,Hibernate.INTEGER);
        query.setParameter("productId",productId,Hibernate.INTEGER);
        query.setParameter("colorId",colorId,Hibernate.INTEGER);
        return (ShoppingCart)query.uniqueResult();
    }

    @Override
    public float getTotalPrice(int userId) {
        List<ShoppingCart> shoppingCarts = getByUserId(userId);
        float totalCount = 0.00f;
        for(ShoppingCart shoppingCart:shoppingCarts){
            totalCount += shoppingCart.getCount()*(shoppingCart.getProduct().getPrice()+shoppingCart.getAdditionalPrice());
        }
        return totalCount;
    }

    @Override
    public void deleteByUserId(int userId) {
        Query query = sessionFactory.getCurrentSession().createQuery("delete ShoppingCart s where s.user.id=:id");
        query.setParameter("id",userId,Hibernate.INTEGER);
        query.executeUpdate();
    }
}
