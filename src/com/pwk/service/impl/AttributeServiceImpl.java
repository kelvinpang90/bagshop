package com.pwk.service.impl;

import com.pwk.entity.Attribute;
import com.pwk.service.AttributeService;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
@Transactional
public class AttributeServiceImpl implements AttributeService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void add(Attribute attribute) {
        sessionFactory.getCurrentSession().save(attribute);
    }

    @Override
    public void update(Attribute attribute) {
        sessionFactory.getCurrentSession().update(attribute);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public Attribute getById(int id) {
        return (Attribute)sessionFactory.getCurrentSession().get(Attribute.class,id);
    }

    @Override
    public List<Attribute> getByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 20;
        }
        Query query = sessionFactory.getCurrentSession().createQuery(" from Attribute ");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public List<Attribute> getAll() {
        return sessionFactory.getCurrentSession().createQuery(" from Attribute ").list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery(" from Attribute ").list().size();
    }
}
