package com.swp.commons.role.controller;

import com.swp.commons.role.mapper.SysRoleMapper;
import com.swp.commons.role.model.RoleNode;
import com.swp.commons.role.model.SysRole;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
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

    @RequestMapping("/{roleId}/edit")
    public String edit(@PathVariable String roleId, Model model) {
        SysRole role = mapper.selectByPrimaryKey(roleId);
        model.addAttribute("role",role);
        return "common/role/addOrEdit";
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
