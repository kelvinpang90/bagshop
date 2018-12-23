package com.pwk.service.impl;

import com.pwk.entity.Video;
import com.pwk.service.VideoService;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-3-7
 * Time: 下午7:11
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class VideoServiceImpl implements VideoService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void add(Video video) {
        sessionFactory.getCurrentSession().save(video);
    }

    @Override
    public void update(Video video) {
        sessionFactory.getCurrentSession().update(video);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public Video getById(int id) {
        return (Video)sessionFactory.getCurrentSession().get(Video.class,id);
    }

    @Override
    public List<Video> getByList(int page, int size) {
        if(page==0||size==0){
            page = 1;
            size = 10;
        }
        Query query = sessionFactory.getCurrentSession().createQuery("from Video");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery("from Video").list().size();
    }
}
