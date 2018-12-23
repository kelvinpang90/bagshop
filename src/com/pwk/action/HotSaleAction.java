package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Brand;
import com.pwk.entity.HotSale;
import com.pwk.entity.Product;
import com.pwk.service.HotSaleService;
import com.pwk.service.ProductService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午3:00
 * To change this template use File | Settings | File Templates.
 */
public class HotSaleAction extends BaseAction {

    @Resource
    private HotSaleService hotSaleService;
    @Resource
    private ProductService productService;

    private static final Logger LOG = LogManager.getLogger(HotSaleAction.class.getName());

    public String addHotSale() throws Exception {
        try {
            String productId = getRequest().getParameter("productId");
            String position = getRequest().getParameter("position");
            Product product = productService.getProductById(Integer.valueOf(productId),true);
            HotSale hotSale = new HotSale();
            hotSale.setProduct(product);
            hotSale.setPosition(Integer.valueOf(position));
            hotSaleService.addHotSale(hotSale);
            LOG.info("添加热卖商品成功！");
            Message.returnMessage("添加热卖商品成功！", "../../back/hotSale/hotSaleList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("添加热卖商品异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String updateHotSale() throws Exception {
        try {
            String id = getRequest().getParameter("id");
            String position = getRequest().getParameter("position");
            String productId = getRequest().getParameter("productId");
            Product product = productService.getProductById(Integer.valueOf(productId), false);
            HotSale hotSale = hotSaleService.getHotSaleById(Integer.valueOf(id));
            hotSale.setProduct(product);
            hotSale.setPosition(Integer.valueOf(position));
            hotSaleService.updateHotSale(hotSale);
            LOG.info("修改热卖商品成功！");
            Message.returnMessage("修改热卖商品成功！", "../../back/hotSale/hotSaleList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("修改热卖商品异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String deleteHotSale() throws Exception {
        try {
            String id = getRequest().getParameter("id");
            hotSaleService.deleteHotSale(Integer.valueOf(id));
            LOG.info("删除热卖商品成功！");
            getResponse().sendRedirect("../back/hotSale/hotSaleList.jsp");
        } catch (Exception e) {
            LOG.error("删除热卖商品异常！");
            e.printStackTrace();
        }
        return null;
    }
}
