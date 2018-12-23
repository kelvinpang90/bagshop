package com.pwk.service;

import com.pwk.entity.IndexProduct;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午2:50
 * To change this template use File | Settings | File Templates.
 */
public interface IndexProductService {
    public void add(IndexProduct indexProduct);
    public void delete(int id);
    public void deleteByProductId(int id);
    public void update(IndexProduct indexProduct);
    public IndexProduct getById(int id);
    public List<IndexProduct> getByList(int page,int size);
    public int getTotal();
}
