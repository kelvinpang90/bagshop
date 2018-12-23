package com.pwk.service.impl;

import com.pwk.service.SaleAnalysisService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wenkai.peng on 8/25/2014.
 */
@Transactional
public class SaleAnalysisServiceImpl implements SaleAnalysisService {
    @Resource
    private JdbcTemplate jdbcTemplate;
    @Override
    public List getPaymentDataByMonth(int year, int month) {
        if(month != 0)
            return jdbcTemplate.queryForList("select " +
                    "    date_format(d.pay_date, '%Y') y, " +
                    "    date_format(d.pay_date, '%c') m, " +
                    "    date_format(d.pay_date, '%d') day, " +
                    "    count(d.id) count " +
                    " from " +
                    "    bagshop.payment_detail d, " +
                    " bagshop.order_item oi " +
                    " where " +
                    " d.order_id=oi.order_id " +
                    "    and date_format(d.pay_date, '%Y') = ? " +
                    " and date_format(d.pay_date, '%c') = ? " +
                    " group by date_format(d.pay_date, '%Y-%m-%d') " +
                    " order by d.pay_date; ", new Object[]{year,month});
        else
            return jdbcTemplate.queryForList("select " +
                    "    date_format(d.pay_date, '%Y') y, " +
                    "    date_format(d.pay_date, '%c') m, " +
                    "    date_format(d.pay_date, '%d') day, " +
                    "    count(d.id) count " +
                    " from " +
                    "    bagshop.payment_detail d, " +
                    " bagshop.order_item oi " +
                    " where " +
                    " d.order_id=oi.order_id " +
                    "    and date_format(d.pay_date, '%Y') = ? " +
                    " group by date_format(d.pay_date, '%Y-%m-%d') " +
                    " order by d.pay_date; ", new Object[]{year});
    }

    @Override
    public List getProductSaleByMonth(int year, int month) {
        if(month!=0){
            return jdbcTemplate.queryForList(" select " +
                    "    b.brand_name brand_name,count(oi.id) count" +
                    " from" +
                    "    bagshop.payment_detail pd," +
                    "    bagshop.order_item oi," +
                    "    bagshop.product p," +
                    "    bagshop.brand b" +
                    " where" +
                    "    pd.order_id = oi.order_id" +
                    "        and oi.product_id = p.id" +
                    "        and p.brand_id = b.id" +
                    "        and date_format(pd.pay_date, '%Y') = ?" +
                    "        and date_format(pd.pay_date, '%c') = ?" +
                    " group by b.id ",new Object[]{year,month});
        }else{
            return jdbcTemplate.queryForList(" select " +
                    "    b.brand_name brand_name,count(oi.id) count" +
                    " from" +
                    "    bagshop.payment_detail pd," +
                    "    bagshop.order_item oi," +
                    "    bagshop.product p," +
                    "    bagshop.brand b" +
                    " where" +
                    "    pd.order_id = oi.order_id" +
                    "        and oi.product_id = p.id" +
                    "        and p.brand_id = b.id" +
                    "        and date_format(pd.pay_date, '%Y') = ?" +
                    " group by b.id ",new Object[]{year});
        }
    }

    @Override
    public int getTotalProductSaleByMonth(int year, int month) {
        if (month!=0){
            return jdbcTemplate.queryForInt(" select " +
                    "    count(oi.id)" +
                    " from " +
                    "    bagshop.order_item oi, " +
                    "    bagshop.payment_detail pd " +
                    " where " +
                    "    oi.order_id = pd.order_id " +
                    "        and date_format(pd.pay_date, '%Y') = ? " +
                    "        and date_format(pd.pay_date, '%c') = ? ",new Object[]{year,month});
        }else{
            return jdbcTemplate.queryForInt(" select " +
                    "    count(oi.id)" +
                    " from " +
                    "    bagshop.order_item oi, " +
                    "    bagshop.payment_detail pd " +
                    " where " +
                    "    oi.order_id = pd.order_id " +
                    "        and date_format(pd.pay_date, '%Y') = ? ",new Object[]{year});
        }
    }
}
