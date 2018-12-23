package com.pwk.Servlet;

import com.pwk.entity.Image;
import com.pwk.service.ImageService;
import com.pwk.service.impl.ImageServiceImpl;
import com.pwk.tools.StringTools;
import com.pwk.tools.Upload;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-16
 * Time: 下午8:27
 * To change this template use File | Settings | File Templates.
 */
@Component
public class ProductImageUpload extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        ImageService imageService = new ImageServiceImpl();
//        try {
//            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
//            SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String path = "upload/product/" + format.format(new Date());
//            String picPath = Upload.uploadPics(req, resp, path, 2);
//            System.out.println("picPath"+picPath);
//            Image image = new Image();
//            image.setType("product");
//            image.setPath(picPath);
//            image.setPath(StringTools.getSmallPics(picPath).get(0));
//            image.setCreateTime(Timestamp.valueOf(format2.format(new Date())));
//            imageService.add(image);
//            JSONObject returnObject = new JSONObject();
//            returnObject.put("picPath",picPath);
//            returnObject.put("picId",image.getId());
//            Upload.returnAjaxUpload(req,resp,returnObject.toString());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally {
//            imageService = null;
//        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
