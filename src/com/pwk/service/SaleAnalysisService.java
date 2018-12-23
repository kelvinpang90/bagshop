package com.pwk.service;

import java.util.List;

/**
 * Created by wenkai.peng on 8/25/2014.
 */
public interface SaleAnalysisService {
    public List getPaymentDataByMonth(int year,int month);
    public List getProductSaleByMonth(int year,int month);
    public int getTotalProductSaleByMonth(int year,int month);
}
