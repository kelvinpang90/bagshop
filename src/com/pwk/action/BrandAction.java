package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Brand;
import com.pwk.entity.Image;
import com.pwk.service.BrandService;
import com.pwk.service.ImageService;
import com.pwk.tools.Message;
import com.pwk.tools.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-20
 * Time: 下午4:41
 * To change this template use File | Settings | File Templates.
 */
public class BrandAction extends BaseAction {

    @Resource
    private BrandService brandService;
    @Resource
    private ImageService imageService;

    private static final Logger LOG = LogManager.getLogger(BrandAction.class.getName());

    public String brandAdd(){
        try {
            String brandName = getRequest().getParameter("name");
            String picId = getRequest().getParameter("picId");
            String order = getRequest().getParameter("order");
            Brand brand = new Brand();
            brand.setBrandName(brandName);
            brand.setPosition(Integer.valueOf(order));
            brand.setStatus(1);
            brandService.add(brand);
            if (StringUtils.isNotBlank(picId)) {
                Image image = imageService.getById(Integer.valueOf(picId));
                image.setParentId(brand.getId());
                image.setType("brand");
                imageService.update(image);
            }
            LOG.info("添加品牌成功！");
            Message.returnMessage("添加品牌成功", "/back/brand/brandList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("添加品牌异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String brandUpdate() {
        try {
            String id = getRequest().getParameter("id");
            Brand brand = brandService.getBrandById(Integer.valueOf(id));
            String brandName = getRequest().getParameter("brandName");
            String picId = getRequest().getParameter("picId");
            String order = getRequest().getParameter("order");
            brand.setBrandName(brandName);
            brand.setPosition(Integer.valueOf(order));

            Set<Image> oldImages = brand.getPicPath();

            /**
             * 修改颜色图片
             * 1.判断颜色旧图与新图是否一致
             * 2.不一致，则在图片添加上颜色Id，删除旧图
             */
            Iterator<Image> it = oldImages.iterator();
            if(!it.hasNext()){
                Image newImage = imageService.getById(Integer.valueOf(picId));
                newImage.setType("brand");
                newImage.setParentId(Integer.valueOf(id));
                imageService.update(newImage);
            }else{
                while (it.hasNext()){
                    Image oldImage = it.next();
                    if(oldImage.getId() != Integer.valueOf(picId)){
                        Image newImage = imageService.getById(Integer.valueOf(picId));
                        newImage.setType("brand");
                        newImage.setParentId(Integer.valueOf(id));
                        imageService.update(newImage);
                        imageService.delete(oldImage.getId());
                    }
                }
            }
            brandService.update(brand);
            LOG.info("修改品牌成功！");
            Message.returnMessage("修改品牌成功", "/back/brand/brandList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("修改品牌异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String brandDelete() {
        try {
            String id = getRequest().getParameter("id");
            brandService.delete(Integer.valueOf(id));
            LOG.info("删除品牌成功！");
            getResponse().sendRedirect("/back/brand/brandList.jsp");
        } catch (Exception e) {
            LOG.error("删除品牌异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String setStatus(){
        try {
            String id = getRequest().getParameter("id");
            String status = getRequest().getParameter("status");
            Brand brand = brandService.getBrandById(Integer.valueOf(id));
            brand.setStatus(Integer.valueOf(status));
            brandService.update(brand);
            LOG.info("设置品牌状态成功！ id="+id+"  status="+status);
            getResponse().sendRedirect("/back/brand/brandList.jsp");
        }catch (Exception e){
            LOG.error("设置品牌状态异常！");
            e.printStackTrace();
        }
        return null;
    }
}
