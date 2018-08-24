package com.swp.commons.user.controller;

import com.swp.commons.user.mapper.SysUserMapper;
import com.swp.commons.user.model.SysUser;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.PageModel;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    private SysUserMapper mapper;

    @RequestMapping("/manage")
    public String manage() {
        return "common/user/manage";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public PageModel<SysUser> list(int offset, int limit, String search, String sort, String order) {
        this.offsetPage(offset, limit);
        List<SysUser> list = mapper.selectByExample(null);
        PageModel pageModel = this.resultPage(list);
        System.out.println(pageModel.getRows());
        return this.resultPage(list);
    }


}
