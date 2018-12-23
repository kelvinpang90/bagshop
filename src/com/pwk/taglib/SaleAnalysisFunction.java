package com.pwk.taglib;

import com.pwk.tools.Engine;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by wenkai.peng on 8/25/2014.
 */
public class SaleAnalysisFunction {
    public static List getPaymentDataByMonth(int year,int month){
        Date date = new Date();
        SimpleDateFormat currentYear = new SimpleDateFormat("yyyy");
        return Engine.saleAnalysisService.getPaymentDataByMonth(year==0?Integer.valueOf(currentYear.format(date)):year,month);
    }

    public static JSONArray getProductShareByMonth(int year,int month){
        Date date = new Date();
        SimpleDateFormat currentYear = new SimpleDateFormat("yyyy");
        List list = Engine.saleAnalysisService.getProductSaleByMonth(year==0?Integer.valueOf(currentYear.format(date)):year,month);
        JSONArray jsonArray = new JSONArray();
        for(Object obj:list){
            JSONObject jsonObject = JSONObject.fromObject(obj);
           jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    public static int getTotalProductSaleByMonth(int year,int month){
        Date date = new Date();
        SimpleDateFormat currentYear = new SimpleDateFormat("yyyy");
        return Engine.saleAnalysisService.getTotalProductSaleByMonth(year==0?Integer.valueOf(currentYear.format(date)):year,month);
    }
}
