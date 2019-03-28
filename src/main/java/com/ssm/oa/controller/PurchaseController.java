package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysPurchase;
import com.ssm.oa.service.ISysPurChaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private ISysPurChaseService purchaseService;

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "purchase/purchase_add";
    }

    @RequestMapping("/select")
    @ResponseBody
    public PageInfo select(Integer pn, Integer pageSize){
        PageInfo<SysPurchase> pageInfo=purchaseService.getPurchaseList(pn,pageSize);
        return pageInfo;
    }

    @RequestMapping("/add")
    @ResponseBody
    public PageInfo add(Integer pn, Integer pageSize, SysPurchase sysPurchase){
        purchaseService.addAndStart(sysPurchase);
        PageInfo<SysPurchase> pageInfo = purchaseService.getPurchaseList(pn, pageSize);
        return pageInfo;
    }


}
