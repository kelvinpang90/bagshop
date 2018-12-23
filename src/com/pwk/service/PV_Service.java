package com.pwk.service;

import com.pwk.entity.PV;
import com.pwk.entity.PV_Detail;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by wenkai.peng on 1/21/2015.
 */
public interface PV_Service {
    public void add(PV_Detail pv_detail);

    public void addToday();
    public void addOne(String device);

    public List<Integer> getByDate(Timestamp date);
    public List<Integer> getByMonth(Timestamp date);
    public List<Integer> getByYear(Timestamp date);

}
