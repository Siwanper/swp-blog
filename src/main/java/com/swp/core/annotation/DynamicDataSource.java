package com.swp.core.annotation;

import com.swp.core.constant.DataSourceName;

import java.lang.annotation.*;

/**
 * 动态数据源切换注解（默认切换扩展数据源）
 */

@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DynamicDataSource {

    /**
     * 需要切换的数据源名称
     *
     * @return
     */
    public DataSourceName value() default DataSourceName.EXTEND;

}
