package com.pwk.service.impl;

import com.pwk.entity.Parameter;
import com.pwk.service.ParameterService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
@Transactional
public class ParameterServiceImpl implements ParameterService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(Parameter parameter) {
        sessionFactory.getCurrentSession().save(parameter);
    }

    @Override
    public void update(Parameter parameter) {
        sessionFactory.getCurrentSession().update(parameter);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public Parameter getById(int id) {
        return (Parameter)sessionFactory.getCurrentSession().get(Parameter.class,id);
    }

    @Override
    public List<Parameter> getByAttributeId(int attributeId) {
        Query query = sessionFactory.getCurrentSession().createQuery(" from Parameter p where p.attributeId=:attributeId ");
        query.setParameter("attributeId",attributeId, Hibernate.INTEGER);
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery(" from Parameter ").list().size();
    }
}
