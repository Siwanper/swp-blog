package com.swp.commons.index.controller;

import com.swp.commons.index.model.MenuModel;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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


    /**
     * 获取角色对应的菜单集合
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/{roleId}/menu")
    @ResponseBody
    public List<MenuModel> menu(@PathVariable String roleId) {

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("menuId", "00000000000000000000000000000001");
        paramMap.put("roleId", roleId);
        paramMap.put("userId", this.getSessionUser().getUserId());

        List<MenuModel> list = new ArrayList<>();
        List<MenuModel> rootList = mapper.selectList("com.swp.commons.index.mapper.IndexCustomMapper.getMenu", paramMap);
        for (MenuModel menuModel : rootList) {
            menuModel.setChildren(getMenu(menuModel.getId(), roleId));
            list.add(menuModel);
        }
        System.out.println(list);
        return list;
    }

    public List<MenuModel> getMenu(String pid, String roleId){
        Map<String, Object> map = new HashMap<>();
        map.put("menuId",pid);
        map.put("roleId",roleId);
        map.put("userId",this.getSessionUser().getUserId());

        List<MenuModel> menuList = new ArrayList<>();
        List<MenuModel> list = mapper.selectList("com.swp.commons.index.mapper.IndexCustomMapper.getMenu", map);
        for (MenuModel model :
                list) {
            if (!this.isNull(model.getId())){
                model.setChildren(getMenu(model.getId(),roleId));
            }
            menuList.add(model);
        }
        return menuList;

    }

}
