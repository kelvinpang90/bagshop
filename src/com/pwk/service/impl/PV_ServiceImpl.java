package com.pwk.service.impl;

import com.pwk.entity.PV;
import com.pwk.entity.PV_Detail;
import com.pwk.rowMapper.PV_RowMapper;
import com.pwk.service.PV_Service;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wenkai.peng on 1/21/2015.
 */
@Transactional
public class PV_ServiceImpl implements PV_Service {

    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd 00:00:00");

    @Resource
    private SessionFactory sessionFactory;

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public void add(PV_Detail pv_detail) {
        sessionFactory.getCurrentSession().save(pv_detail);
    }

    @Override
    public void addToday() {
        PV pv = new PV();
        pv.setCreateDate(Timestamp.valueOf(format.format(new Date())));
        pv.setPcCount(0);
        pv.setMobileCount(0);
        sessionFactory.getCurrentSession().save(pv);
    }

    @Override
    public void addOne(String device) {
        //date
        int count = jdbcTemplate.queryForInt(" select count(p.id) from pv p where DATE_FORMAT(p.create_date,'%Y-%m-%d') = date_format(now(),'%Y-%m-%d');");
        if(count == 0){
            addToday();
        }
        if(StringUtils.equals(device,"pc"))
            jdbcTemplate.execute(" update pv p set p.pc_count = p.pc_count+1 where DATE_FORMAT(p.create_date,'%Y-%m-%d') = date_format(now(),'%Y-%m-%d'); ");
        if(StringUtils.equals(device,"mobile"))
            jdbcTemplate.execute(" update pv p set p.mobile_count = p.mobile_count+1 where DATE_FORMAT(p.create_date,'%Y-%m-%d') = date_format(now(),'%Y-%m-%d'); ");
    }

    @Override
    public List<Integer> getByDate(Timestamp date) {
        return jdbcTemplate.query(" select p.pc_count,p.mobile_count from pv p where DATE_FORMAT(p.create_date,'%Y-%m-%d') = date_format(now(),'%Y-%m-%d');", new PV_RowMapper());
    }

    @Override
    public List<Integer> getByMonth(Timestamp date) {
        return jdbcTemplate.query(" select sum(p.pc_count),sum(p.mobile_count) from pv p where DATE_FORMAT(p.create_date,'%Y-%m') = date_format(now(),'%Y-%m');", new PV_RowMapper());
    }

    @Override
    public List<Integer> getByYear(Timestamp date) {
        return jdbcTemplate.query(" select sum(p.pc_count),sum(p.mobile_count) from pv p where DATE_FORMAT(p.create_date,'%Y') = date_format(now(),'%Y');", new PV_RowMapper());
    }
}
