package com.pwk.service;

import com.pwk.entity.Parameter;

import java.util.List;

/**
 * Created by Administrator on 2015/4/21.
 */
public interface ParameterService {
    public void add(Parameter parameter);
    public void update(Parameter parameter);
    public void delete(int id);
    public Parameter getById(int id);
    public List<Parameter> getByAttributeId(int attributeId);
    public int getTotal();
}
