package com.swp.module.product.controller;


import com.swp.module.product.mapper.TbProductMapper;
import com.swp.module.product.model.TbProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("product")
public class ProductController {

    @Autowired
    private TbProductMapper mapper;

    @RequestMapping("index")
    public String index(Model model){
        TbProduct tbProduct = mapper.selectByPrimaryKey("1ba6d11d2639401ebf63c00c5ae7c2a0");
        model.addAttribute("name",tbProduct.getProductName());
        return "index";
    }

}
