package com.pwk.taglib;

import com.pwk.entity.TransactionHistory;
import com.pwk.tools.Engine;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wenkai.peng on 1/2/2015.
 */
public class TransactionHistoryFunction {
    public static List<TransactionHistory> getAll(Integer year){
        try {
            SimpleDateFormat currentYear = new SimpleDateFormat("yyyy");
            return Engine.transactionHistoryService.getAll((year==null||year==0)?(Integer.valueOf(currentYear.format(new Date()))-1):year);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
