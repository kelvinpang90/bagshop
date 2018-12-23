package com.pwk.taglib;

import com.pwk.entity.Admin;
import com.pwk.entity.Order;
import com.pwk.entity.User;
import com.pwk.tools.Engine;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-16
 * Time: 下午5:47
 * To change this template use File | Settings | File Templates.
 */
public class OrderFunction {
    public static Order getOrderById(int id,HttpServletRequest request){
        try {
            Order order = Engine.orderService.getById(id);
            User user = UserFunction.getByRequest(request);
            if(AdminFunction.getAdminByRequest(request)!=null||user.getId()==order.getUser().getId()){
                return order;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static List<Order> getOrderByUserId(HttpServletRequest request){
        try {
            User user = UserFunction.getByRequest(request);
            if(user==null){
                return null;
            }
            return Engine.orderService.getByUserId(user.getId());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static List<Order> getOrderByStatus(HttpServletRequest request,int status){
        try {
            User user = UserFunction.getByRequest(request);
            if(user==null){
                return null;
            }
            return Engine.orderService.getByStatus(user.getId(),status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static List<Order> getAllOrder(int page,int size){
        try {
            return Engine.orderService.getByList(page,size);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static int getOrderTotal(){
        try {
            return Engine.orderService.getTotal();
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}
