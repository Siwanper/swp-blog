package com.swp.commons.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/common/login")
public class LoginController {


    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    public String signin(String username, String password, boolean remember){
        System.out.println(username + password);
        return "index";
    }

}
