package com.swp.commons.user.controller;

import com.swp.commons.user.mapper.SysUserMapper;
import com.swp.commons.user.model.SysUser;
import com.swp.commons.user.model.SysUserExample;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * DESCRIPTION：   ${DESCRIPTION}
 *
 * @ProjectName: swp-blog
 * @Package: com.swp.commons.user.controller
 * @Author: Siwanper
 * @CreateDate: 2018/8/20 下午11:02
 * @Version: 1.0
 * <p>Copyright: Copyright (c) 2018</p>
 */

@Controller
@RequestMapping("/commons/user")
public class UserController extends BaseController {

    @LogInject
    private Logger logger;

    @MapperInject(SysUserMapper.class)
    private SysUserMapper userMapper;

    @RequestMapping("/getAllUser")
    @ResponseBody
    private List<SysUser> getAllUser(){
        List<SysUser> users = userMapper.selectByExample(new SysUserExample());
        return users;
    }


}
