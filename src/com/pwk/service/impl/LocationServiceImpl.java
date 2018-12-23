package com.pwk.service.impl;

import com.pwk.entity.Country;
import com.pwk.entity.State;
import com.pwk.service.LocationService;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wenkai.peng on 2014/5/26.
 */
@Transactional
public class LocationServiceImpl implements LocationService {
    @Resource
    private SessionFactory sessionFactory;
    @Override
    public void addCountry(Country country) {
        sessionFactory.getCurrentSession().save(country);
    }

    @Override
    public void updateCountry(Country country) {
        sessionFactory.getCurrentSession().update(country);
    }

    @Override
    public void deleteCountry(int id) {
        sessionFactory.getCurrentSession().delete(this.getCountryById(id));
    }

    @Override
    public Country getCountryById(int id) {
        return (Country)sessionFactory.getCurrentSession().get(Country.class,id);
    }

    @Override
    public List<Country> getAllCountry() {
        return sessionFactory.getCurrentSession().createQuery("from Country where 1=1").list();
    }

    @Override
    public void addState(State state) {
        sessionFactory.getCurrentSession().save(state);
    }

    @Override
    public void updateState(State state) {
        sessionFactory.getCurrentSession().update(state);
    }

    @Override
    public void deleteState(int id) {
        sessionFactory.getCurrentSession().delete(this.getStateById(id));
    }

    @Override
    public State getStateById(int id) {
        return (State)sessionFactory.getCurrentSession().get(State.class,id);
    }

    @Override
    public List<State> getStateByCountryId(int countryId) {
        Query query = sessionFactory.getCurrentSession().createQuery("from State s where s.countryId=:countryId");
        query.setParameter("countryId",countryId, Hibernate.INTEGER);
        return query.list();
    }
}
