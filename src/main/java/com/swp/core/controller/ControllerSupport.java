package com.swp.core.controller;

import com.github.pagehelper.PageHelper;
import com.swp.core.model.MsgModel;
import com.swp.core.model.PageModel;
import com.swp.core.persistence.DelegateMapper;
import com.swp.core.support.BaseSupport;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * 描述:
 * 控制器支持类，继承自父类 BaseSupport
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-07-24 下午3:57
 */
public class ControllerSupport extends BaseSupport{

    /**
     * 根据 spring 的 mybatis 配置文件中的 sqlSessionTemplate 模版
     */
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 获取mapper
     *
     * @param type  生成 Mapper 接口对象 的 class类型
     * @param <T>
     * @return T 泛型，传入参数对象的类型Mapper
     */
    protected <T> T getMapper(Class<T> type) {
        return this.sqlSessionTemplate.getMapper(type);
    }

    /**
     * 获取代理对象
     *
     * @return
     */
    protected DelegateMapper getMapper() {
        return new DelegateMapper(this.sqlSessionTemplate);
    }

    /**
     * 动态切换数据源
     *
     * @param datasource
     */
    protected void setDataSource(String datasource){

    }

    /**
     * 清除数据源
     *
     */
    protected void clearDataSource(){

    }

    /**
     * 分页查询范围，参数均有 bootstrapTable 分页插件进行传入，无需人工控制，只需调用方法即可
     *
     * @param offset 起始数量
     * @param limit  限制条数
     */
    protected void offsetPage(int offset, int limit){
        PageHelper.offsetPage(offset,limit);
    }

    /**
     *
     * 分页结果集对象
     *
     * @param list  查询到的分页结果，为Page对象
     * @param <T>
     * @return      PageModel 自定义的分页模型，T 为查询的对象。
     */
    protected <T> PageModel<T> resultPage(List<T> list) {
        return new PageModel<>(list);
    }

    /**
     *
     * 消息返回对象
     *
     * @param status    状态值
     * @param msg       消息内容
     * @param res       返回对象
     * @return  MsgModel    自定义消息模型
     */
    protected MsgModel resultMsg(String status, String msg, Object res) {
        return new MsgModel(status, msg, res);
    }

    /**
     *
     * 消息返回对象
     *
     * @param status    状态值
     * @param msg       消息内容
     * @return  MsgModel    自定义消息模型
     */
    protected MsgModel resultMsg(String status, String msg) {
        return new MsgModel(status, msg);
    }

    /**
     *
     * 消息返回对象
     *
     * @param status    状态值
     * @return  MsgModel    自定义消息模型
     */
    protected MsgModel resultMsg(String status) {
        return new MsgModel(status);
    }

    // TODO
    /**
     *
     * 文件上传
     *
     */

    /**
     *
     * 文件下载
     *
     */


}
