package com.pwk.taglib;

import com.pwk.entity.Country;
import com.pwk.entity.State;
import com.pwk.tools.Engine;

/**
 * Created by wenkai.peng on 2014/5/27.
 */
public class LocationFunction {
    public static Country getCountryById(int id){
        return Engine.locationService.getCountryById(id);
    }
    public static State getStateById(int id){
        return Engine.locationService.getStateById(id);
    }
}
