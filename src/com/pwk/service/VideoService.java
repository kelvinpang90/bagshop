package com.pwk.service;

import com.pwk.entity.Video;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-3-7
 * Time: 下午7:09
 * To change this template use File | Settings | File Templates.
 */
public interface VideoService {
    public void add(Video video);
    public void update(Video video);
    public void delete(int id);
    public Video getById(int id);
    public List<Video> getByList(int page,int size);
    public int getTotal();
}
