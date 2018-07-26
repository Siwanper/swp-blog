package com.swp.commons.index.controller;

import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 描述:
 * 首页控制器
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-07-26 下午3:48
 */

@Controller
public class IndexController extends BaseController {

    @LogInject
    private static Logger logger;

    @MapperInject
    private DelegateMapper mapper;

    /**
     * 跳转到登录页面，如果用户已经登录跳转到首页
     *
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        if (this.isNull(this.getSessionUser())){
            return "login";
        }else {
            return "redirect:/";
        }
    }

    /**
     *
     * 跳转到错误页
     *
     * @param errorCode 404 500 等一系列错误状态吗
     * @return
     */
    @RequestMapping("/(errorCode)/error")
    public String error(@PathVariable String errorCode){
        System.out.println(errorCode);
        return "error";
    }


    /**
     *
     * UI模版
     *
     * @return
     */
    @RequestMapping("/template")
    public String template() {
        return "template";
    }

}
