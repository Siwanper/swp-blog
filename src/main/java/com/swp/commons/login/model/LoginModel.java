package com.swp.commons.login.model;

import java.io.Serializable;

public class LoginModel implements Serializable {

    private static final long serialVersionUID = 1L;
    /**
     * 状态值 ：0 失败，1 成功
     */
    private int status;

    /**
     * 信息
     */
    private String msg;

    /**
     * 返回url
     */
    private String url;

    /**
     * 是否记住密码
     */
    private boolean remember;

    public LoginModel(int status, String msg) {
        super();
        this.status = status;
        this.msg = msg;
    }

    public LoginModel(int status, String url, boolean remember) {
        super();
        this.status = status;
        this.url = url;
        this.remember = remember;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isRemember() {
        return remember;
    }

    public void setRemember(boolean remember) {
        this.remember = remember;
    }
}
