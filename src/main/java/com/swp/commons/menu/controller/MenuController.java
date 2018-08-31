package com.swp.commons.menu.controller;

import com.swp.commons.menu.mapper.SysMenuMapper;
import com.swp.commons.menu.model.MenuNode;
import com.swp.commons.menu.model.SysMenu;
import com.swp.commons.menu.model.SysMenuExample;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.MsgModel;
import com.swp.core.persistence.DelegateMapper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 描述:
 * 菜单管理
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-08-30 下午5:05
 */
@Controller
@RequestMapping("/commons/menu")
public class MenuController extends BaseController {

    private static final String NAMESPACE = "com.swp.commons.menu.mapper.SysMenuCustomMapper";

    @MapperInject
    private DelegateMapper delegateMapper;

    @MapperInject(SysMenuMapper.class)
    private SysMenuMapper mapper;

    @RequestMapping("/manage")
    public String manage(){
        return "common/menu/manage";
    }

    /**
     * 获取ztree 菜单节点
     * @param id 父节点ID
     * @return
     */
    @RequestMapping(value = "/menuTree", method = RequestMethod.POST)
    @ResponseBody
    public List<MenuNode> getMenuTree(String id){
        if (this.isNull(id)){
            id = "00000000000000000000000000000000";
        }
        List<MenuNode> rootNode = delegateMapper.selectList(NAMESPACE +".getMenuNode",id);
        List<MenuNode> listNode = new ArrayList<>();
        for (MenuNode node : rootNode) {
            node.setChildren(getMenuNode(node.getId()));
            listNode.add(node);
        }
        return listNode;
    }

    /**
     * 获取子菜单节点
     * @param pid
     * @return
     */
    public List<MenuNode> getMenuNode(String pid){
        List<MenuNode> rootNode = delegateMapper.selectList(NAMESPACE +".getMenuNode",pid);
        return rootNode;
    }

    /**
     * 添加菜单
     *
     * @param menuId 父菜单节点ID
     * @param model 新创建的菜单模型
     * @return String 添加菜单页面
     */
    @RequestMapping("/{menuId}/add")
    public String add(@PathVariable String menuId, Model model){
        SysMenu pmenu = mapper.selectByPrimaryKey(menuId);
        SysMenu menu = new SysMenu();
        menu.setMenuPid(pmenu.getMenuId());
        menu.setMenuLevel(pmenu.getMenuLevel() + 1);
        menu.setMenuValid(pmenu.getMenuValid());
        model.addAttribute("menu",menu);
        return "common/menu/addOrEdit";
    }

    /**
     * 编辑菜单
     *
     * @param menuId 菜单主键ID
     * @param model 编辑菜单对应的数据模型
     * @return String 菜单编辑页面
     */
    @RequestMapping("/{menuId}/edit")
    public String edit(@PathVariable String menuId, Model model){
        SysMenu menu = mapper.selectByPrimaryKey(menuId);
        model.addAttribute("menu",menu);
        return "common/menu/addOrEdit";
    }

    @RequestMapping(value = "/save" ,method = RequestMethod.POST)
    @ResponseBody
    @Transactional // 添加事务
    public MsgModel save(SysMenu menu){
        String status = "0"; // 0：刷新本级树，1：刷新父级树
        if (this.isNull(menu.getMenuId())) {
            // 添加操作
            menu.setMenuId(this.getUUID());
            menu.setMenuType("menu");
            mapper.insertSelective(menu);
            SysMenu pmenu = mapper.selectByPrimaryKey(menu.getMenuPid());
            if ("menu".equals(pmenu.getMenuType())) {
                // 如果父类是一个menu，则修改节点为folder
                Map<String, Object> map = new HashMap<>();
                map.put("menuType","folder");
                map.put("menuId",menu.getMenuId());
                delegateMapper.update(NAMESPACE+".updateMenuType",map);
                status = "1";
            }
        }else {
            // 修改操作
            mapper.updateByPrimaryKeySelective(menu);
            status = "1";
        }
        return this.resultMsg(status,"修改成功");
    }

    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public MsgModel delete(String menuId, String menuPid) {
        String statue = "0";

        SysMenuExample example = new SysMenuExample();
        example.createCriteria().andMenuPidEqualTo(menuId);
        mapper.deleteByExample(example);  // 删除当前菜单的所有子菜单
        mapper.deleteByPrimaryKey(menuId); // 删除当前菜单

        // 判断当前菜单的父菜单是否还有子菜单，如果没有menuType 修改为menu
        SysMenuExample pmenu = new SysMenuExample();
        pmenu.createCriteria().andMenuPidEqualTo(menuPid);
        List<SysMenu> list = mapper.selectByExample(pmenu);
        if (this.isNull(list)){
            // 修改父节点为 menu
            Map<String, Object> map = new HashMap<>();
            map.put("menuType", "menu");
            map.put("menuId", menuPid);
            delegateMapper.update(NAMESPACE + ".updateMenuType", map);
            statue = "1";
        }

        return this.resultMsg(statue,"删除成功");
    }



}
