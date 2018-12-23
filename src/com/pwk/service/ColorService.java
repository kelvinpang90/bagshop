package com.pwk.service;

import com.pwk.entity.Color;

import java.util.List;

/**
 * Created by Administrator on 14-1-13.
 */
public interface ColorService {
    public void add(Color color);
    public void delete(int id);
    public void update(Color color);
    public Color getById(int id);
    public List<Color> getAllColor();
}
