package com.pwk.service;

import com.pwk.entity.Order;
import com.pwk.entity.OrderItem;

import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-16
 * Time: 下午5:05
 * To change this template use File | Settings | File Templates.
 */
public interface OrderService {
    public void add(Order order);
    public void update(Order order);
    public void delete(int id);
    public Order getById(int id);
    public List<Order> getByList(int page,int size);
    public float getTotalPrice(Set<OrderItem> orderItems);
    public List<Order> getByUserId(int userId);
    public List<Order> getByStatus(int userId,int status);
    public int getTotal();
}
