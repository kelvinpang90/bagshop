package com.pwk.service.impl;

import com.pwk.entity.TransactionHistory;
import com.pwk.service.TransactionHistoryService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wenkai.peng on 1/2/2015.
 */
@Transactional
public class TransactionHistoryServiceImpl implements TransactionHistoryService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public List<TransactionHistory> getAll(Integer year) {
        Query query = sessionFactory.getCurrentSession().createQuery(" from TransactionHistory th where th.year =:year order by th.month,th.day ");
        query.setParameter("year",year, Hibernate.INTEGER);
        return query.list();
    }
}
