package com.pwk.service;

import com.pwk.entity.Attribute;

import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
public interface AttributeService {
    public void add(Attribute attribute);
    public void update(Attribute attribute);
    public void delete(int id);
    public Attribute getById(int id);
    public List<Attribute> getByList(int page,int size);
    public List<Attribute> getAll();
    public int getTotal();
}
