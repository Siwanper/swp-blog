package com.swp.commons.login.controller;

import com.swp.commons.login.model.LoginModel;
import com.swp.commons.login.model.LoginUser;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/commons/login")
public class LoginController extends BaseController {

    @LogInject
    private static Logger logger;

    @MapperInject
    private DelegateMapper delegateMapper;

    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    @ResponseBody
    public LoginModel signin(String username, String password, boolean remember){
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userCode",username);
        paramMap.put("userPassword",password);

        LoginUser loginUser = delegateMapper.selectOne("com.swp.commons.login.mapper.LoginCustomMapper.getLoginUser", paramMap);

        if(this.isNull(loginUser))
            return new LoginModel(0, "用户名、密码不正确！");

        if(Boolean.FALSE.equals(loginUser.getUserValid()))
            return new LoginModel(0, "该用户已失效！");

        List<Map<String , Object>> userRoles = delegateMapper.selectList("com.swp.commons.login.mapper.LoginCustomMapper.getUserRoles",loginUser.getUserId());
        if (!this.isNull(userRoles)){
            loginUser.setUserRoles(userRoles);
        }
        System.out.println("Siwanper -> Log 输出：" + loginUser);
        try{
            Subject subject = SecurityUtils.getSubject();
            if(!subject.isAuthenticated()) { // 当前用户是否已通过身份验证
                UsernamePasswordToken token = new UsernamePasswordToken(username, password, remember);
                // 使用 shiro 来验证
                subject.login(token);//验证角色和权限
                this.getSession().setAttribute("user", loginUser);
            }
            return new LoginModel(1, "/", remember);
        }catch(AuthenticationException e){
            e.printStackTrace();
            return new LoginModel(0, "登录失败，未知异常！");
        }


    }

    @RequestMapping("/signout")
    public String singout() {
        this.getSession().invalidate();
        return "redirect:/login";
    }

}
