package com.pwk.taglib;

import com.pwk.entity.ShoppingCart;
import com.pwk.entity.User;
import com.pwk.tools.Engine;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-10
 * Time: 下午4:45
 * To change this template use File | Settings | File Templates.
 */
public class ShoppingCartFunction {
    public static List<ShoppingCart> getByUserId(HttpServletRequest request){
        try {
            User user = UserFunction.getByRequest(request);
            if(user==null){
                return null;
            }
            return Engine.shoppingCartService.getByUserId(user.getId());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    public static int getCountByUserId(HttpServletRequest request){
        try {
            User user = UserFunction.getByRequest(request);
            if(user==null){
                return 0;
            }
            return Engine.shoppingCartService.getCountByUserId(user.getId());
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;

    }
    public static float getTotalPrice(HttpServletRequest request){
        try {
            User user = UserFunction.getByRequest(request);
            if(user==null){
                return 0;
            }
            return Engine.shoppingCartService.getTotalPrice(user.getId());
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}
