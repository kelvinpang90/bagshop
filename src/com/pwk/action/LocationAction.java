package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Country;
import com.pwk.entity.State;
import com.pwk.entity.User;
import com.pwk.service.LocationService;
import com.pwk.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.annotation.Resource;
import java.io.File;
import java.util.Iterator;
import java.util.List;

/**
 * Created by wenkai.peng on 2014/5/25.
 */
public class LocationAction extends BaseAction{

    private static final Logger LOG = LogManager.getLogger(LocationAction.class.getName());
    @Resource
    private LocationService locationService;
    @Resource
    private UserService userService;

    public String loadCountry(){
        try {
            String countryId = getRequest().getParameter("countryId");
            List<Country> countries = locationService.getAllCountry();
            StringBuilder sb = new StringBuilder("");
            for(Country country:countries){
                //just can choose Singapore and Malaysia
                if(country.getId()==191||country.getId()==128)
                    sb.append("<option value="+country.getId()+" "+(country.getId().equals(Integer.valueOf(countryId))?"selected":"")+">"+country.getName()+"</option>");
            }
            getResponse().getWriter().print(sb.toString());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取某国家的州，暂时有两个地方用到
     * 1、注册的时候，根据国家获取所有州
     * 2、查看或者修改资料的时候，根据用户的stateId获取用户所处国家的所有州和用户当前州
     * @return
     */
    public String loadState(){
        try {
            String countryId = getRequest().getParameter("countryId");
            String userId = getRequest().getParameter("userId");
            String userState = "";
            if(StringUtils.isNotBlank(userId)){
                User user = userService.getUserById(Integer.valueOf(userId));
                userState = user.getState();
            }
            List<State> states = locationService.getStateByCountryId(Integer.valueOf(countryId));
            StringBuilder sb = new StringBuilder("");
            for(State state:states){
                sb.append("<option value="+state.getId()+" "+((StringUtils.isNotBlank(userState)&&state.getId().equals(Integer.valueOf(userState)))?"selected":"")+">"+state.getName()+"</option>");
            }
            getResponse().getWriter().print(sb.toString());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

//    private String path = LocationAction.class.getResource("/locList.xml").getFile();

//    public String loadCountry(){
//        try {
//            File locationFile = new File(path);
//            SAXReader reader = new SAXReader();
//            Document doc = reader.read(locationFile);
//            Element root = doc.getRootElement();
//            Element foo = null;
//            StringBuilder sb = new StringBuilder("");
//            for(Iterator i = root.elementIterator("CountryRegion");i.hasNext();){
//                foo = (Element)i.next();
//                sb.append("<option value="+foo.attributeValue("Code")+">"+foo.attributeValue("Name")+"</option>");
//            }
//            getResponse().getWriter().print(sb.toString());
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    public String loadState(){
//        try {
//            String countryCode = getRequest().getParameter("countryCode");
//            File locationFile = new File(path);
//            SAXReader reader = new SAXReader();
//            Document doc = reader.read(locationFile);
//            Element root = doc.getRootElement();
//            Element foo = null;
//            StringBuilder sb = new StringBuilder("");
//            for(Iterator i = root.elementIterator("CountryRegion");i.hasNext();){
//                foo = (Element)i.next();
//                if(StringUtils.equals(foo.attributeValue("Code"),countryCode)){
//                    for(Iterator it = foo.elementIterator("State");it.hasNext();){
//                        Element foo1 = (Element)it.next();
//                        if(StringUtils.isNotBlank(foo1.attributeValue("Code"))&&StringUtils.isNotBlank(foo1.attributeValue("Name"))){
//                            sb.append("<option value="+foo1.attributeValue("Code")+">"+foo1.attributeValue("Name")+"</option>");
//                        }
//                    }
//                }
//            }
//            getResponse().getWriter().print(sb.toString());
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return null;
//    }
}
