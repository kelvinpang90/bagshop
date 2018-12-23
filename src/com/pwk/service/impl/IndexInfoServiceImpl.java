package com.pwk.service.impl;

import com.pwk.entity.IndexInfo;
import com.pwk.service.IndexInfoService;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-19
 * Time: 下午9:48
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class IndexInfoServiceImpl implements IndexInfoService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(IndexInfo indexInfo) {
        sessionFactory.getCurrentSession().save(indexInfo);
    }

    @Override
    public void update(IndexInfo indexInfo) {
        sessionFactory.getCurrentSession().update(indexInfo);
    }

    @Override
    public IndexInfo getById(int id) {
        return (IndexInfo)sessionFactory.getCurrentSession().get(IndexInfo.class,id);
    }
}
