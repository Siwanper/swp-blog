package com.swp.commons.user.controller;

import com.swp.commons.user.mapper.SysUserMapper;
import com.swp.commons.user.mapper.UserRoleRelMapper;
import com.swp.commons.user.model.*;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.MsgModel;
import com.swp.core.model.PageModel;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.Date;
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

    /**
     * 获取所有用户数据
     *
     * @param offset
     * @param limit
     * @param search
     * @param sort
     * @param order
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public PageModel<SysUser> list(int offset, int limit, String search, String sort, String order) {
        this.offsetPage(offset, limit);
        List<SysUser> list = mapper.selectByExample(null);
        return this.resultPage(list);
    }

    /**
     * 添加用户
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/add")
    public String add(Model model) {
        SysUser user = new SysUser();
        user.setUserType("general");
        model.addAttribute("userBean", user);
        return "common/user/addOrEdit";
    }

    /**
     * 编辑用户
     *
     * @param userId 用户Id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{userId}/edit")
    public String edit(@PathVariable String userId, Model model) {
        SysUserExample example = new SysUserExample();
        example.createCriteria().andUserIdEqualTo(userId);
        List<SysUser> sysUsers = mapper.selectByExample(example);
        if (sysUsers.size() > 0) {
            model.addAttribute("userBean", sysUsers.get(0));
            return "common/user/addOrEdit";
        }
        return "common/user/addOrEdit";
    }

    /**
     * 保存用户信息
     *
     * @param user
     * @param birthday
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public MsgModel save(SysUser user, String birthday) {
        if (this.isNull(user.getUserId())) { // 添加用户
            Date birthdayDate = this.dateStr2date(birthday, "yyyy-mm-dd");
            user.setUserBirthday(birthdayDate);
            user.setUserJoindate(new Date());
            user.setUserId(this.getUUID());
            mapper.insertSelective(user);
        } else { // 修改用户
            mapper.updateByPrimaryKeySelective(user);
        }
        return this.resultMsg("1", "添加成功");
    }

    /**
     * 删除用户
     *
     * @param ids 需要删除的所有用户ID
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public MsgModel delete(String ids) {
        List<String> idList = Arrays.asList(ids.split(","));
        for (String id : idList) {
            SysUserExample example = new SysUserExample();
            example.createCriteria().andUserIdEqualTo(id);
            mapper.deleteByExample(example);
        }
        return this.resultMsg("1", "删除成功");
    }

    @RequestMapping(value = "/saveUserRole", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public MsgModel saveUserRole(String ids, String userId) {
        List<String> roleIds = Arrays.asList(ids.split(","));
        UserRoleRelMapper mapper = this.getMapper(UserRoleRelMapper.class);

        // 清空之前的数据
        UserRoleRelExample example = new UserRoleRelExample();
        example.createCriteria().andRoleIdEqualTo(ids);
        example.createCriteria().andUserIdEqualTo(userId);
        mapper.deleteByExample(example);

        for (String roleId : roleIds) {
            UserRoleRel userRoleRel = new UserRoleRel();
            userRoleRel.setRelId(this.getUUID());
            userRoleRel.setRoleId(roleId);
            userRoleRel.setUserId(userId);
            mapper.insertSelective(userRoleRel);
        }

        return this.resultMsg("1","保存成功");

    }

}
