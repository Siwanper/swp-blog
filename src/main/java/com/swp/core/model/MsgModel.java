package com.swp.core.model;

/**
 * 描述:
 * 消息模型
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-07-24 下午4:27
 */
public class MsgModel {

    /**
     * 状态值
     */
    private String status;

    /**
     * 消息
     */
    private String msg;

    /**
     * 返回对象
     */
    private Object res;

    /**
     * 代参数构造方法，构建 MsgModel 对象
     * @param status 状态值
     * @param msg   消息
     * @param res   返回对象
     */
    public MsgModel(String status, String msg, Object res) {
        this.status = status;
        this.msg = msg;
        this.res = res;
    }

    public MsgModel(String status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    public MsgModel(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getRes() {
        return res;
    }

    public void setRes(Object res) {
        this.res = res;
    }
}
