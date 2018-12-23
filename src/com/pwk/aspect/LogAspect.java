package com.pwk.aspect;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.ThrowsAdvice;

import java.lang.reflect.Method;

/**
 * Created with IntelliJ IDEA.
 * User: admin
 * Date: 14-4-9
 * Time: ����11:55
 * To change this template use File | Settings | File Templates.
 */
@Aspect
public class LogAspect implements AfterReturningAdvice,ThrowsAdvice {

    @Override
    public void afterReturning(Object o, Method method, Object[] objects, Object o2) throws Throwable {
    }
}
