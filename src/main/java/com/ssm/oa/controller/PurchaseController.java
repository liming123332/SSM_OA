package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysAudit;
import com.ssm.oa.entity.SysPurchase;
import com.ssm.oa.service.ISysAuditService;
import com.ssm.oa.service.ISysPurChaseService;
import com.ssm.oa.utils.Message;
import org.activiti.engine.FormService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.TaskFormData;
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
    private TaskService taskService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private FormService formService;

    @Autowired
    private ISysPurChaseService purChaseService;

    @Autowired
    private ISysAuditService sysAuditService;

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "purchase/purchase_add";
    }

    @RequestMapping("/select")
    @ResponseBody
    public PageInfo select(Integer pn, Integer pageSize){
        PageInfo<SysPurchase> pageInfo=purChaseService.getPurchaseList(pn,pageSize);
        return pageInfo;
    }

    @RequestMapping("/add")
    @ResponseBody
    public PageInfo add(Integer pn, Integer pageSize, SysPurchase sysPurchase){
        purChaseService.addAndStart(sysPurchase);
        PageInfo<SysPurchase> pageInfo = purChaseService.getPurchaseList(pn, pageSize);
        return pageInfo;
    }

    @RequestMapping("/toShenpi/{taskId}")
    public String toShenpi(@PathVariable Long taskId, Model model){
        TaskFormData taskFormData = formService.getTaskFormData(taskId.toString());
        SysPurchase sysPurchase=purChaseService.getPurchaseByTaskId(taskId);
        String formKey = taskFormData.getFormKey();
        model.addAttribute("purchase",sysPurchase);
        model.addAttribute("taskId", taskId);
        if("rePurchase".equals(formKey)){
            return "purchase/purchase_toReShenqi";
        }

        return "purchase/purchase_shenpi";
    }

    @RequestMapping("/shenpi")
    public void shenpi(SysAudit sysAudit,Long taskId){
        sysAuditService.insertAndComplement(sysAudit,taskId);
    }

    @RequestMapping("/toReShenqing")
    public void toReShenqing(SysPurchase sysPurchase,Long taskId) {
        purChaseService.updateByPrimaryKeySelectiveAndReShenPi(sysPurchase,taskId);
    }
}
