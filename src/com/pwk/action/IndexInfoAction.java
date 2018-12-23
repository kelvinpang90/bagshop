package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.IndexInfo;
import com.pwk.service.IndexInfoService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-2-19
 * Time: 下午9:50
 * To change this template use File | Settings | File Templates.
 */
public class IndexInfoAction extends BaseAction {
    @Resource
    private IndexInfoService indexInfoService;

    private static final Logger LOG = LogManager.getLogger(IndexInfoAction.class.getName());

    public String updateIndexInfo(){
        try {
            String topInfo = getRequest().getParameter("topInfo");
            String middleInfo = getRequest().getParameter("middleInfo");

            IndexInfo indexInfo = indexInfoService.getById(1);
            IndexInfo indexInfo2 = indexInfoService.getById(2);
            if(indexInfo == null){
                indexInfo = new IndexInfo();
                indexInfo.setId(1);
                indexInfo.setContent(topInfo);
                indexInfoService.add(indexInfo);
            }else{
                indexInfo.setContent(topInfo);
                indexInfoService.update(indexInfo);
            }
            if(indexInfo2 == null){
                indexInfo2 = new IndexInfo();
                indexInfo2.setId(2);
                indexInfo2.setContent(middleInfo);
                indexInfoService.add(indexInfo2);
            }else{
                indexInfo2.setContent(middleInfo);
                indexInfoService.update(indexInfo2);
            }
            LOG.info("更新首页信息成功！");
            Message.returnMessage("ok","","ok",getResponse());
        }catch (Exception e){
            LOG.error("更新首页信息异常！");
            Message.returnMessage("error","","error",getResponse());
        }
        return null;
    }
}
