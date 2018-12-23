package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Color;
import com.pwk.entity.Image;
import com.pwk.service.ColorService;
import com.pwk.service.ImageService;
import com.pwk.tools.Message;
import com.pwk.tools.StringTools;
import com.pwk.tools.Upload;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

/**
 * Created by Administrator on 14-1-13.
 */
public class ColorAction extends BaseAction {

    @Resource
    private ColorService colorService;
    @Resource
    private ImageService imageService;

    private static final Logger LOG = LogManager.getLogger(ColorAction.class.getName());

    public String addColor(){
        try {
            String name = getRequest().getParameter("color");
            String picId = getRequest().getParameter("picId");
            Color color = new Color();
            color.setName(name);
            colorService.add(color);
            if (StringUtils.isNotBlank(picId)) {
                Image image = imageService.getById(Integer.valueOf(picId));
                image.setParentId(color.getId());
                image.setType("color");
                imageService.update(image);
            }
            LOG.info("添加颜色成功   "+name);
            Message.returnMessage("添加颜色成功！", "../../back/color/colorList.jsp", "ok", getResponse());
        }catch (Exception e){
            LOG.error("添加颜色异常");
            e.printStackTrace();
        }
        return null;
    }

    public String updateColor(){
        try {
            String id = getRequest().getParameter("id");
            String name = getRequest().getParameter("color");
            String picId = getRequest().getParameter("picId");
            Color color = colorService.getById(Integer.valueOf(id));
            color.setName(name);
            Set<Image> oldImages = color.getPicPath();

            /**
             * 修改颜色图片
             * 1.判断颜色旧图与新图是否一致
             * 2.不一致，则在图片添加上颜色Id，删除旧图
             */
            Iterator<Image> it = oldImages.iterator();
            while (it.hasNext()){
                Image oldImage = it.next();
                if(oldImage.getId() != Integer.valueOf(picId)){
                    Image newImage = imageService.getById(Integer.valueOf(picId));
                    newImage.setType("color");
                    newImage.setParentId(Integer.valueOf(id));
                    imageService.update(newImage);
                    imageService.delete(oldImage.getId());
                }
            }

            colorService.update(color);
            LOG.info("修改颜色成功  "+name);
            Message.returnMessage("修改颜色成功！", "../../back/color/colorList.jsp", "ok", getResponse());
        }catch (Exception e){
            LOG.error("修改颜色异常");
            e.printStackTrace();
        }
        return null;
    }

    public String colorDelete(){
        try {
            String id = getRequest().getParameter("id");
            colorService.delete(Integer.valueOf(id));
            LOG.info("删除颜色成功！   "+id);
            getResponse().sendRedirect("../../back/color/colorList.jsp");
        }catch (Exception e){
            LOG.error("删除颜色异常");
            e.printStackTrace();
        }
        return null;
    }
}
