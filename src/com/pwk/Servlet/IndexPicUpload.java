package com.pwk.Servlet;

import com.pwk.tools.Upload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-21
 * Time: 下午9:09
 * To change this template use File | Settings | File Templates.
 */
public class IndexPicUpload extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
            String path = "upload/indexPic/" + format.format(new Date());
//            Upload.uploadPics(req, resp, path, 2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
