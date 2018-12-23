package com.pwk.service;

import com.pwk.entity.HotSale;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午2:40
 * To change this template use File | Settings | File Templates.
 */
public interface HotSaleService {
    public void addHotSale(HotSale hotSale);
    public void updateHotSale(HotSale hotSale);
    public void deleteHotSale(int id);
    public void deleteHotSaleByProductId(int id);
    public HotSale getHotSaleById(int id);
    public List<HotSale> getHotSaleByList(int page, int size);
    public List<HotSale> getByBrandId(int bId,int page,int size);
    public int getTotal();
}
