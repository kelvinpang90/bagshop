package com.pwk.taglib;

import com.pwk.entity.Admin;
import com.pwk.tools.Engine;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-23
 * Time: 下午12:50
 * To change this template use File | Settings | File Templates.
 */
public class AdminFunction {
     public static Admin getAdminInfo(){
         return Engine.adminService.getUniqueAdminInfo();
     }
    public static Admin getAdminByRequest(HttpServletRequest request){
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if(admin!=null){
            return admin;
        }
        return null;
    }
}
