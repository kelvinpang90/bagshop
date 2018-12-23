package com.pwk.taglib;

import com.pwk.entity.User;
import com.pwk.tools.Engine;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-10
 * Time: 上午10:26
 * To change this template use File | Settings | File Templates.
 */
public class UserFunction {
    public static User getById(int id){
        return Engine.userService.getUserById(id);
    }

    private static User getFromSession(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        if(user!=null){
            return user;
        }
        return null;
    }

    public static User getByRequest(HttpServletRequest request){
        User user = getFromSession(request);
        if(user!=null)
            return getById(user.getId());
        else
            return null;
    }

    public static List<User> getUserList(int page,int size){
        try {
            return Engine.userService.getUserByList(page,size);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static int getUserTotal(){
        try {
            return Engine.userService.getTotal();

        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}
