package com.pwk.service.impl;

import com.pwk.entity.IndexProduct;
import com.pwk.service.IndexProductService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午2:52
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class IndexProductServiceImpl implements IndexProductService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void add(IndexProduct indexProduct) {
        sessionFactory.getCurrentSession().save(indexProduct);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public void deleteByProductId(int id) {
        sessionFactory.getCurrentSession().createQuery("delete from IndexProduct i where i.product.id=:id").setParameter("id",id, Hibernate.INTEGER);
    }

    @Override
    public void update(IndexProduct indexProduct) {
        sessionFactory.getCurrentSession().update(indexProduct);
    }

    @Override
    public IndexProduct getById(int id) {
        return (IndexProduct)sessionFactory.getCurrentSession().get(IndexProduct.class,id);
    }

    @Override
    public List<IndexProduct> getByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 10;
        }
        Query query = sessionFactory.getCurrentSession().createQuery("from IndexProduct i where i.product.status=1 order by i.position");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery("from IndexProduct i where i.product.status=1 and 1=1 ").list().size();
    }
}
