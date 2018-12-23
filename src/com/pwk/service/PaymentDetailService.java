package com.pwk.service;

import com.pwk.entity.PaymentDetail;

import java.util.List;

/**
 * Created by wenkai.peng on 2014/5/24.
 */
public interface PaymentDetailService {
    public void add(PaymentDetail paymentDetail);
    public PaymentDetail getById(int id);
    public List<PaymentDetail> getByList(int page,int size);
    public List<PaymentDetail> getListByMonth(int page,int size,int year,int month);
    public int getTotal();
    public int getTotalByMonth(int year,int month);

}
