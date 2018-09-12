package com.swp.core.constant;

public enum DataSourceName {
    /**
     * 默认数据源
     */
    DEFAULT("defaultDataSource"),
    /**
     * 扩展数据源
     */
    EXTEND("extendDataSource")
    ;

    /**
     * 数据源名称
     */
    private String name;

    /**
     * 构造方法
     *
     * @param name
     */
    DataSourceName(String name) {
        this.name = name;
    }

    /**
     * 获取名称的get方法
     *
     * @return
     */
    public String getName() {
        return name;
    }
}
