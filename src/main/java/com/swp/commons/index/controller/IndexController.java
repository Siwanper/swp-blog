package com.swp.commons.index.controller;

import com.swp.commons.ehcache.EhCacheTestService;
import com.swp.commons.index.model.MenuModel;
import com.swp.core.annotation.LogInject;
import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.persistence.DelegateMapper;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.InputStream;
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

    @Autowired
    private EhCacheTestService testService;

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
    @RequestMapping("/{errorCode}/error")
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
    public String template() throws InterruptedException {
        return "template";
    }


    // TODO 通用文件下载

    /**
     * 获取角色对应的菜单集合
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/{roleId}/menu")
    @ResponseBody
    public List<MenuModel> menu(@PathVariable String roleId) {

        if ("admin".equals(this.getSessionUser().getUserType())){
            // 管理员角色在系统xml中读取
            return this.getMenuFromXml();
        } else {
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

    private List<MenuModel> getMenuFromXml(){
        List<MenuModel> list = new ArrayList<>();

        try {
            // 获取XMl输入流
            InputStream inputStream = this.getClass().getResourceAsStream("/adminMenu.xml");
            // 创建SAXReader对象reader
            SAXReader reader = new SAXReader();
            // 通过reader对象的read方法加载adminMenu.xml文件，获取document对象。
            Document document = reader.read(inputStream);
            // 获取根节点
            Element rootElement = document.getRootElement();
            // 获取所有的一级子节点
            List<Element> elements = rootElement.elements();
            for (Element element : elements) {
                MenuModel model = new MenuModel();
                List<MenuModel> childList = new ArrayList<>();
                model.setName(element.attributeValue("name"));
                model.setIcon(this.isNull(element.attributeValue("icon")) ? "zmdi zmdi-apps" : element.attributeValue("icon"));
                List<Element> childElements = element.elements();
                for (Element childElement : childElements) {
                    MenuModel childModel = new MenuModel();
                    childModel.setName(childElement.elementText("name"));
                    childModel.setUrl(childElement.elementText("url"));
                    childList.add(childModel);
                }
                model.setChildren(childList);
                list.add(model);
            }

        } catch (DocumentException e) {
            logger.error("读取 xml 菜单信息失败");
            e.printStackTrace();
        }

        return list;
    }

}
