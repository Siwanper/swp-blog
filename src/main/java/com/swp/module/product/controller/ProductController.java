package com.swp.module.product.controller;


import com.swp.core.annotation.MapperInject;
import com.swp.core.controller.BaseController;
import com.swp.core.model.PageModel;
import com.swp.module.product.mapper.TbProductMapper;
import com.swp.module.product.model.TbProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/module/product")
public class ProductController extends BaseController{

    @MapperInject(TbProductMapper.class)
    private TbProductMapper mapper;

    @RequestMapping("/init")
    public String init(){
        return "/module/product/init";
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public PageModel list(int offset, int limit, String search, String sort, String order){

        // 使用父类封装方法（推荐）
        this.setDataSource("extendDataSource");
        this.offsetPage(offset, limit);
        List<TbProduct> list = mapper.selectByExample(null);
        this.clearDataSource();
        return this.resultPage(list);
    }


}
