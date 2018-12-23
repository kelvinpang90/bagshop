package com.pwk.service.impl;

import com.pwk.entity.PaymentDetail;
import com.pwk.service.PaymentDetailService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wenkai.peng on 2014/5/24.
 */
@Transactional
public class PaymentDetailServiceImpl implements PaymentDetailService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(PaymentDetail paymentDetail) {
        sessionFactory.getCurrentSession().save(paymentDetail);
    }

    @Override
    public PaymentDetail getById(int id) {
        return (PaymentDetail) sessionFactory.getCurrentSession().get(PaymentDetail.class, id);
    }

    @Override
    public List<PaymentDetail> getByList(int page, int size) {
        if (page == 0 || size == 0) {
            page = 1;
            size = 10;
        }
        Query query = sessionFactory.getCurrentSession().createQuery("from PaymentDetail p order by p.payDate desc");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery("from PaymentDetail where 1=1").list().size();
    }

    @Override
    public List<PaymentDetail> getListByMonth(int page, int size,int year, int month) {
        if (page == 0 || size == 0) {
            page = 1;
            size = 10;
        }
        String sql = null;
        if(month != 0){
            sql = " from PaymentDetail p where date_format(p.payDate,'%Y')=:year and date_format(p.payDate,'%c')=:month order by p.payDate desc";
        }else{
            sql = " from PaymentDetail p where date_format(p.payDate,'%Y')=:year order by p.payDate desc";
        }
        Query query = sessionFactory.getCurrentSession().createQuery(sql);
        query.setParameter("year",year, Hibernate.INTEGER);
        if(month != 0){
            query.setParameter("month",month, Hibernate.INTEGER);
        }
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public int getTotalByMonth(int year,int month) {
        String sql = null;
        if(month != 0){
            sql = " from PaymentDetail p where date_format(p.payDate,'%Y')=:year and date_format(p.payDate,'%c')=:month ";
        }else{
            sql = " from PaymentDetail p where date_format(p.payDate,'%Y')=:year ";
        }
        Query query = sessionFactory.getCurrentSession().createQuery(sql);
        query.setParameter("year",year, Hibernate.INTEGER);
        if(month != 0){
            query.setParameter("month",month, Hibernate.INTEGER);
        }
        return query.list().size();
    }
}
