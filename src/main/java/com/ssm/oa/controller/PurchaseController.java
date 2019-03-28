package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysPurchase;
import com.ssm.oa.service.ISysPurChaseService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private ISysPurChaseService purchaseService;

    @Autowired
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;
    
    @Autowired
    private ISysPurChaseService purChaseService;

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

    @RequestMapping("/toShenpi/{taskId}")
    public String toShenpi(@PathVariable Long taskId, Model model){
        //通过taskId获取task对象
        Task task=taskService.createTaskQuery().taskId(taskId.toString()).singleResult();
        //通过task对象获取processInstance对象
        ProcessInstance processInstance =
                runtimeService
                        .createProcessInstanceQuery()
                        .processInstanceId(task.getProcessInstanceId())
                        .singleResult();
        //通过processInstance对象获取 businessKey
        String businessKey=processInstance.getBusinessKey();
        SysPurchase sysPurchase = purChaseService.selectByPrimaryKey(Long.parseLong(businessKey));
        model.addAttribute("sysPurchase",sysPurchase);
        model.addAttribute("task", task);
        return "purchase/purchase_shenpi";
    }


}
