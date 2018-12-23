package com.pwk.service.impl;

import com.pwk.entity.AboutUs;
import com.pwk.service.AboutUsService;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-12
 * Time: 下午9:31
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class AboutUsServiceImpl implements AboutUsService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void add(AboutUs aboutUs) {
        sessionFactory.getCurrentSession().save(aboutUs);
    }

    @Override
    public void update(AboutUs us) {
        sessionFactory.getCurrentSession().update(us);
    }

    @Override
    public AboutUs getAboutUs() {
        return (AboutUs)sessionFactory.getCurrentSession().createQuery("from AboutUs").uniqueResult();
    }
}
