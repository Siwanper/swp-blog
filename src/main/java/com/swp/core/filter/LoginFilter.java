package com.swp.core.filter;

import com.swp.commons.login.model.LoginUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * DESCRIPTION：   自定义登陆过滤器
 * 对于未登陆的 *.jsp 进行过滤
 *
 * @ProjectName: swp-blog
 * @Package: com.swp.core.filter
 * @Author: Siwanper
 * @CreateDate: 2018/7/24 下午10:50
 * @Version: 1.0
 * <p>Copyright: Copyright (c) 2018</p>
 */
@Deprecated
public class LoginFilter implements Filter {

    private static final Logger logger = LoggerFactory.getLogger(LoginFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String path = req.getContextPath();
        String uri = req.getRequestURI();

        String scheme = req.getScheme(); // 协议
        String serverName = req.getServerName(); // ip
        int port = req.getServerPort(); // 端口
        logger.debug("Siwanper -> 执行 LoginFilter - doFilter() 请求参数 : uri = "+uri);

        String loginPath = scheme + "://" + serverName + ":" + port + path + "/login";

        // 访问 login.jsp 不过滤
        if (uri.endsWith("login.jsp")){
            filterChain.doFilter(request,response);
            return;
        }

        // 判断用户是否登陆过
        LoginUser user = (LoginUser) req.getSession().getAttribute("user");
        if (null == user) {
            resp.sendRedirect(loginPath);
            return;
        }

        filterChain.doFilter(request,response);
    }

    @Override
    public void destroy() {

    }
}
