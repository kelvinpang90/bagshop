package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.service.PaymentDetailService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wenkai.peng on 8/24/2014.
 */
public class PaymentDetailAction extends BaseAction {
    private static final Logger LOG = LogManager.getLogger(PaymentDetailAction.class.getName());
    @Resource
    private PaymentDetailService paymentDetailService;

}
