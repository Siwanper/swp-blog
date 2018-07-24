package com.swp.commons.login.controller;

import com.swp.commons.login.model.LoginModel;
import com.swp.commons.login.model.LoginUser;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/common/login")
public class LoginController extends BaseController {

    @MapperInject
    private DelegateMapper delegateMapper;

    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    @ResponseBody
    public LoginModel signin(String username, String password, boolean remember){
        System.out.println(username+password);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userCode",username);
        paramMap.put("userPassword",password);

        LoginUser loginUser = delegateMapper.selectOne("com.swp.commons.login.mapper.LoginCustomMapper.getLoginUser", paramMap);
        if (loginUser == null) {
            return new LoginModel(0,"用户名或密码错误","",remember);
        }
        if (Boolean.FALSE.equals(loginUser.getUserValid())){
            return new LoginModel(0,"用户已经失效","",remember);
        }
        this.getSession().setAttribute("user",loginUser);
        return new LoginModel(1,"登录成功", "/",remember);
    }

    @RequestMapping("index")
    public String home(){
        return "login";
    }

    @RequestMapping("/signout")
    public String singout() {
        this.getSession().invalidate();
        return "redirect:/login";
    }

}
