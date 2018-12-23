package com.pwk.taglib;

import com.pwk.entity.Image;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created by wenkai.peng on 9/20/2014.
 */
public class ImageFunction {
    public static List<Image> getImagesById(String type,int id){
        return Engine.imageService.getListById(type,id);
    }
    public static List<Image> getByList(int page,int size){
        return Engine.imageService.getByList(page,size);
    }
    public static int getTotal(){
        return Engine.imageService.getTotal();
    }
}
