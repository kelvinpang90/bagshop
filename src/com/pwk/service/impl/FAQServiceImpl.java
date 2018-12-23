package com.pwk.service.impl;

import com.pwk.entity.FAQ;
import com.pwk.service.FAQService;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-3
 * Time: 下午9:03
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class FAQServiceImpl implements FAQService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void add(FAQ faq) {
        sessionFactory.getCurrentSession().save(faq);
    }

    @Override
    public void update(FAQ faq) {
        sessionFactory.getCurrentSession().update(faq);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public FAQ getById(int id) {
        return (FAQ)sessionFactory.getCurrentSession().get(FAQ.class,id);
    }

    @Override
    public List<FAQ> getAll() {
        Query query = sessionFactory.getCurrentSession().createQuery("from FAQ f order by f.position");
        return query.list();
    }
}
