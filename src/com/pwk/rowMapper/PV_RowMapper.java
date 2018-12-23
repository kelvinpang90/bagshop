package com.pwk.rowMapper;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wenkai.peng on 1/21/2015.
 */
public class PV_RowMapper implements RowMapper {
    @Override
    public Object mapRow(ResultSet resultSet, int i) throws SQLException {
        List<Integer> list = new ArrayList<Integer>();
        list.add(resultSet.getInt(0));
        list.add(resultSet.getInt(1));
        return list;
    }
}
