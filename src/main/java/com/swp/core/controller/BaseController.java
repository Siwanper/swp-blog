package com.swp.core.controller;

import com.swp.commons.login.model.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 描述:
 * 基本的控制器
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-07-24 下午4:48
 */
public class BaseController extends ControllerSupport {

    /**
     * 服务器会话信息 session 对象<br>
     */
    @Autowired
    private HttpSession session;

    /**
     * 用户请求 request 对象
     */
    @Autowired
    private HttpServletRequest request;

    /**
     * 服务器响应 response 对象
     */
    @Autowired
    private HttpServletResponse response;

    public HttpSession getSession() {
        return session;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

    public HttpServletResponse getResponse() {
        return response;
    }

    public void setResponse(HttpServletResponse response) {
        this.response = response;
    }

    /**
     * 获取用户登录成功后 session 中存储的用户信息
     *
     * @return
     */
    protected LoginUser getSessionUser() {
        return (LoginUser) this.session.getAttribute("user");

    }

    /**
     * 统一异常处理类
     *
     * @param request
     * @param response
     * @param exception
     * @return String
     */
    @ExceptionHandler
    protected String exceptionHandler(HttpServletRequest request, HttpServletResponse response, Exception exception){
        request.setAttribute("ex",exception);
        // TODO
        return "/500/error";
    }




}
