package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.PV;
import com.pwk.entity.PV_Detail;
import com.pwk.service.PV_Service;
import com.pwk.tools.StringTools;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by wenkai.peng on 1/21/2015.
 */
public class PVAction extends BaseAction {

    private static final Logger LOG = LogManager.getLogger(PVAction.class.getName());

    private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Resource
    private PV_Service pv_service;

    public String add(){
        try {
            String device = getRequest().getParameter("device");
            String page = getRequest().getParameter("page");
            PV_Detail pv_detail = new PV_Detail();
            pv_detail.setCreateDate(Timestamp.valueOf(format.format(new Date())));
            pv_detail.setIp(StringTools.getRealIp(getRequest()));
            pv_detail.setPage(page);
            pv_detail.setDevice(device);
            pv_service.add(pv_detail);
            if(System.currentTimeMillis()-getSession().getCreationTime()<=5000){
                pv_service.addOne(device);
            }
        }catch (Exception e){
            LOG.error("PV添加失败");
            e.printStackTrace();
        }
        return null;
    }

    public String getOnline(){
        try {
            Integer online = (Integer)getSession().getServletContext().getAttribute("online");
            PrintWriter out = getResponse().getWriter();
            out.print(online);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
