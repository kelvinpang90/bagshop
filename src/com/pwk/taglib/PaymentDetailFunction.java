package com.pwk.taglib;

import com.pwk.entity.PaymentDetail;
import com.pwk.tools.Engine;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wenkai.peng on 8/24/2014.
 */
public class PaymentDetailFunction {
    public static PaymentDetail getById(int id){
        return Engine.paymentDetailService.getById(id);
    }

    public static List<PaymentDetail> getByList(int page,int size){
        return Engine.paymentDetailService.getByList(page,size);
    }

    public static List<PaymentDetail> getListByMonth(int page,int size,int year,int month){
        Date date = new Date();
        SimpleDateFormat currentYear = new SimpleDateFormat("yyyy");
        return Engine.paymentDetailService.getListByMonth(page,size,year==0?Integer.valueOf(currentYear.format(date)):year,month);
    }

    public static int getTotal(){
        return Engine.paymentDetailService.getTotal();
    }

    public static int getTotalByMonth(int year,int month){
        Date date = new Date();
        SimpleDateFormat currentYear = new SimpleDateFormat("yyyy");
        return Engine.paymentDetailService.getTotalByMonth(year==0?Integer.valueOf(currentYear.format(date)):year,month);
    }


}
