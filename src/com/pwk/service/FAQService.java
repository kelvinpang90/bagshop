package com.pwk.service;

import com.pwk.entity.FAQ;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-3
 * Time: 下午9:01
 * To change this template use File | Settings | File Templates.
 */
public interface FAQService {
    public void add(FAQ faq);
    public void update(FAQ faq);
    public void delete(int id);
    public FAQ getById(int id);
    public List<FAQ> getAll();
}
