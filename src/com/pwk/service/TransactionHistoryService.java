package com.pwk.service;

import com.pwk.entity.TransactionHistory;

import java.util.List;

/**
 * Created by wenkai.peng on 1/2/2015.
 */
public interface TransactionHistoryService {
    public List<TransactionHistory> getAll(Integer year);
}
