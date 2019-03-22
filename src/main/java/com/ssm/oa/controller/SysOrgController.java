package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysOrg;
import com.ssm.oa.service.ISysOrgService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/sysOrg")
public class SysOrgController {
    @Autowired
    private ISysOrgService sysOrgService;
    @RequestMapping("/query")
    @ResponseBody
    public SysOrg querySysOrgById(@RequestParam Long id){
       return  sysOrgService.selectByPrimaryKey(id);
    }
    @RequestMapping("/orgInfo")
    public String orgList(){
        return "org/orgList";
    }

    @RequestMapping(value = "/orgList",method = RequestMethod.GET)
    @ResponseBody
    public PageInfo getOrgList(@RequestParam  int pn,@RequestParam  int pageSize){
        PageInfo<SysOrg> pageInfo=sysOrgService.getOrgList(pn,pageSize);
        return pageInfo;
    }

    @RequestMapping(value ="/deleteOrg",method = RequestMethod.GET)
    @ResponseBody
    public Message deleteSysOrg(@RequestParam  long id){
        Message message=sysOrgService.deleteFlag(id);
        return message;
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "org/org_add";
    }

    @RequestMapping("/addOrg")
    @ResponseBody
    public Message addOrg(SysOrg sysOrg){
        sysOrgService.insertSelective(sysOrg);
        Message message= new Message();
        message.setMsg("添加成功");
        return message;
    }

    @RequestMapping("/updateOrg")
    @ResponseBody
    public Message updateOrg(SysOrg sysOrg){
        sysOrgService.updateByPrimaryKeySelective(sysOrg);
        Message message= new Message();
        message.setMsg("修改成功");
        return message;
    }

    @RequestMapping("/batchDel")
    @ResponseBody
    public Message batchDel(@RequestParam List<Long> idList){
        Message message= sysOrgService.batchDel(idList);
        return message;
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<SysOrg> getList(){
        List<SysOrg> list=  sysOrgService.getList();
        return list;
    }

    @RequestMapping(value = "/toUpdate/{id}",method = RequestMethod.GET)
    public String toUpdate(@PathVariable Long id,Model model)  {
        SysOrg sysOrg=sysOrgService.selectByPrimaryKey(id);
        model.addAttribute("sysOrg",sysOrg);
        return "org/org_update";

    }
    @RequestMapping("/select")
    @ResponseBody
    public PageInfo getSelectOrgList(Integer pn,Integer pageSize,SysOrg sysOrg){
        PageInfo<SysOrg> pageInfo=sysOrgService.getSelectOrgList(pn,pageSize,sysOrg);
        return pageInfo;
    }

}
