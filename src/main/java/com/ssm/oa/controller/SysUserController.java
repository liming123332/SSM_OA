package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.service.ISysUserService;
import com.ssm.oa.utils.Message;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/sysUser")
public class SysUserController {
    @Autowired
    private ISysUserService sysUserService;
    @RequestMapping("/userInfo")
    public String userInfo(){
        return "user/userList";
    }
    @RequestMapping("/select")
    @ResponseBody
    public PageInfo getSelectUserList(Integer pn,Integer pageSize, SysUser sysUser){
        PageInfo<SysUser> pageInfo=sysUserService.getSelectUserList(pn,pageSize,sysUser);
        /*System.out.println(pageInfo);*/
        return pageInfo;
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "/user/user_add";
    }

    @RequestMapping("/addUser")
    @ResponseBody
    public Message addUser(SysUser sysUser){
        Message message=new Message();
        sysUserService.insertSelective(sysUser);
        message.setMsg("添加成功");
        return message;
    }

    @RequestMapping("/deleteUser")
    @ResponseBody
    public Message deleteUser(Long id){
        Message message=sysUserService.deleteUser(id);
        return message;
    }

    @RequestMapping("/batchDel")
    @ResponseBody
    public Message batchDel(@RequestParam  List<Long> idList){
        Message message= sysUserService.batchDel(idList);
        return message;
    }
    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id, Model model){
        SysUser sysUser = sysUserService.selectByPrimaryKey(id);
        model.addAttribute("sysUser",sysUser);
        return "/user/user_update";
    }

    @RequestMapping("/updateUser")
    @ResponseBody
    public Message updateUser(SysUser sysUser){
        Message message=new Message();
       int count=sysUserService.updateByPrimaryKeySelective(sysUser);
       if(count>0){
           message.setMsg("修改成功");
           return message;
       }
       message.setMsg("修改失败");
       return message;
    }

    @RequestMapping("/checkLogin")
    public String checkLogin(SysUser sysUser,Model model){
        /*SysUser currentUser=sysUserService.checkLogin(sysUser);
        if(currentUser!=null){
            List<SysMenu> list=sysUserService.getMenu(currentUser.getUserId());
            model.addAttribute("sysMenuList",list);
            return "index";
        }
            return "login";*/
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated()){
            UsernamePasswordToken token=new UsernamePasswordToken(sysUser.getUserName(), sysUser.getUserPassword());
            try {
                subject.login(token);
            }catch (AuthenticationException e){
                System.out.println("验证失败");
                return "login";
            }
        }
        SysUser currentUser = (SysUser) subject.getPrincipal();
        List<SysMenu> list=sysUserService.getMenu(currentUser.getUserId());
        model.addAttribute("sysMenuList",list);
        return "index";

    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }


}
