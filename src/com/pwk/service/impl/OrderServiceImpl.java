package com.pwk.service.impl;

import com.pwk.entity.Order;
import com.pwk.entity.OrderItem;
import com.pwk.service.OrderService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-16
 * Time: 下午5:06
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class OrderServiceImpl implements OrderService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(Order order) {
        sessionFactory.getCurrentSession().save(order);
    }

    @Override
    public void update(Order order) {
        sessionFactory.getCurrentSession().update(order);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public Order getById(int id) {
        return (Order) sessionFactory.getCurrentSession().get(Order.class, id);
    }

    @Override
    public List<Order> getByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 20;
        }
        Query query = sessionFactory.getCurrentSession().createQuery("from Order o order by o.createDate desc");
        if (page != 0 && size != 0) {
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
        }
        return query.list();
    }

    @Override
    public float getTotalPrice(Set<OrderItem> orderItems) {
        float price = 0.00f;
        for(OrderItem orderItem:orderItems){
            price +=orderItem.getProduct().getPrice();
        }
        return price;
    }

    @Override
    public List<Order> getByUserId(int userId) {
        Query query = sessionFactory.getCurrentSession().createQuery("from Order o where o.user.id=:id order by o.createDate desc");
        query.setParameter("id",userId, Hibernate.INTEGER);
        return query.list();
    }

    @Override
    public List<Order> getByStatus(int userId, int status) {
        Query query = sessionFactory.getCurrentSession().createQuery("from Order o where o.user.id=:id and o.status=:status order by o.createDate desc");
        query.setParameter("id",userId, Hibernate.INTEGER);
        query.setParameter("status",status, Hibernate.INTEGER);
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery("from Order").list().size();
    }
}
