package com.pwk.service;

import com.pwk.entity.IndexInfo;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-19
 * Time: 下午9:46
 * To change this template use File | Settings | File Templates.
 */
public interface IndexInfoService {
    public void add(IndexInfo indexInfo);
    public void update(IndexInfo indexInfo);
    public IndexInfo getById(int id);
}
