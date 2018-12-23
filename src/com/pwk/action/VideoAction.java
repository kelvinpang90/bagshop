package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Video;
import com.pwk.service.VideoService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-3-7
 * Time: 下午7:14
 * To change this template use File | Settings | File Templates.
 */
public class VideoAction extends BaseAction {
    @Resource
    private VideoService videoService;

    private static final Logger LOG = LogManager.getLogger(VideoAction.class.getName());

    public String add(){
        try {
            String name = getRequest().getParameter("name");
            String link = getRequest().getParameter("link");
            Video video = new Video();
            video.setName(name);
            video.setLink(link);
            videoService.add(video);
            LOG.info("视频添加成功！");
            Message.returnMessage("add video success","/back/video/videoList.jsp","ok",getResponse());
        }catch (Exception e){
            LOG.error("视频添加异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String update(){
        try {
            String id = getRequest().getParameter("id");
            String name = getRequest().getParameter("name");
            String link = getRequest().getParameter("link");
            Video video = videoService.getById(Integer.valueOf(id));
            video.setName(name);
            video.setLink(link);
            videoService.update(video);
            LOG.info("视频更新成功！");
            Message.returnMessage("update video success","/back/video/videoList.jsp","ok",getResponse());
        }catch (Exception e){
            LOG.info("视频更新异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String delete(){
        try {
            String id = getRequest().getParameter("id");
            videoService.delete(Integer.valueOf(id));
            LOG.info("视频删除成功！");
            getResponse().sendRedirect("/back/video/videoList.jsp");
        }catch (Exception e){
            LOG.info("视频删除异常！");
            e.printStackTrace();
        }
        return null;
    }
}
