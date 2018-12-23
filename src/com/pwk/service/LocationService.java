package com.pwk.service;

import com.pwk.entity.Country;
import com.pwk.entity.State;

import java.util.List;

/**
 * Created by wenkai.peng on 2014/5/26.
 */
public interface LocationService {
    public void addCountry(Country country);
    public void updateCountry(Country country);
    public void deleteCountry(int id);
    public Country getCountryById(int id);
    public List<Country> getAllCountry();

    public void addState(State state);
    public void updateState(State state);
    public void deleteState(int id);
    public State getStateById(int id);
    public List<State> getStateByCountryId(int countryId);
}
