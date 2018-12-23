package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Attribute;
import com.pwk.entity.Category;
import com.pwk.entity.Parameter;
import com.pwk.service.AttributeService;
import com.pwk.service.CategoryService;
import com.pwk.service.ProductService;
import com.pwk.tools.Message;
import org.apache.commons.lang3.StringUtils;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
public class CategoryAction extends BaseAction {
    @Resource
    private CategoryService categoryService;

    public String add(){
        try {
            String name = getRequest().getParameter("name");
            String categoryId = getRequest().getParameter("categoryId");
            Category category = new Category();
            category.setName(name);
            category.setStatus(true);
            if(StringUtils.isNotBlank(categoryId))
                category.setParentId(Integer.valueOf(categoryId));
            categoryService.add(category);
            LOG.info("add category success！");
            Message.returnMessage("add category success！", "/back/category/categoryList.jsp", "ok", getResponse());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String update(){
        try {
            String id = getRequest().getParameter("id");
            String name = getRequest().getParameter("name");
            String categoryId = getRequest().getParameter("categoryId");
            Category category = categoryService.getById(Integer.valueOf(id));
            category.setName(name);
            if(StringUtils.isNotBlank(categoryId))
                category.setParentId(Integer.valueOf(categoryId));
            categoryService.update(category);
            LOG.info("update category success！");
            Message.returnMessage("update category success！", "/back/category/categoryList.jsp", "ok", getResponse());
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String delete(){
        try {
            String id = getRequest().getParameter("id");
            categoryService.delete(Integer.valueOf(id));
            LOG.info("目录删除成功！");
            getResponse().sendRedirect("/back/category/categoryList.jsp");
        }catch (Exception e){
            e.printStackTrace();
            try {
                getResponse().sendRedirect("/back/category/categoryList.jsp");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
        return null;
    }

    //categoryAdd.jsp
//    public String getFeasibleAttributes(){
//        try {
//            String categoryId = getRequest().getParameter("categoryId");
//            List<Attribute> allAttributes = attributeService.getAll();
//            StringBuilder sb = new StringBuilder();
//            sb.append("<span class='input-group-addon'>Attributes</span>");
//            if(StringUtils.isNumeric(categoryId)){
//                List<Attribute> attributes = categoryService.getAttributeByCategoryId(Integer.valueOf(categoryId));
//                for(int i = 0;i<allAttributes.size();i++){
//                    for(int j = 0;j<attributes.size();j++){
//                        if(allAttributes.get(i).getId()== attributes.get(j).getId()){
//                            allAttributes.remove(allAttributes.get(i));
//                        }
//                    }
//                }
//            }
//            for(Attribute attribute:allAttributes){
//                sb.append("<input type='checkbox' value='"+attribute.getId()+"' name='attributeId'>"+attribute.getName()+"&nbsp");
//            }
//            getResponse().setCharacterEncoding("utf-8");
//            getResponse().getWriter().print(sb);
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return null;
//    }

    //productAdd.jsp
//    public String getAttributeNParametersByCid(){
//        try {
//            String categoryId = getRequest().getParameter("categoryId");
//            List<Attribute> attributes = categoryService.getAttributeByCategoryId(Integer.valueOf(categoryId));
//            StringBuilder sb = new StringBuilder();
//            sb.append("<span class='input-group-addon'>Attributes&Parameters</span>");
//            for(Attribute attribute:attributes){
//                sb.append("<span>"+attribute.getName()+"</span>");
//                for(Parameter parameter:attribute.getParameters()){
//                    sb.append("<input type='checkbox' value='"+parameter.getId()+"' name='"+attribute.getName()+"'>"+parameter.getName());
//                }
//                sb.append("<br>");
//                sb.append("<br>");
//            }
//            getResponse().setCharacterEncoding("utf-8");
//            getResponse().getWriter().print(sb);
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return null;
//    }

}
