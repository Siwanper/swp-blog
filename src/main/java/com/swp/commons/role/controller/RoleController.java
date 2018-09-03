package com.swp.commons.role.controller;

import com.swp.commons.role.mapper.SysRoleMapper;
import com.swp.commons.role.model.RoleNode;
import com.swp.commons.role.model.SysRole;
import com.swp.commons.role.model.SysRoleExample;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.MsgModel;
import com.swp.core.persistence.DelegateMapper;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

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

    private static final String NAMESPACE = "com.swp.commons.role.mapper.SysRoleCustomMapper";

    @LogInject
    private Logger logger;

    @MapperInject(SysRoleMapper.class)
    private SysRoleMapper mapper;

    @MapperInject
    private DelegateMapper delegateMapper;

    @RequestMapping("/manage")
    public String manage(){
        return "common/role/manage";
    }

    /**
     * 获取角色 tree 结构<br>
     *
     * @param id 父Id
     * @return List<RoleNode> 角色节点列表集合
     */
    @RequestMapping(value = "/roleTree",method = RequestMethod.POST)
    @ResponseBody
    public List<RoleNode> getRoleTree(String id) {
        if (this.isNull(id)){
            id = "00000000000000000000000000000000";
        }

        List<RoleNode> nodeList = new ArrayList<>();
        List<RoleNode> rootList = delegateMapper.selectList(NAMESPACE+".getRoleNode",id);
        for (RoleNode roleNode : rootList) {
            roleNode.setChildren(getRoleNode(roleNode.getId()));
            nodeList.add(roleNode);
        }
        return nodeList;
    }

    /**
     * 添加角色
     *
     * @param roleId 对应的父级ID
     * @param model
     * @return
     */
    @RequestMapping("/{roleId}/add")
    public String add(@PathVariable String roleId, Model model) {
        SysRole prole = mapper.selectByPrimaryKey(roleId);
        SysRole role = new SysRole();
        role.setRolePid(prole.getRoleId());
        role.setRoleLevel(prole.getRoleLevel() + 1);
        role.setRoleType("group");
        role.setRoleValid(prole.getRoleValid());
        model.addAttribute("role",role);
        return "common/role/addOrEdit";
    }

    /**
     * 编辑角色信息
     *
     * @param roleId
     * @param model
     * @return
     */
    @RequestMapping("/{roleId}/edit")
    public String edit(@PathVariable String roleId, Model model) {
        SysRole role = mapper.selectByPrimaryKey(roleId);
        model.addAttribute("role",role);
        return "common/role/addOrEdit";
    }

    /**
     * 保存角色信息
     * @param role
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    @Transactional
    public MsgModel save(SysRole role){
        String status = "0"; // 0：刷新本级菜单，1：刷新父级菜单
        if (this.isNull(role.getRoleId())){ // 添加
            role.setRoleId(this.getUUID());
            mapper.insertSelective(role);
            status = "1";
        }else  {
            mapper.updateByPrimaryKeySelective(role);
            status = "1";
        }
        return this.resultMsg(status,"保存成功");
    }

    /**
     * 删除角色信息
     *
     * @param roleId 角色ID
     * @param rolePid 角色父ID
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    @Transactional
    public MsgModel delete(String roleId, String rolePid){
        String status = "0";
        SysRoleExample example = new SysRoleExample();
        example.createCriteria().andRolePidEqualTo(roleId);
        mapper.deleteByExample(example);  // 删除所有子集角色
        mapper.deleteByPrimaryKey(roleId); // 删除当前角色
        return this.resultMsg(status,"删除成功");
    }

    /**
     * 角色 tree 结构加载
     * @param pid 父类id
     * @return 角色节点列表集合
     */
    private List<RoleNode> getRoleNode(String pid){
        List<RoleNode> roleList = delegateMapper.selectList(NAMESPACE+".getRoleNode",pid);
        return roleList;
    }

}
