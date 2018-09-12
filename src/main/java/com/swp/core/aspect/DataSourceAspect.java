package com.swp.core.aspect;

import com.swp.core.annotation.DynamicDataSource;
import com.swp.core.constant.DataSourceName;
import com.swp.core.dataSource.DataSourceContextHolder;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.MethodBeforeAdvice;

import javax.xml.crypto.Data;
import java.lang.reflect.Method;

/**
 * 描述:
 * 切换数据源 aop 切面 （order = 1 优先级最高）
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-09-12 下午3:41
 */
public class DataSourceAspect implements MethodBeforeAdvice, AfterReturningAdvice{

    /**
     * 前置通知（用于在事务开启之前切换数据源）
     *
     * @param method
     * @param objects
     * @param o
     * @throws Throwable
     */
    @Override
    public void before(Method method, Object[] objects, Object o) throws Throwable {
        if (method.isAnnotationPresent(DynamicDataSource.class)) {
            DynamicDataSource dataSource = method.getAnnotation(DynamicDataSource.class);
            if (dataSource.value() != DataSourceName.DEFAULT) {
                DataSourceContextHolder.setDataSource(dataSource.value().getName());
            }
        }
    }

    /**
     * 后置通知（用于清理切换过的数据源，还原默认数据源）
     *
     * @param o
     * @param method
     * @param objects
     * @param o1
     * @throws Throwable
     */
    @Override
    public void afterReturning(Object o, Method method, Object[] objects, Object o1) throws Throwable {
        if (method.isAnnotationPresent(DynamicDataSource.class)) {
            DynamicDataSource dataSource = method.getAnnotation(DynamicDataSource.class);
            if (dataSource.value() != DataSourceName.DEFAULT) {
                DataSourceContextHolder.clearDataSource();
            }
        }
    }


}
