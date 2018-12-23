package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.*;
import com.pwk.lucene.ProductLuceneService;
import com.pwk.service.*;
import com.pwk.taglib.UrlFunction;
import com.pwk.tools.Message;
import com.pwk.tools.StringTools;
import com.pwk.tools.Upload;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.helpers.Booleans;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-20
 * Time: 下午4:15
 * To change this template use File | Settings | File Templates.
 */
public class ProductAction extends BaseAction {

    @Resource
    private ProductService productService;
    @Resource
    private BrandService brandService;
    @Resource
    private ColorService colorService;
    @Resource
    private ProductLuceneService productLuceneService;
    @Resource
    private IndexProductService indexProductService;
    @Resource
    private HotSaleService hotSaleService;
    @Resource
    private ImageService imageService;
    @Resource
    private CategoryService categoryService;
    @Resource
    ParameterService parameterService;
    @Resource
    AttributeService attributeService;

    private static final Logger LOG = LogManager.getLogger(OrderAction.class.getName());

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String productAdd() throws Exception {
        try {
            String name = getRequest().getParameter("productName");
            String price = getRequest().getParameter("price");
            String type = getRequest().getParameter("type");
            String[] picIds = getRequest().getParameterValues("picId");
            String description = getRequest().getParameter("description");
            String brandId = getRequest().getParameter("brandId");
            String categoryId = getRequest().getParameter("categoryId");
            String[] colorIds = getRequest().getParameterValues("colorId");
            String[] attributeIds = getRequest().getParameterValues("attributeId");
            Brand brand = brandService.getBrandById(Integer.valueOf(brandId));

            Category category = categoryService.getById(Integer.valueOf(categoryId));

            Product product = new Product();
            product.setName(name);
            product.setPrice(Float.valueOf(price));
            product.setType(type);
            product.setBrand(brand);
            product.setCategory(category);
            product.setDescription(description);
            product.setCreateDate(Timestamp.valueOf(format.format(new Date())));
            product.setUpdateDate(Timestamp.valueOf(format.format(new Date())));
            product.setStatus("1");
            product.setStockStatus(1);
            if(colorIds == null ||colorIds.length==0){
                Message.returnMessage("please select color","close","ok",getResponse());
                return null;
            }
            for (String colorId : colorIds) {
                Color color = colorService.getById(Integer.valueOf(colorId));
                product.getColors().add(color);
            }

            productService.add(product);

            //attribute
            if(attributeIds!=null&&attributeIds.length!=0){
                for(String attributeId:attributeIds){
                    Attribute attribute = attributeService.getById(Integer.valueOf(attributeId));
                    attribute.setpId(product.getId());
                    attributeService.update(attribute);
                }
            }

            //image
            for (String picId : picIds) {
                if (StringUtils.isNotBlank(picId)) {
                    Image image = imageService.getById(Integer.valueOf(picId));
                    image.setParentId(product.getId());
                    image.setType("product");
                    imageService.update(image);
                }
            }

            productLuceneService.addProductIndex(product);
            LOG.info("商品添加成功！");
            Message.returnMessage("add product success！", "../../back/product/productList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("商品添加异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String productDelete() {
        try {
            String id = getRequest().getParameter("id");
            indexProductService.deleteByProductId(Integer.valueOf(id));
            hotSaleService.deleteHotSaleByProductId(Integer.valueOf(id));
            productLuceneService.deleteProductIndex(Integer.valueOf(id));
            productService.delete( Integer.valueOf(id));
            LOG.info("商品" + id + "删除成功！");
            getResponse().sendRedirect("../../back/product/productList.jsp");
        } catch (Exception e) {
            LOG.error("商品删除异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String setProductStatus() {
        try {
            String id = getRequest().getParameter("id");
            String status = getRequest().getParameter("status");
            Product product = productService.getProductById(Integer.valueOf(id), true);
            if (product != null) {
                if (StringUtils.equals(status, "1")) {
                    product.setStatus("1");
                } else if (StringUtils.equals(status, "0")) {
                    indexProductService.deleteByProductId(Integer.valueOf(id));
                    hotSaleService.deleteHotSaleByProductId(Integer.valueOf(id));
                    product.setStatus("0");
                }
                productService.update(product);
            }
            LOG.info("商品设置状态成功！");
        } catch (Exception e) {
            LOG.error("商品设置状态异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String setStockStatus() {
        try {
            String id = getRequest().getParameter("id");
            String status = getRequest().getParameter("status");
            Product product = productService.getProductById(Integer.valueOf(id), true);
            if (product != null) {
                if (StringUtils.equals(status, "1")) {
                    product.setStockStatus(1);
                } else if (StringUtils.equals(status, "0")) {
                    product.setStockStatus(0);
                }
                productService.update(product);
            }
            LOG.info("设置库存状态成功！");
        } catch (Exception e) {
            LOG.error("设置库存状态失败！");
            e.printStackTrace();
        }
        return null;
    }

    public String productUpdate() {
        try {
            int id = Integer.valueOf(getRequest().getParameter("id"));
            String name = getRequest().getParameter("productName");
            String price = getRequest().getParameter("price");
            String type = getRequest().getParameter("type");
            String description = getRequest().getParameter("description");
            String brandId = getRequest().getParameter("brandId");
            String categoryId = getRequest().getParameter("categoryId");
            String[] colorIds = getRequest().getParameterValues("colorId");
            String[] newPicIds = getRequest().getParameterValues("picId");
            String[] attributeIds = getRequest().getParameterValues("attributeId");
            Brand brand = brandService.getBrandById(Integer.valueOf(brandId));
            Category category = categoryService.getById(Integer.valueOf(categoryId));
            Product oldProduct = productService.getProductById(id, true);
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setPrice(Float.valueOf(price));
            product.setType(type);
            product.setBrand(brand);
            product.setCategory(category);
            product.setDescription(description);
            product.setUpdateDate(Timestamp.valueOf(format.format(new Date())));
            product.setStatus(oldProduct.getStatus());
            product.setStockStatus(oldProduct.getStockStatus());
            product.setCreateDate(oldProduct.getCreateDate());
            productService.deleteProductColorLink(id);
            Set<Image> images = oldProduct.getPicPath();

            //colors
            if(colorIds == null || colorIds.length == 0){
                Message.returnMessage("please select color","","ok",getResponse());
                return null;
            }
            for (String colorId : colorIds) {
                Color color = colorService.getById(Integer.valueOf(colorId));
                product.getColors().add(color);
            }

            //attribute
            if(attributeIds!=null&&attributeIds.length!=0){
                for(String attributeId:attributeIds){
                    Attribute attribute = attributeService.getById(Integer.valueOf(attributeId));
                    product.getAttributes().add(attribute);
                }
            }

            if(newPicIds == null || newPicIds.length==0){
                Message.returnMessage("picture cannot be zero！", "../../back/product/productUpdate.jsp", "ok", getResponse());
                return null;
            }
        //删除旧图片
            Iterator<Image> oldImages = images.iterator();
            while (oldImages.hasNext()){
                boolean flag = false;
                Image oldImage = oldImages.next();
                for(String newPic:newPicIds){
                    if(oldImage.getId() == Integer.valueOf(newPic)){
                        flag = true;
                    }
                }
                if (!flag){
                    imageService.delete(oldImage.getId());
                }
            }
        //添加新图片
            for(String newIds:newPicIds){
                Image newImage = imageService.getById(Integer.valueOf(newIds));
                newImage.setParentId(id);
                newImage.setType("product");
                product.getPicPath().add(newImage);
            }


            productService.update(product);
            productLuceneService.updateProductIndex(product);
            LOG.info("商品修改成功！");
            Message.returnMessage("商品修改成功！", "../../back/product/productList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("商品修改异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String getProductByBrandId() {
        try {
            String brandId = getRequest().getParameter("brandId");
            String page = getRequest().getParameter("page");
            String size = getRequest().getParameter("size");
            if (StringUtils.isBlank(size) || StringUtils.isBlank(page)) {
                page = "1";
                size = "10";
            }
            List<Product> products = productService.getProductByBrandId(Integer.valueOf(brandId), Integer.valueOf(page), Integer.valueOf(size), false);
            String sb = "";
            if (products != null && products.size() > 0) {
                sb += ("<select name='productId' id='productId' class='form-control'>");
                for(Product product:products){
                    sb += ("<option value='" +product.getId() + "'>" +product.getName() + "<option>");
                }
                sb += ("</select>");
            }
            getResponse().setCharacterEncoding("utf-8");
            getResponse().getWriter().print(StringUtils.trim(sb));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String refreshProduct() {
        try {
            String id = getRequest().getParameter("id");
            Product product = productService.getProductById(Integer.valueOf(id), true);
            if (product.getCreateDate() == null) {
                product.setCreateDate(Timestamp.valueOf(format.format(new Date())));
            }
            product.setUpdateDate(Timestamp.valueOf(format.format(new Date())));
            productService.update(product);
//            productLuceneService.updateProductIndex(product);
            LOG.info("商品刷新成功！");
            getResponse().sendRedirect("/back/product/productList.jsp");
        } catch (Exception e) {
            LOG.error("商品刷新异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String getProductName() throws IOException {
        String keyword = getRequest().getParameter("keyword");
        List<Product> products = productService.getProductByKeyword(keyword, 1, 10, true);
        List<String> productList = new ArrayList<String>();
//        JSONObject returnObject = new JSONObject();
//        for(Product product:products){
//            productList.add(product.getName());
//        }
//        returnObject.put("names", productList.toString());
//        Upload.returnAjaxUpload(getRequest(), getResponse(), returnObject.toString());
        JSONArray jsonArray = new JSONArray();
        for(Product product:products){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name",product.getName());
            jsonArray.add(jsonObject);
        }
        Upload.returnAjaxUpload(getRequest(), getResponse(), jsonArray.toString());
        return null;
    }

    public String addProductIndex() {
        try {
            System.out.println("start indexing===============");
            List<Product> products = productService.getAllProducts(true);
            for(Product product:products){
                productLuceneService.addProductIndex(product);
                System.out.println("product="+product.getName());
            }
            System.out.println("index end================");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String deleteProductIndex() {
        try {
            productLuceneService.deleteProductIndex(Integer.valueOf(getParameter("id")));
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String search(){
        try {
            String field = getRequest().getParameter("field");
            String keyword = getRequest().getParameter("keyword");
            String status = getRequest().getParameter("status");
            if(StringUtils.equals(getParameter("method"),"fuzzy"))
                productLuceneService.searchByField_Fuzzy(field,keyword,1,10, Boolean.valueOf(status));
            if(StringUtils.equals(getParameter("method"),"precise"))
                productLuceneService.searchByField_Precise(field,keyword,1,10,Boolean.valueOf(status));
            if(StringUtils.equals(getParameter("method"),"normal"))
                productLuceneService.searchByKeyword(keyword,1,10,Boolean.valueOf(status));
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String searchTotal(){
        try {
            String field = getRequest().getParameter("field");
            String keyword = getRequest().getParameter("keyword");
            String status = getRequest().getParameter("status");
            if(StringUtils.equals(getParameter("method"),"fuzzy"))
                productLuceneService.getTotalByField_Fuzzy(field,keyword,Boolean.valueOf(status));
            if(StringUtils.equals(getParameter("method"),"precise"))
                productLuceneService.getTotalByField_Precise(field,keyword,Boolean.valueOf(status));
            if(StringUtils.equals(getParameter("method"),"normal"))
                productLuceneService.getTotalByKeyword(keyword,Boolean.valueOf(status));
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String loadMore() {
        try {
            String bId = getRequest().getParameter("bid");
            String cId = getRequest().getParameter("cid");
            String keyword = getRequest().getParameter("keyword");
            String count = getRequest().getParameter("count");
            List<Product> products = null;
            if (StringUtils.isNotBlank(bId) && !StringUtils.equals(bId, "0")) {
                products = productService.getProductByBrandId(Integer.valueOf(bId), Integer.valueOf(count), 9, false);
            }else if(StringUtils.isNotBlank(cId) && !StringUtils.equals(cId, "0")){
                products = productService.getProductByCategoryId(Integer.valueOf(cId), Integer.valueOf(count), 9, false);
            } else if (StringUtils.isNotBlank(keyword) && !StringUtils.equals(keyword, "null")) {
                products = productLuceneService.searchByKeyword(keyword,Integer.valueOf(count),9,false);
            } else {
                products = productService.getProductByList(Integer.valueOf(count), 9, false);
            }
            getResponse().getWriter().append(buildProductHtml(products));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String changeImageStructure2(){
        try {

        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String changeDescriptionStructure(){
        try{
            List<Product> products = productService.getAllProducts(true);
            for(Product p:products){
                String d = p.getDescription();
                String d1 = d.replaceAll("\\/upload\\/","http://pic.myparisbags.com/upload/");
                p.setDescription(d1);
                productService.update(p);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
            return null;
    }

    private String buildProductHtml(List<Product> products) {
        StringBuilder html = new StringBuilder();
        try {
            for (int i = 0; i < products.size(); i++) {
                if (i == 0 || i == 3 || i == 6) {
                    html.append("<div class='list-items'>");
                }
                html.append("<div class='single-item'>");
                html.append("<span class='title'>");
                html.append("<a href='details_" + products.get(i).getId() + ".html' target='_blank' title='" + products.get(i).getName() + "'>" + (products.get(i).getName().length() > 20 ? products.get(i).getName().substring(0, 20) : products.get(i).getName()) + "</a>");
                html.append("</span>");
                html.append("<span class='price'>RM " + products.get(i).getPrice() + "</span>");
                html.append("<a href='details_" + products.get(i).getId() + ".html' target='_blank'>");
                Iterator<Image> it = products.get(i).getPicPath().iterator();
                html.append("<img src='" + UrlFunction.getPicDomain() + "/" + (it.hasNext() ? it.next().getMiniPath() : "") + "' alt='Item' width='180' height='180'/>");
                html.append("</a>");
                html.append("<span class='list-link'>");
                html.append("<a href='details_" + products.get(i).getId() + ".html' class='general-button float-left'><span class='button'>Detail</span></a>");
                html.append("</span>");
                html.append("<br class='clear'/>");
                html.append("</div>");
                if (i == 2 || i == 5 || i == 8 || i == (products.size() - 1)) {
                    html.append("</div>");
                }
                if (i == 8 && products.size() == 9) {
                    html.append("<div id='loadDiv' style='float: right'>");
                    html.append(" <a href='javascript:loadMore()' class='general-button float-left'><span class='button' id='loadButton'>Load More</span></a>");
                    html.append("</div>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return html.toString();
    }
}
