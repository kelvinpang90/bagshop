package com.pwk.service.impl;

import com.pwk.entity.HotSale;
import com.pwk.service.HotSaleService;
import org.hibernate.Criteria;
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
 * Time: 下午2:42
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class HotSaleServiceImpl implements HotSaleService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void addHotSale(HotSale hotSale) {
        sessionFactory.getCurrentSession().save(hotSale);
    }

    @Override
    public void updateHotSale(HotSale hotSale) {
        sessionFactory.getCurrentSession().update(hotSale);
    }

    @Override
    public void deleteHotSale(int id) {
        sessionFactory.getCurrentSession().delete(this.getHotSaleById(id));
     }

    @Override
    public void deleteHotSaleByProductId(int id) {
        Query query = sessionFactory.getCurrentSession().createQuery("delete from HotSale h where h.product.id=:id");
        query.setParameter("id",id, Hibernate.INTEGER);
    }

    @Override
    public HotSale getHotSaleById(int id) {
        return (HotSale)sessionFactory.getCurrentSession().get(HotSale.class,id);
    }

    @Override
    public List<HotSale> getHotSaleByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 10;
        }
        Query query = sessionFactory.getCurrentSession().createQuery("from HotSale h where h.product.status=1 order by h.position");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public List<HotSale> getByBrandId(int bId, int page, int size) {
        Query query = null;
        if(page==0||size==0){
            page = 1;
            size = 10;
        }
        if(bId==0){
            query = sessionFactory.getCurrentSession().createQuery("from HotSale h where h.product.status=1 order by h.position");
        }else{
            query = sessionFactory.getCurrentSession().createQuery("from HotSale h where h.product.status=1 and h.product.brand.id=:id order by h.position");
            query.setParameter("id",bId,Hibernate.INTEGER);
        }
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery("from HotSale h where h.product.status=1 and 1=1").list().size();
    }
}
