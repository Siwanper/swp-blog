package com.swp.core.model;

import com.github.pagehelper.Page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 自定义封装好的分页Page对象，与页面 bootstrapTable 插件交互使用
 *
 */

public class PageModel<T> implements Serializable {

    private static final long serivalVersionUID = 1l;

    /**
     * 总记录数
     */
    private long total;

    /**
     * 结果集
     */
    private List<T> rows;

    /**
     * 页码值
     */
    private int pageNum;

    /**
     * 每页记录数
     */
    private int pageSize;

    /**
     * 总页数
     */
    private int pages;

    /**
     * 当前页的数量 <= pageSize，该属性来自与ArrayList的size属性
     */
    private int size;

    /**
     * 无参数构造方法，构建PageModel 对象
     */
    public PageModel(){super();}

    /**
     * 构造方法，根据参数 list 创建 PageModel
     * @param list 分页查询出的 Page 集合
     */
    public PageModel(List<T> list) {
        if (list instanceof Page) {
            Page<T> page = (Page<T>) list;
            this.total = page.getTotal();
            this.pageNum = page.getPageNum();
            this.pageSize = page.getPageSize();
            this.pages = page.getPages();
            this.size = page.size();
            List<T> customList = new ArrayList<>();
            for (T t : list) {
                customList.add(t);
            }
            this.rows = customList;
        }
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {

        List<T> list = new ArrayList<>();
        for (T t : rows) {
            list.add(t);
        }

        this.rows = list;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
