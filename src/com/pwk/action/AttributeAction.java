package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Attribute;
import com.pwk.entity.Parameter;
import com.pwk.service.AttributeService;
import com.pwk.service.ParameterService;
import com.pwk.tools.Message;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2015/4/21.
 */
public class AttributeAction extends BaseAction {
    @Resource
    private AttributeService attributeService;
    @Resource
    private ParameterService parameterService;

    private static final Logger LOG = LogManager.getLogger(AttributeAction.class.getName());

    public String add(){
        try {
            String name = getRequest().getParameter("name");
            Attribute attribute = new Attribute();
            attribute.setName(name);
            for(int i = 1;i<=11;i++){
                String parameterName = getRequest().getParameter("p"+i);
                String additionalPrice= getRequest().getParameter("price" + i);
                if(StringUtils.isNotBlank(parameterName)){
                    Parameter parameter = new Parameter();
                    parameter.setAttributeId(attribute.getId());
                    parameter.setName(parameterName);
                    if(StringUtils.isNumeric(additionalPrice)){
                        parameter.setAdditionalPrice(Float.valueOf(additionalPrice));
                    }else{
                        parameter.setAdditionalPrice(0);
                    }
                    attribute.getParameters().add(parameter);
                }
            }
            attributeService.add(attribute);
            String text = "<span>"+attribute.getName()+":";
            text += "<input type='hidden' name='attributeId' value='"+attribute.getId()+"'/>";
            for(Parameter parameter:attribute.getParameters()){
                text += parameter.getName()+" ";
            }
            text += "<input type='button' value='Delete' class='btn btn-danger' onclick='deleteAttribute("+attribute.getId()+",this)'/>";
            text += "</span>";
            LOG.info("add attribute success！");
            Message.returnMessage("", text, "ok", getResponse());
        }catch (Exception e){
            e.printStackTrace();
            Message.returnMessage("", "", "error", getResponse());
        }
        return null;
    }

    public String update(){
        try {
            String name = getRequest().getParameter("name");
            String id = getRequest().getParameter("id");
            Attribute attribute = attributeService.getById(Integer.valueOf(id));
            attribute.setName(name);
            if(attribute.getParameters()!=null){
                for(Parameter parameter:attribute.getParameters()){
                    parameterService.delete(parameter.getId());
                }
            }
            for(int i=1;i<=20;i++){
                Parameter parameter = new Parameter();
                String parameterName = getRequest().getParameter("p"+i);
                String additionalPrice= getRequest().getParameter("price" + i);
                if(StringUtils.isNotBlank(parameterName)&&StringUtils.isNotBlank(additionalPrice)){
                    parameter.setName(parameterName);
                    parameter.setAdditionalPrice(Float.valueOf(additionalPrice));
                    attribute.getParameters().add(parameter);
                }
            }

            attributeService.update(attribute);
            String text = "<span>"+attribute.getName()+":";
            for(Parameter parameter:attribute.getParameters()){
                text += parameter.getName()+" ";
            }

            text += "<input type='hidden' name='attributeId' value='"+attribute.getId()+"'/>";
            text += "<input type='button' value='Delete' class='btn btn-danger' onclick='deleteAttribute("+attribute.getId()+",this)'/>";
            text += "</span>";
            String msg = "<input type='hidden' name='attributeId' value='"+attribute.getId()+"'/>";

            LOG.info("update attribute success！");
            Message.returnMessage(msg, text, "ok", getResponse());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String delete(){
        try {
            String id = getRequest().getParameter("id");
            List<Parameter> parameters = parameterService.getByAttributeId(Integer.valueOf(id));
            for(Parameter parameter:parameters){
                parameterService.delete(parameter.getId());
            }
            attributeService.delete(Integer.valueOf(id));
            getResponse().sendRedirect("/back/attribute/attributeList.jsp");
            LOG.info("删除属性成功！");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String getParameterByAid(){
        try {
            String attributeId = getParameter("attributeId");
            Attribute attribute = attributeService.getById(Integer.valueOf(attributeId));
            JSONArray array = new JSONArray();
            for(Parameter parameter:attribute.getParameters()){
                JSONObject object = new JSONObject();
                object.put("name",parameter.getName());
                object.put("additionalPrice",parameter.getAdditionalPrice());
                array.add(object);
            }
            getResponse().getWriter().print(array.toString());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
