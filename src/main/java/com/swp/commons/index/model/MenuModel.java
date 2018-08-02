package com.swp.commons.index.model;

import java.io.Serializable;
import java.util.List;

/**
 * DESCRIPTION：   ${DESCRIPTION}
 *
 * @ProjectName: swp-blog
 * @Package: com.swp.commons.index.model
 * @Author: Siwanper
 * @CreateDate: 2018/8/2 下午9:39
 * @Version: 1.0
 * <p>Copyright: Copyright (c) 2018</p>
 */
public class MenuModel implements Serializable   {

    private static final long serialVersionUID = 1L;

    /**
     * 菜单ID
     */
    private String id;
    /**
     * 菜单名称
     */
    private String name;
    /**
     * 菜单点击连接
     */
    private String url;
    /**
     * 菜单图标地址
     */
    private String icon;
    /**
     * 子菜单集合
     */
    private List<MenuModel> children;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public List<MenuModel> getChildren() {
        return children;
    }

    public void setChildren(List<MenuModel> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "MenuModel{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", icon='" + icon + '\'' +
                ", children=" + children +
                '}';
    }
}
