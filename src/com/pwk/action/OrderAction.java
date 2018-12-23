package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.*;
import com.pwk.service.OrderService;
import com.pwk.service.PaymentDetailService;
import com.pwk.service.ShoppingCartService;
import com.pwk.service.UserService;
import com.pwk.taglib.AdminFunction;
import com.pwk.taglib.UserFunction;
import com.pwk.tools.GmailSender;
import com.pwk.tools.HttpPostTool;
import com.pwk.tools.Message;
import com.pwk.tools.StringTools;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-16
 * Time: 下午5:10
 * To change this template use File | Settings | File Templates.
 */
public class OrderAction extends BaseAction {

    @Resource
    private OrderService orderService;
    @Resource
    private ShoppingCartService shoppingCartService;
    @Resource
    private UserService userService;
    @Resource
    private PaymentDetailService paymentDetailService;

    private static final Logger LOG = LogManager.getLogger(OrderAction.class.getName());

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String add(){
        try {
            String token = getRequest().getParameter("token");
            if(!StringUtils.equals(token,(String)getRequest().getSession().getAttribute("token"))){
                Message.returnMessage("please don't submit order repeatedly","/order.html","error",getResponse());
                return null;
            }
            User user = UserFunction.getByRequest(getRequest());
            if (user != null) {
                int id = user.getId();
                Order order = new Order();

                List<ShoppingCart> shoppingCarts = shoppingCartService.getByUserId(id);
                if (shoppingCarts == null || shoppingCarts.size() <= 0) {
                    getResponse().sendRedirect("/order.html");
                    return null;
                }
                Set<OrderItem> orderItems = new HashSet<OrderItem>();
                float price = 0;
                float shipPrice = 0;
                String country = getRequest().getParameter("country");
                for (ShoppingCart shoppingCart : shoppingCarts) {
                    if(shoppingCart.getProduct().getStockStatus() == 0){
                        Message.returnMessage("one or more of products in shopping cart are out of stock","","error",getResponse());
                        return null;
                    }
                    OrderItem orderItem = new OrderItem();
                    orderItem.setProduct(shoppingCart.getProduct());
                    orderItem.setColor(shoppingCart.getColor());
                    orderItem.setCount(shoppingCart.getCount());
                    orderItem.setAttributes(shoppingCart.getAttributes());
                    orderItem.setAdditionalPrice(shoppingCart.getAdditionalPrice());
                    orderItems.add(orderItem);
                    //total price
                    price += shoppingCart.getProduct().getPrice()+shoppingCart.getAdditionalPrice();
                    //shipping price
                    //within Malaysia,charge RM10 for one product
                    if(StringUtils.equals(country,"128")){
                        shipPrice += 10;
                    }
                }
                //deliver to Singapore,charge RM50 for one product,RM80 for two product,RM100 for three product
                if(StringUtils.equals(country,"191")){
                    if(shoppingCarts.size()==1)
                        shipPrice = 50;
                    if(shoppingCarts.size()==2)
                        shipPrice = 80;
                    if(shoppingCarts.size()==3)
                        shipPrice = 100;
                }
                order.setOrderItems(orderItems);
                order.setUser(user);
                order.setTotalPrice(price);
                order.setShipPrice(shipPrice);
                String fullName = getRequest().getParameter("fullName");
                String state = getRequest().getParameter("state");
                String address = getRequest().getParameter("address");
                String email = getRequest().getParameter("email");
                String phone = getRequest().getParameter("phone");
                boolean flag = this.setDeliveryMessage(order, user, fullName,country,state, address, email, phone, getResponse());
                if(!flag){
                    return null;
                }

                user.setName(fullName);
                user.setPhone(phone);
                user.setEmail(email);
                user.setCountry(country);
                user.setState(state);
                user.setAddress(address);
                userService.update(user);

                order.setStatus(0);
                order.setCreateDate(Timestamp.valueOf(format.format(new Date())));
                orderService.add(order);

                shoppingCartService.deleteByUserId(id);
                Message.returnMessage("Create order success","/orderDetail_"+order.getId()+".html", "error", getResponse());
                LOG.info("订单添加成功！");
            }
        } catch (Exception e) {
            LOG.error("订单添加异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String delete(){
        try {
            Admin admin = AdminFunction.getAdminByRequest(getRequest());
            User user = UserFunction.getByRequest(getRequest());
            int id = Integer.valueOf(getRequest().getParameter("id"));
            orderService.delete(id);
            LOG.info("订单删除成功="+id+"  user="+(admin!=null?admin.getLoginName():user.getLoginname()));
            getResponse().sendRedirect("/back/order/orderList.jsp");
        } catch (Exception e) {
            LOG.error("订单删除异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String deleteOrder(){
        try {
            int id = Integer.valueOf(getRequest().getParameter("id"));
            Order order = orderService.getById(id);
            User user = UserFunction.getByRequest(getRequest());
            if(order==null){
                getResponse().sendRedirect("/order.html?order=noOrder");
                return null;
            }else if(user==null){
                getResponse().sendRedirect("/index.html?t=login");
                return null;
            }else if(order.getUser().getId()!=user.getId()){
                getResponse().sendRedirect("/order.html?order=error");
                return null;
            }else{
                orderService.delete(id);
                LOG.info("订单删除成功="+id);
                getResponse().sendRedirect("/order.html?order=delete");
                return null;
            }
        }catch (Exception e){
            LOG.error("订单删除异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String cancelOrder(){
        try {
            int id = Integer.valueOf(getRequest().getParameter("id"));
            Order order = orderService.getById(id);
            User user = UserFunction.getByRequest(getRequest());
            if(order==null){
                getResponse().sendRedirect("/order.html?order=noOrder");
                return null;
            }else if(user==null){
                getResponse().sendRedirect("/index.html?t=login");
                return null;
            }else if(order.getUser().getId()!=user.getId()){
                getResponse().sendRedirect("/order.html?order=error");
                return null;
            }else if(order.getStatus()!=0){
                getResponse().sendRedirect("/order.html?order=error");
                return null;
            }else{
                order.setStatus(2);
                orderService.update(order);
                LOG.info("订单取消成功=" + id);
                getResponse().sendRedirect("/order.html?order=cancel");
                return null;
            }
        }catch (Exception e){
            LOG.error("订单取消异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String changePriceByAdmin() throws IOException{
        PrintWriter out = getResponse().getWriter();
        try {
            Admin admin = AdminFunction.getAdminByRequest(getRequest());
            if(admin!=null){
                String id = getRequest().getParameter("id");
                Order order = orderService.getById(Integer.valueOf(id));
                if(order!=null){
                    Float previousProductPrice = order.getTotalPrice();
                    Float previousShipPrice = order.getShipPrice();
                    String productPrice = getRequest().getParameter("totalPrice");
                    String shipPrice = getRequest().getParameter("shipPrice");
                    order.setTotalPrice(Float.valueOf(productPrice));
                     order.setShipPrice(Float.valueOf(shipPrice));
                    orderService.update(order);
                    out.print("ok");
                    LOG.info("admin修改价格成功  orderId="+id+"productPrice(" + previousProductPrice + "-->" + productPrice + ")   shipFee(" + previousShipPrice + "-->" + shipPrice + ")");
                }
            }
        }catch (Exception e){
            out.print("修改商品价格失败！");
            LOG.error("admin修改商品价格异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String changeDeliveryInfoByAdmin() throws IOException{
        getResponse().setContentType("text/xml;charset=UTF-8");
        getResponse().setHeader("Cache-Control", "no-cache");
        PrintWriter out = getResponse().getWriter();
        try {
            Admin admin = AdminFunction.getAdminByRequest(getRequest());
            if(admin!=null){
                String id = getRequest().getParameter("id");
                String deliveryCompany = getRequest().getParameter("deliveryCompany");
                String trackingNumber = getRequest().getParameter("trackingNumber");
                Order order = orderService.getById(Integer.valueOf(id));
                if(order!=null){
                    order.setDeliverCompany(deliveryCompany);
                    order.setTrackingNo(trackingNumber);
                    orderService.update(order);

                    String mail = order.getUser().getEmail();
                    if(StringUtils.isNotBlank(mail)){
                        MailSenderInfo mailInfo = new MailSenderInfo();
                        StringBuilder content = new StringBuilder();
                        mailInfo.setSubject("Order In Delivery Process");
                        mailInfo.setToAddress(mail);
                        content.append("Dear Customers, please be noted that your order has been in delivery process<br><br>");
                        content.append("Courier:"+deliveryCompany+"<br><br>");
                        content.append("tracking number:"+trackingNumber+"<br><br>");
                        content.append("Thank You. <br><br>");
                        content.append("Yours sincerely, <br><br>");
                        content.append("MyParisBags <br><br>");
                        mailInfo.setContent(content.toString());
                        GmailSender.send(mailInfo);
                    }

                    out.print("ok");
                    LOG.info("admin修改物流信息成功！");
                }
            }
        }catch (Exception e){
            out.print("admin修改物流信息失败！");
            LOG.error("admin修改物流信息失败！");
            e.printStackTrace();
        }
        return null;
    }

    private boolean setDeliveryMessage(Order order, User user, String fullName,String country,String state, String address, String email, String phone, HttpServletResponse response) {
        if (StringUtils.isNotBlank(fullName)) {
            order.setFullName(fullName);
        } else {
            String userName = user.getName();
            if (StringUtils.isBlank(userName)) {
                Message.returnMessage("Name can not be empty", "", "error", response);
                return false;
            } else {
                order.setFullName(userName);
            }
        }
        if (StringUtils.isNotBlank(country)) {
            order.setCountry(country);
        } else {
            String userCountry = user.getCountry();
            if (StringUtils.isBlank(userCountry)) {
                Message.returnMessage("Country can not be empty", "", "error", response);
                return false;
            } else {
                order.setCountry(userCountry);
            }
        }
        if (StringUtils.isNotBlank(state)) {
            order.setState(state);
        } else {
            String userRegion = user.getState();
            if (StringUtils.isBlank(userRegion)) {
                Message.returnMessage("Region can not be empty", "", "error", response);
                return false;
            } else {
                order.setState(userRegion);
            }
        }
        if (StringUtils.isNotBlank(address)) {
            order.setAddress(address);
        } else {
            String userAddress = user.getAddress();
            if (StringUtils.isBlank(userAddress)) {
                Message.returnMessage("Address can not be empty", "", "error", response);
                return false;
            } else {
                order.setAddress(userAddress);
            }
        }
        if (StringUtils.isNotBlank(email)) {
            order.setEmail(email);
        } else {
            String userEmail = user.getEmail();
            if (StringUtils.isBlank(userEmail)) {
                Message.returnMessage("Email can not be empty", "", "error", response);
                return false;
            } else {
                order.setEmail(userEmail);
            }
        }
        if (StringUtils.isNotBlank(phone)) {
            order.setPhone(phone);
        } else {
            String userPhone = user.getPhone();
            if (StringUtils.isBlank(userPhone)) {
                Message.returnMessage("Phone can not be empty", "", "error", response);
                return false;
            } else {
                order.setPhone(userPhone);
            }
        }
        return true;
    }

    public String paypalReturn(){

        try {
            Enumeration params = getRequest().getParameterNames();
            List<NameValuePair> keyValue = new ArrayList<NameValuePair>();
            boolean flag = this.validatePaymentData(getRequest());
            if(!flag)
                return null;
            keyValue.add(new BasicNameValuePair("cmd","_notify-validate"));
            while (params.hasMoreElements()){
                String key = String.valueOf(params.nextElement());
                String value = String.valueOf(getRequest().getParameter(key));
                keyValue.add(new BasicNameValuePair(key,value));
            }
            String returnStr = HttpPostTool.post("https://www.paypal.com/cgi-bin/webscr",null,null,keyValue);
            System.out.println("returnStr="+returnStr);
            String orderId = getRequest().getParameter("orderId");
            if(StringUtils.isNumeric(orderId)){
                Order order = orderService.getById(Integer.valueOf(orderId));
                if(order.getStatus()==1)
                    return null;
            }
            if(StringUtils.equals(returnStr,"VERIFIED")){
                this.changeToPayedStatus(getRequest().getParameter("orderId"));
                this.savePaymentDetail(getRequest(), "paypal",getRequest().getParameter("item_number"),returnStr );
                LOG.info("订单支付成功！");
            }else{
                LOG.info("订单支付信息验证错误 returnStr:"+returnStr);
            }
        }catch (Exception e){
            LOG.error("订单支付异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String payByAdmin(){
        try {
            Admin admin = AdminFunction.getAdminByRequest(getRequest());
            if(admin!=null&&StringUtils.equals(admin.getLoginName(),"admin")){
                String orderId = getRequest().getParameter("id");
                String status = getRequest().getParameter("status");
                Order order = orderService.getById(Integer.valueOf(orderId));
                if(order!=null&&order.getStatus()!=Integer.valueOf(status)){
                    order.setStatus(Integer.valueOf(status));
                    orderService.update(order);
                    LOG.info("payByAdmin成功！change to:"+status+"  orderId="+order.getId());
                    getResponse().sendRedirect("/back/order/orderList.jsp");
                }
            }
        }catch (Exception e){
            LOG.error("payByAdmin异常！");
            e.printStackTrace();
        }
        return null;
    }

    private boolean validatePaymentData(HttpServletRequest request){
        boolean flag = true;
        try {
            String receiver_email = getRequest().getParameter("receiver_email");
            String totalPrice = getRequest().getParameter("mc_gross");
            String fee = getRequest().getParameter("mc_fee");
            String currency_code = getRequest().getParameter("mc_currency");
            String orderId = request.getParameter("item_number");
            if(!StringUtils.equals(receiver_email,"official@myparisbags.com")){
                flag = false;
                LOG.error("支付信息错误receiver_email（"+receiver_email+"）不正确）");
            }
            Order order = orderService.getById(Integer.valueOf(orderId));
            if((order.getTotalPrice()+order.getShipPrice())!=Float.valueOf(totalPrice)){
                flag = false;
                LOG.error("支付信息错误（商品支付金额不正确）");
                LOG.error("应付："+(order.getTotalPrice()+order.getShipPrice())+"  实付："+totalPrice);
            }
            if(!StringUtils.equals(currency_code,"MYR")){
                flag = false;
                LOG.error("支付信息错误（currency_code不正确:"+currency_code+"）");
            }
            LOG.info("支付信息验证正确：receiver_email="+receiver_email+"   totalPrice="+totalPrice+"   currency_code"+currency_code+"   orderId="+orderId);
        }catch (Exception e){
            LOG.error("validatePaymentData异常");
            e.printStackTrace();
            return false;
        }
        return flag;
    }

    private String changeToPayedStatus(String id){
        try {
            Order order = orderService.getById(Integer.valueOf(id));
            order.setStatus(1);
            order.setPaymentDate(Timestamp.valueOf(format.format(new Date())));
            orderService.update(order);

            MailSenderInfo mailInfo = new MailSenderInfo();
            mailInfo.setSubject("Order Notification!!!");
            mailInfo.setToAddress("125430040@qq.com");
            StringBuilder content = new StringBuilder();
            content.append("OrderId:"+order.getId()+"<br>");
            content.append("Price:"+(order.getTotalPrice()+order.getShipPrice())+"<br>");
            content.append("Contact Name:"+order.getUser().getName()+"<br>");
            content.append("Contact No:"+order.getPhone()+"<br>");
            content.append("Address:"+order.getAddress()+"<br>");
            content.append("Email:"+order.getEmail()+"<br>");
            content.append("Product:<br>");
            for(OrderItem orderItem:order.getOrderItems()){
                content.append("Brand Name:"+orderItem.getProduct().getBrand().getBrandName()+"<br>");
                content.append("Product Name:"+orderItem.getProduct().getName()+"<br>");
                content.append("Color:"+orderItem.getColor().getName()+"<br>");
                JSONArray attrArray = StringTools.StringToJsonArray(orderItem.getAttributes());
                for(int i = 0;i<attrArray.size();i++){
                    JSONObject attrObject = attrArray.getJSONObject(i);
                    content.append(attrObject.get("name")+":"+attrObject.get("value"));
                }
                content.append("<br>");
            }
            content.append("Time of Payment:"+order.getPaymentDate());
            mailInfo.setContent(content.toString());

            GmailSender.send(mailInfo);

            //发送给用户
            String mail = order.getUser().getEmail();
            if(StringUtils.isNotBlank(mail)){
                mailInfo = new MailSenderInfo();
                mailInfo.setSubject("Order Accepted");
                mailInfo.setToAddress(mail);
                content = new StringBuilder();
                content.append("Dear "+(StringUtils.isNotBlank(order.getUser().getName())?order.getUser().getName():"Customer")+":<br><br>");
                content.append("Thank you for shopping in MyParisBags.<br><br>");
                content.append("We have received your payment and will arrange delivery shortly.<br><br>");
                content.append("If you have any questions,please don't hesitate to contact me via whatsapp, wechat or line: 016-2199981/0162369118<br><br>");
                content.append("Thank You. <br><br>");
                content.append("Yours sincerely, <br><br>");
                content.append("MyParisBags <br><br>");
                mailInfo.setContent(content.toString());
                GmailSender.send(mailInfo);
            }
            LOG.info("paypalReturn成功！");
            getResponse().sendRedirect("/back/order/orderList.jsp");
        }catch (Exception e){
            LOG.error("paypalReturn异常！");
            e.printStackTrace();
        }
        return null;
    }

    private void savePaymentDetail(HttpServletRequest request,String method,String  orderId,String status){
        try {
            Enumeration params = request.getParameterNames();
            StringBuilder sb = new StringBuilder();
            PaymentDetail paymentDetail = new PaymentDetail();
            paymentDetail.setMethod(method);
            paymentDetail.setOrderId(orderId);
            paymentDetail.setPayDate(Timestamp.valueOf(format.format(new Date())));
            paymentDetail.setStatus(status);
            while (params.hasMoreElements()){
                String key = String.valueOf(params.nextElement());
                String value = String.valueOf(getRequest().getParameter(key));
                if(StringUtils.equals(key,"mc_gross"))
                    paymentDetail.setTotalPrice(Float.valueOf(value));
                if(StringUtils.equals(key,"mc_fee"))
                    paymentDetail.setFee(Float.valueOf(value));
                sb.append(key+":"+value+"<br>");
            }
            paymentDetail.setContent(sb.toString());
            paymentDetailService.add(paymentDetail);
            LOG.info("添加paymentDetail成功！");
        }catch (Exception e){
            LOG.info("添加paymentDetail异常");
            e.printStackTrace();
        }

    }

    public String email (){
        MailSenderInfo mailInfo = new MailSenderInfo();
        mailInfo.setSubject("Order Notification!!!");
        mailInfo.setToAddress("390900977@qq.com");
        StringBuilder content = new StringBuilder();
        content.append("Dear Customer:<br><br>");
        content.append("Thank you for shopping in MyParisBags.<br><br>");
        content.append("We have received your payment and will arrange delivery shortly.<br><br>");
        content.append("If you have any questions,please don't hesitate to contact us via whatsapp, wechat or line: 016-2199981<br><br>");
        content.append("Thank You. <br><br>");
        content.append("Yours sincerely, <br><br>");
        content.append("MyParisBags");
        mailInfo.setContent(content.toString());

        GmailSender.send(mailInfo);
        return null;
    }


//    public String paypalCreditReturn(){
//        try {
//            HttpSession session = getRequest().getSession(true);
//            String finalPaymentAmount = (String)session.getAttribute("Payment_Amount");
//
//            if (isSet(getRequest().getParameter("PayerID")))
//                session.setAttribute("payer_id", getRequest().getParameter("PayerID"));
//            String token = "";
//            if (isSet(getRequest().getParameter("token"))){
//                session.setAttribute("TOKEN", getRequest().getParameter("token"));
//                token = getRequest().getParameter("token");
//            }else{
//                token = (String) session.getAttribute("TOKEN");
//            }
//
//            // Check to see if the Request object contains a variable named 'token'
//            PayPal pp = new PayPal();
//            Map<String, String> result = new HashMap<String, String>();
//            // If the Request object contains the variable 'token' then it means that the user is coming from PayPal site.
//            if (isSet(token))
//            {
//    		/*
//    		* Calls the GetExpressCheckoutDetails API call
//    		*/
//                Map<String, String> getec = pp.getShippingDetails(session, token );
//                String strAck = getec.get("ACK");
//                if(strAck !=null && (strAck.equalsIgnoreCase("SUCCESS") || strAck.equalsIgnoreCase("SUCCESSWITHWARNING") ))
//                {
//                    result.putAll(getec);
//    			/*
//    			* The information that is returned by the GetExpressCheckoutDetails call should be integrated by the partner into his Order Review
//    			* page
//    			*/
//                    String email 				= getec.get("EMAIL"); // ' Email address of payer.
//                    String payerId 			= getec.get("PAYERID"); // ' Unique PayPal customer account identification number.
//                    String payerStatus		= getec.get("PAYERSTATUS"); // ' Status of payer. Character length and limitations: 10 single-byte alphabetic characters.
//                    String firstName			= getec.get("FIRSTNAME"); // ' Payer's first name.
//                    String lastName			= getec.get("LASTNAME"); // ' Payer's last name.
//                    String cntryCode			= getec.get("COUNTRYCODE"); // ' Payer's country of residence in the form of ISO standard 3166 two-character country codes.
//                    String shipToName			= getec.get("PAYMENTREQUEST_0_SHIPTONAME"); // ' Person's name associated with this address.
//                    String shipToStreet		= getec.get("PAYMENTREQUEST_0_SHIPTOSTREET"); // ' First street address.
//                    String shipToCity			= getec.get("PAYMENTREQUEST_0_SHIPTOCITY"); // ' Name of city.
//                    String shipToState		= getec.get("PAYMENTREQUEST_0_SHIPTOSTATE"); // ' State or province
//                    String shipToCntryCode	= getec.get("PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE"); // ' Country code.
//                    String shipToZip			= getec.get("PAYMENTREQUEST_0_SHIPTOZIP"); // ' U.S. Zip code or other country-specific postal code.
//                    String addressStatus 		= getec.get("ADDRESSSTATUS"); // ' Status of street address on file with PayPal
//                    String totalAmt   		= getec.get("PAYMENTREQUEST_0_AMT"); // ' Total Amount to be paid by buyer
//                    String currencyCode       = getec.get("CURRENCYCODE"); // 'Currency being used
//
//                }
//                else
//                {
//                    //Display a user friendly Error on the page using any of the following error information returned by PayPal
//                    String ErrorCode = getec.get("L_ERRORCODE0").toString();
//                    String ErrorShortMsg = getec.get("L_SHORTMESSAGE0").toString();
//                    String ErrorLongMsg = getec.get("L_LONGMESSAGE0").toString();
//                    String ErrorSeverityCode = getec.get("L_SEVERITYCODE0").toString();
//
//                    String errorString = "SetExpressCheckout API call failed. "+
//
//                            "<br>Detailed Error Message: " + ErrorLongMsg +
//                            "<br>Short Error Message: " + ErrorShortMsg +
//                            "<br>Error Code: " + ErrorCode +
//                            "<br>Error Severity Code: " + ErrorSeverityCode;
//                    getRequest().setAttribute("error", errorString);
//                    RequestDispatcher dispatcher = getRequest().getRequestDispatcher("error.jsp");
//                    if (dispatcher != null){
//                        dispatcher.forward(getRequest(), getResponse());
//                    }
//                }
//            }
//
//
//            if(isSet(getRequest().getParameter("shipping_method"))){
//                String shipMethod = getRequest().getParameter("shipping_method");
//                BigDecimal new_shipping =new BigDecimal("0.00");
//                if(shipMethod.equals("ups_XPD"))
//                    new_shipping = new BigDecimal("25.43");
//                else if(shipMethod.equals("ups_WXS"))
//                    new_shipping = new BigDecimal("15.67");
//                else if(shipMethod.equals("flatrate_flatrate"))
//                    new_shipping = new BigDecimal("5.00");
//                BigDecimal shippingamt = new BigDecimal(session.getAttribute("PAYMENTREQUEST_0_SHIPPINGAMT").toString());
//                BigDecimal paymentAmount = new BigDecimal((String)session.getAttribute("PAYMENTREQUEST_0_AMT"));
//                if(shippingamt.compareTo(new BigDecimal(0)) > 0){
//                    finalPaymentAmount = paymentAmount.add(new_shipping).subtract(shippingamt).toString().replace(".00", "") ;
//                    session.setAttribute("shippingAmt",new_shipping.toString());
//                }else{
//                    finalPaymentAmount = paymentAmount.add(new_shipping).toString().replace(".00", "") ;
//                }
//            }
//
//    	/*
//    	* Calls the DoExpressCheckoutPayment API call
//    	*/
//            String page="return.jsp";
//            if (isSet(getRequest().getParameter("page")) && getRequest().getParameter("page").equals("return")){
//                Map doEC = pp.confirmPayment (session,finalPaymentAmount,getRequest().getServerName() );
//                String strAck = doEC.get("ACK").toString().toUpperCase();
//                if(strAck !=null && (strAck.equalsIgnoreCase("Success") || strAck.equalsIgnoreCase("SuccessWithWarning"))){
//                    result.putAll(doEC);
//                    getRequest().setAttribute("ack", strAck);
//                    session.invalidate();
//                }else{
//                    //Display a user friendly Error on the page using any of the following error information returned by PayPal
//                    String ErrorCode = doEC.get("L_ERRORCODE0").toString();
//                    String ErrorShortMsg = doEC.get("L_SHORTMESSAGE0").toString();
//                    String ErrorLongMsg = doEC.get("L_LONGMESSAGE0").toString();
//                    String ErrorSeverityCode = doEC.get("L_SEVERITYCODE0").toString();
//                    String errorString = "SetExpressCheckout API call failed. "+
//                            "<br>Detailed Error Message: " + ErrorLongMsg +
//                            "<br>Short Error Message: " + ErrorShortMsg +
//                            "<br>Error Code: " + ErrorCode +
//                            "<br>Error Severity Code: " + ErrorSeverityCode;
//                    getRequest().setAttribute("error", errorString);
//                    RequestDispatcher dispatcher = getRequest().getRequestDispatcher("error.jsp");
//                    if (dispatcher != null){
//                        dispatcher.forward(getRequest(), getResponse());
//                    }
//                    return null;
//                }
//                page="return.jsp";
//            }else{
//                page="review.jsp";
//            }
//            getRequest().setAttribute("result", result);
//
//            RequestDispatcher dispatcher = getRequest().getRequestDispatcher(page);
//            if (dispatcher != null){
//                dispatcher.forward(getRequest(), getResponse());
//            }
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return null;
//    }

    private boolean isSet(Object value){
        return (value !=null && value.toString().length()!=0);
    }

}
