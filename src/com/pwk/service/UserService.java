package com.pwk.service;

import com.pwk.entity.User;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-8
 * Time: 下午8:02
 * To change this template use File | Settings | File Templates.
 */
public interface UserService {
    public void add(User user);
    public void update(User user);
    public void delete(int id);
    public User getUserById(int id);
    public User getUserByLoginName(String loginName);
    public List<User> getUserByList(int page,int size);
    public User getByLoginname(String loginname);
    public List<User> getAllUser();
    public int getTotal();

    public void log(int userId,String ip,Timestamp loginDate);

    public void addPassword(int userId,String password);
    public void updatePassword(int id,String password);
    public boolean verifyPassword(int userId,String password);

}
