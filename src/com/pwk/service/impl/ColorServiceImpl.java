package com.pwk.service.impl;

import com.pwk.entity.Color;
import com.pwk.service.ColorService;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 14-1-13.
 */
@Transactional
public class ColorServiceImpl implements ColorService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(Color color) {
        sessionFactory.getCurrentSession().save(color);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public void update(Color color) {
         sessionFactory.getCurrentSession().merge(color);
    }

    @Override
    public Color getById(int id) {
        return (Color)sessionFactory.getCurrentSession().get(Color.class,id);
    }

    @Override
    public List<Color> getAllColor() {
        Query query = sessionFactory.getCurrentSession().createQuery("from Color c where 1=1 ");
        return query.list();
    }
}
