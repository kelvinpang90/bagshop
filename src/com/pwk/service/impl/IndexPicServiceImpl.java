package com.pwk.service.impl;

import com.pwk.entity.IndexPic;
import com.pwk.service.IndexPicService;
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
public class IndexPicServiceImpl implements IndexPicService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(IndexPic indexPic) {
        sessionFactory.getCurrentSession().save(indexPic);
    }

    @Override
    public void update(IndexPic indexPic) {
        sessionFactory.getCurrentSession().update(indexPic);
    }

    @Override
    public IndexPic getById(int id) {
        return (IndexPic)sessionFactory.getCurrentSession().get(IndexPic.class,id);
    }
}
