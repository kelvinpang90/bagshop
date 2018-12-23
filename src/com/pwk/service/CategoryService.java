package com.pwk.service;

import com.pwk.entity.Attribute;
import com.pwk.entity.Category;

import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
public interface CategoryService {
    public void add(Category category);
    public void delete(int id);
    public void update(Category category);
    public Category getById(int id);
    public List<Category> getByList(int page,int size);
    public List<Category> getAll();
    public int getTotal();
}
