package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.IndexProduct;
import com.pwk.entity.Product;
import com.pwk.service.IndexProductService;
import com.pwk.service.ProductService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午7:20
 * To change this template use File | Settings | File Templates.
 */
public class IndexProductAction extends BaseAction {

    @Resource
    private IndexProductService indexProductService;
    @Resource
    private ProductService productService;

    private static final Logger LOG = LogManager.getLogger(IndexPicAction.class.getName());

    public String addIndexProduct(){
        try {
            String productId = getRequest().getParameter("productId");
            String position = getRequest().getParameter("position");
            IndexProduct indexProduct = new IndexProduct();
            Product product = productService.getProductById(Integer.valueOf(productId),true);
            indexProduct.setProduct(product);
            indexProduct.setPosition(Integer.valueOf(position));
            indexProduct.setStatus("1");
            indexProductService.add(indexProduct);
            LOG.info("添加首页商品成功！");
            Message.returnMessage("添加首页商品成功！", "../../back/indexProduct/indexProductList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("添加首页商品异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String updateIndexProduct(){
        try {
            String id = getRequest().getParameter("id");
            String position = getRequest().getParameter("position");
            String productId = getRequest().getParameter("productId");
            Product product = productService.getProductById(Integer.valueOf(productId), false);
            IndexProduct indexProduct = indexProductService.getById(Integer.valueOf(id));
            indexProduct.setProduct(product);
            indexProduct.setPosition(Integer.valueOf(position));
            indexProductService.update(indexProduct);
            LOG.info("修改首页商品成功！");
            Message.returnMessage("修改首页商品成功！", "../../back/indexProduct/indexProductList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("修改首页商品异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String deleteIndexProduct(){
        try {
           String id = getRequest().getParameter("id");
            indexProductService.delete(Integer.valueOf(id));
            LOG.info("删除首页商品成功！");
            getResponse().sendRedirect("../../back/indexProduct/indexProductList.jsp");
        }catch (Exception e){
            LOG.error("删除首页商品异常！");
            e.printStackTrace();
        }
        return null;
    }
}
