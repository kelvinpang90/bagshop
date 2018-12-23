package com.pwk.action;

import com.pwk.entity.IndexPic;
import com.pwk.service.IndexPicService;
import com.pwk.tools.Message;
import com.pwk.tools.Upload;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-19
 * Time: 下午10:02
 * To change this template use File | Settings | File Templates.
 */
public class IndexPicAction extends BrandAction{
    @Resource
    private IndexPicService indexPicService;

    private static final Logger LOG = LogManager.getLogger(IndexPicAction.class.getName());

    public String updateIndexPic(){
        try {
            IndexPic indexPic1 = indexPicService.getById(1);
            IndexPic indexPic2 = indexPicService.getById(2);
            IndexPic indexPic3 = indexPicService.getById(3);
            IndexPic indexPic4 = indexPicService.getById(4);
            String description1 = getRequest().getParameter("description1");
            String description2 = getRequest().getParameter("description2");
            String description3 = getRequest().getParameter("description3");
            String description4 = getRequest().getParameter("description4");
            String picPath1 = getRequest().getParameter("picPath1");
            String picPath2 = getRequest().getParameter("picPath2");
            String picPath3 = getRequest().getParameter("picPath3");
            String picPath4 = getRequest().getParameter("picPath4");
            if(indexPic1==null){
                indexPic1 = new IndexPic();
                indexPic1.setId(1);
                indexPic1.setDescription(description1);
                indexPic1.setPic(picPath1);
                indexPicService.add(indexPic1);
            }else{
                indexPic1.setDescription(description1);
                indexPic1.setPic(picPath1);
                indexPicService.update(indexPic1);
            }
            if(indexPic2==null){
                indexPic2 = new IndexPic();
                indexPic2.setId(2);
                indexPic2.setDescription(description2);
                indexPic2.setPic(picPath2);
                indexPicService.add(indexPic2);
            }else{
                indexPic2.setDescription(description2);
                indexPic2.setPic(picPath2);
                indexPicService.update(indexPic2);
            }
            if(indexPic3==null){
                indexPic3 = new IndexPic();
                indexPic3.setId(3);
                indexPic3.setDescription(description3);
                indexPic3.setPic(picPath3);
                indexPicService.add(indexPic3);
            }else{
                indexPic3.setDescription(description3);
                indexPic3.setPic(picPath3);
                indexPicService.update(indexPic3);
            }
            if(indexPic4==null){
                indexPic4 = new IndexPic();
                indexPic4.setId(4);
                indexPic4.setDescription(description4);
                indexPic4.setPic(picPath4);
                indexPicService.add(indexPic4);
            }else{
                indexPic4.setDescription(description4);
                indexPic4.setPic(picPath4);
                indexPicService.update(indexPic4);
            }
            LOG.info("更新首页图片成功！");
            Message.returnMessage("ok", "", "ok", getResponse());
        }catch (Exception e){
            LOG.error("更新首页图片异常！");
            e.printStackTrace();
            Message.returnMessage("error", "", "error", getResponse());
        }
        return null;
    }
}
