package com.pwk.service;

import com.pwk.entity.IndexPic;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-19
 * Time: 下午9:47
 * To change this template use File | Settings | File Templates.
 */
public interface IndexPicService {
    public void add(IndexPic indexPic);
    public void update(IndexPic indexPic);
    public IndexPic getById(int id);
}
