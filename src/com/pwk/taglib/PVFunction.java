package com.pwk.taglib;

import com.pwk.tools.Engine;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wenkai.peng on 1/21/2015.
 */
public class PVFunction {
    private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
    public static Map<String,List<Integer>> getPVSum(){
        Map<String,List<Integer>> map = new HashMap<String, List<Integer>>();
        try {
            Timestamp today = Timestamp.valueOf(format.format(new Date()));
            List<Integer> date = Engine.pv_service.getByDate(today);
            List<Integer> month = Engine.pv_service.getByMonth(today);
            List<Integer> year = Engine.pv_service.getByYear(today);
            map.put("date",date);
            map.put("month",month);
            map.put("year",year);
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }
}
