package com.pwk.taglib;

import com.pwk.entity.Video;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-3-7
 * Time: 下午7:20
 * To change this template use File | Settings | File Templates.
 */
public class VideoFunction {
    public static Video getById(int id){
         return Engine.videoService.getById(id);
    }
    public static List<Video> getByList(int page,int size){
        return Engine.videoService.getByList(page,size);
    }
}
