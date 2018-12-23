package com.pwk.service.impl;

import com.pwk.entity.Brand;
import com.pwk.service.BrandService;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-17
 * Time: 下午8:38
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class BrandServiceImpl implements BrandService {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(Brand brand) {
        sessionFactory.getCurrentSession().save(brand);
    }

    @Override
    public void delete(Integer id) {
        sessionFactory.getCurrentSession().delete(this.getBrandById(id));
    }

    @Override
    public void update(Brand brand) {
        sessionFactory.getCurrentSession().update(brand);
    }

    @Override
    public Brand getBrandById(int id) {
        return (Brand) sessionFactory.getCurrentSession().get(Brand.class, id);
    }

    @Override
    public List<Brand> getAllBrand() {
        return sessionFactory.getCurrentSession().createQuery("from Brand b order by b.position ").list();
    }

    @Override
    public List<Brand> getBrandsByStatus(int status) {
        return sessionFactory.getCurrentSession().createQuery("from Brand b where b.status=1 order by b.position ").list();
    }

}
