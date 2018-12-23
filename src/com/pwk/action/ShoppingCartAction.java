package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.*;
import com.pwk.service.ColorService;
import com.pwk.service.ParameterService;
import com.pwk.service.ProductService;
import com.pwk.service.ShoppingCartService;
import com.pwk.tools.Message;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-10
 * Time: 下午4:21
 * To change this template use File | Settings | File Templates.
 */
public class ShoppingCartAction extends BaseAction {

    @Resource
    private ShoppingCartService shoppingCartService;
    @Resource
    private ProductService productService;
    @Resource
    private ColorService colorService;
    @Resource
    private ParameterService parameterService;

    private static final Logger LOG = LogManager.getLogger(ShoppingCartAction.class.getName());

    public String add() {
        try {
            User user = (User) getRequest().getSession().getAttribute("user");
            if (user == null) {
                Message.returnMessage("please log in first", "", "login", getResponse());
                return null;
            } else {
                List<ShoppingCart> shoppingCarts = shoppingCartService.getByUserId(user.getId());
                if (shoppingCarts.size() > 10) {
                    Message.returnMessage("products amount in shopping cart cannot more than 10", "", "amount", getResponse());
                    return null;
                }
                String productId = getRequest().getParameter("id");
                String count = getRequest().getParameter("count");
                String colorId = getRequest().getParameter("colorId");
                if (StringUtils.isBlank(colorId)) {
                    Message.returnMessage("please select color!", "", "error", getResponse());
                    return null;
                }
                ShoppingCart shoppingCart = shoppingCartService.getCartByProduct(Integer.valueOf(productId), user.getId(),Integer.valueOf(colorId));
                //判断是否有相同的商品存在购物车
                if (shoppingCart != null&&StringUtils.equals(colorId,String.valueOf(shoppingCart.getColor().getId()))) {
//                    shoppingCart.setCount(shoppingCart.getCount()+1);
//                    shoppingCartService.update(shoppingCart);
                    Message.returnMessage("product already exist in cart", "", "error", getResponse());
                    return null;
                } else {
                    Product product = productService.getProductById(Integer.valueOf(productId),false);
                    Color color = colorService.getById(Integer.valueOf(colorId));
                    if(product==null){
                        Message.returnMessage("product does not exist!", "", "error", getResponse());
                        return null;
                    }
                    if(product.getStockStatus() == 0){
                        Message.returnMessage("product stockout!", "", "error", getResponse());
                        return null;
                    }
                    if(color==null){
                        Message.returnMessage("please select color!", "", "error", getResponse());
                        return null;
                    }
                    shoppingCart = new ShoppingCart();
                    shoppingCart.setProduct(product);
                    shoppingCart.setColor(color);
                    shoppingCart.setUser(user);

                    /**
                     * calculate additional price
                     * capture attribute name and parameter id from front page
                     * save attribute name and parameter name to database
                     */
                    String attributes = getRequest().getParameter("attributes");
                    JSONArray attributesArray = JSONArray.fromObject(attributes);
                    Float additionalPrice = 0f;
                    JSONArray attributesData = new JSONArray();
                    for(int i = 0;i<attributesArray.size();i++){
                        JSONObject attribute = attributesArray.optJSONObject(i);
                        int parameterId = attribute.optInt("value");
                        Parameter parameter = parameterService.getById(parameterId);
                        additionalPrice += parameter.getAdditionalPrice();

                        JSONObject attributeData = new JSONObject();
                        attributeData.put("name",attribute.optString("name"));
                        attributeData.put("value",parameter.getName());
                        attributesData.add(attributeData);
                    }
                    shoppingCart.setAttributes(attributesData.toString());
                    shoppingCart.setAdditionalPrice(additionalPrice);

                    if (StringUtils.isNotBlank(count)) {
                        shoppingCart.setCount(Integer.valueOf(count));
                    } else {
                        shoppingCart.setCount(1);
                    }
                    shoppingCartService.add(shoppingCart);
                }
                LOG.info("购物车添加成功！");
                Message.returnMessage("add to cart success", "", "ok", getResponse());
            }
        } catch (Exception e) {
            LOG.error("购物车添加异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String delete() {
        try {
            String id = getRequest().getParameter("id");
            User user = (User)getRequest().getSession().getAttribute("user");
            ShoppingCart shoppingCart = shoppingCartService.getById(Integer.valueOf(id));
            if(user!=null&&user.getId()==shoppingCart.getUser().getId()){
                shoppingCartService.delete(Integer.valueOf(id));
            }else{
                Message.returnMessage("", "", "error", getResponse());
                return null;
            }
            LOG.info("购物车删除成功！");
            Message.returnMessage("", "", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("购物车删除异常！");
            e.printStackTrace();
            Message.returnMessage("", "", "error", getResponse());
        }
        return null;
    }
}
