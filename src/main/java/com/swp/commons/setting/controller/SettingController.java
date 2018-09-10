package com.swp.commons.setting.controller;

import com.swp.core.annotation.LogInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.MsgModel;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 描述:
 * 系统设置控制器
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-09-10 上午9:37
 */
@Controller
@RequestMapping("/commons/setting")
public class SettingController extends BaseController {

    @LogInject
    private Logger logger;

    @RequestMapping("/manage")
    public String manage(Model model){
        String uploadPath = this.propertiesValue("setting.upload");
        model.addAttribute("uploadPath",uploadPath);
        return "common/setting/manage";
    }

    @RequestMapping("/save")
    @ResponseBody
    public MsgModel save(String uploadPath){
        String filePath = this.getClass().getResource("/properties/setting.properties").getPath();
        String content = "#setting.upload=/Users/ios/Desktop/upload	\n"
                        +"setting.upload="+uploadPath;
        this.writeToFile(content,filePath);
        return this.resultMsg("1","保存成功！");
    }

}
