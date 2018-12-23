package com.pwk.service.impl;

import com.pwk.entity.Attribute;
import com.pwk.entity.Category;
import com.pwk.service.CategoryService;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
@Transactional
public class CategoryServiceImpl implements CategoryService {
    @Resource
    private SessionFactory sessionFactory;
    @Resource
    private JdbcTemplate jdbcTemplate;
    @Override
    public void add(Category category) {
        sessionFactory.getCurrentSession().save(category);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public void update(Category category) {
        sessionFactory.getCurrentSession().update(category);
    }

    @Override
    public Category getById(int id) {
        return (Category)sessionFactory.getCurrentSession().get(Category.class,id);
    }

    @Override
    public List<Category> getByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 20;
        }
        Query query = sessionFactory.getCurrentSession().createQuery(" from Category ");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public List<Category> getAll() {
        return sessionFactory.getCurrentSession().createQuery(" from Category ").list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery(" from Category ").list().size();
    }
}
