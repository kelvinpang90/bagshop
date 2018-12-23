package com.pwk.service;

import com.pwk.entity.Brand;
import com.pwk.entity.IndexProduct;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-17
 * Time: 下午8:37
 * To change this template use File | Settings | File Templates.
 */
public interface BrandService {
    public void add(Brand brand);

    public void delete(Integer id);

    public void update(Brand brand);

    public Brand getBrandById(int id);

    public List<Brand> getAllBrand();

    public List<Brand> getBrandsByStatus(int status);

}
