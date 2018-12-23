package com.pwk.taglib;

import com.pwk.entity.HotSale;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-2
 * Time: 下午3:13
 * To change this template use File | Settings | File Templates.
 */
public class HotSaleFunction {
    public static HotSale getHotSaleById(int id){
        return Engine.hotSaleService.getHotSaleById(id);
    }
    public static List<HotSale> getHotSaleByList(int page,int size){
        return Engine.hotSaleService.getHotSaleByList(page,size);
    }
    public static int getTotal(){
        return Engine.hotSaleService.getTotal();
    }
    public static List<HotSale> getHotSaleBybId(int bId,int page,int size){
        return Engine.hotSaleService.getByBrandId(bId,page,size);
    }
}
