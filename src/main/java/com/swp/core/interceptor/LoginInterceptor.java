package com.swp.core.interceptor;

import com.swp.commons.login.model.LoginUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * DESCRIPTION：   ${DESCRIPTION}
 *
 * @ProjectName: swp-blog
 * @Package: com.swp.core.interceptor
 * @Author: Siwanper
 * @CreateDate: 2018/7/24 下午11:19
 * @Version: 1.0
 * <p>Copyright: Copyright (c) 2018</p>
 */
@Deprecated
public class LoginInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    /**
     * 请求处理方法之前进行，
     *
     * @param httpServletRequest
     * @param httpServletResponse
     * @param object
     * @return 返回 true 执行下一个拦截器，返回 false 不执行下面的拦截器
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object object) throws Exception {

        LoginUser user = (LoginUser) httpServletRequest.getSession().getAttribute("user");

        // 用户存在，则跳过,执行下一个拦截器
        if (null != user) {
            return true;
        }

        // 如果时登陆请求，则跳过，执行下一个拦截器
        String uri = httpServletRequest.getRequestURI();
        logger.debug("Siwanper -> 执行 LoginInterceptor -> preHandle() 拦截到请求的Uri = "+uri);
        if (uri.contains("common/login/signin")){
            return true;
        }
        if (uri.contains("/login")){
            return true;
        }

        if (httpServletRequest.getHeader("x-requested-with") != null && httpServletRequest.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){
            // 如果是ajax请求响应头会有，x-requested-with
            logger.debug("Siwanper -> 执行 LoginInterceptor -> preHandle() 当前是ajax请求");
            PrintWriter out = httpServletResponse.getWriter();
            out.print("nologin");
            out.flush();
            return false;
        } else {
            logger.debug("Siwanper -> 执行 LoginInterceptor -> preHandle() 用户没有登录");
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/login");
            return false;
        }
    }

    /**
     * 在请求处理方法之后执行的
     *
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    /**
     * 在DispatchServlet 处理后执行（清理工作）
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }


}
