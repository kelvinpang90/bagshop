package com.pwk.service.impl;

import com.pwk.entity.User;
import com.pwk.service.UserService;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-8
 * Time: 下午8:08
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class UserServiceImpl implements UserService {
    @Resource
    private SessionFactory sessionFactory;
    @Resource
    private SimpleJdbcTemplate simpleJdbcTemplate;


    @Override
    public void add(User user) {
        sessionFactory.getCurrentSession().save(user);
    }

    @Override
    public void update(User user) {
        sessionFactory.getCurrentSession().update(user);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getUserById(id));
    }

    @Override
    public User getUserById(int id) {
        return (User)sessionFactory.getCurrentSession().get(User.class,id);
    }

    @Override
    public User getUserByLoginName(String loginName) {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
        criteria.add(Restrictions.eq("loginname",loginName));
        return (User)criteria.uniqueResult();
    }

    @Override
    public List<User> getUserByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 20;
        }
        Query query = sessionFactory.getCurrentSession().createQuery("from User u order by u.registerTime");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public User getByLoginname(String loginname) {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
        criteria.add(Restrictions.eq("loginname",loginname));
        return (User)criteria.uniqueResult();
    }

    @Override
    public List<User> getAllUser() {
        return sessionFactory.getCurrentSession().createQuery(" from User where 1=1 ").list();
    }

    @Override
    public void addPassword(int userId,String password) {
        simpleJdbcTemplate.update("insert into user_password(user_id,user_password) values(?,?)",userId,password);
    }

    @Override
    public void updatePassword(int id,String password) {
        simpleJdbcTemplate.update("update user_password up set up.user_password=? where up.user_id=?",password,id);
    }

    @Override
    public boolean verifyPassword(int userId,String password) {
        int result = simpleJdbcTemplate.queryForInt(" select count(up.id) from user_password up where up.user_id=? and up.user_password=? ", userId, password);
        if(result==1){
            return true;
        }else{
            return false;
        }
    }

    @Override
    public int getTotal() {
        return simpleJdbcTemplate.queryForInt(" select count(u.id) from user u where 1=1 ");
    }

    @Override
    public void log(int userId, String ip,Timestamp loginDate) {
        simpleJdbcTemplate.update(" insert into login_log(user_id,login_date,ip,type) VALUES (?,?,?,?)",userId,loginDate,ip,"pc");
    }
}
