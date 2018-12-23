package com.pwk.tools;

import net.sf.json.JSONArray;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pwk on 5/12/2016.
 */
public class FilesTool {
    public static List<List<String>> getPicFromCategory(String path){
        try {
            File category = new File(path);
            if(category.exists()){
                File[] files = category.listFiles();
                if(files!=null&&files.length>0){
                    JSONArray lists = new JSONArray();
                    for(File file:files){
                        if(file.isDirectory()){
                            JSONArray images = new JSONArray();
                            images.add(file.getName());
                                for(File image:file.listFiles()){
                                    images.add(image.getName());
                                }
                                lists.add(images);
                        }
                    }
                    return lists;
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
