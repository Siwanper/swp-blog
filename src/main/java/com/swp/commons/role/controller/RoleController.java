package com.swp.commons.role.controller;

import com.swp.commons.role.mapper.SysRoleMapper;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 描述:
 * 角色管理控制器
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-08-27 下午12:03
 */
@Controller
@RequestMapping("/commons/role")
public class RoleController extends BaseController {

    @LogInject
    private Logger logger;

    @MapperInject(SysRoleMapper.class)
    private SysRoleMapper mapper;

    @RequestMapping("/manage")
    private String manage(){
        return "common/role/manage";
    }

}
