package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysRole;
import com.ssm.oa.service.ISysRoleService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/sysRole")
public class SysRoleController {
    @Autowired
    private ISysRoleService sysRoleService;
    @RequestMapping("/roleInfo")
    public String roleInfo(){
        return "role/roleList";
    }

    @RequestMapping("/select")
    @ResponseBody
    public PageInfo getSelectRoleList(Integer pn,Integer pageSize,SysRole sysRole){
        PageInfo<SysRole> pageInfo=sysRoleService.getSelectRoleList(pn,pageSize,sysRole);
        /*System.out.println(pageInfo);*/
        return pageInfo;
    }
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "/role/role_add";
    }

    @RequestMapping("/addRole")
    @ResponseBody
    public Message addRole(SysRole role){
        Message message=new Message();
        int i = sysRoleService.insertSelective(role);
        if(i>0){
            message.setMsg("添加成功");
            return message;
        }else{
            message.setMsg("添加失败");
            return message;
        }
    }

    @RequestMapping("/deleteRole")
    @ResponseBody
    public Message deleteRole(Long id){
        Message message=sysRoleService.deleteRole(id);
        return message;
    }

    @RequestMapping("/batchDel")
    @ResponseBody
    public Message batchDel(@RequestParam List<Long> idList){
        Message message=sysRoleService.batchDel(idList);
        return message;
    }

    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id, Model model){
        SysRole sysRole=sysRoleService.selectByPrimaryKey(id);
        model.addAttribute("sysRole",sysRole);
        return "role/role_update";
    }

    @RequestMapping("/updateRole")
    @ResponseBody
    public Message updateRole(SysRole sysRole){
        Message message=new Message();
        if(sysRole.getRoleId()==1L){
            message.setMsg("该用户为管理员不能修改");
            return message;
        }
        sysRoleService.updateByPrimaryKeySelective(sysRole);
        message.setMsg("修改成功");
        return message;
    }

}
