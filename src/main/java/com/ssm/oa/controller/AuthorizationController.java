package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysRole;
import com.ssm.oa.service.ISysMenuService;
import com.ssm.oa.service.ISysRoleService;
import com.ssm.oa.service.ISysUserService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/authorization")
public class AuthorizationController {

    @Autowired
    private ISysRoleService sysRoleService;

    @Autowired
    private ISysMenuService sysMenuService;

    @Autowired
    private ISysUserService sysUserService;
    //跳转到授权页面
    @RequestMapping("/authInfo")
    public String authInfo(){
        return "authorization/authList";
    }
    //获取所有角色
    @RequestMapping("/getRole")
    @ResponseBody
    public List<SysRole> getRole(){
        List<SysRole> roleList = sysRoleService.getRoleList();
        return roleList;
    }
    //通过roleId 查询角色下对应的用户
    @RequestMapping("/selectUserByRoleId")
    @ResponseBody
    public PageInfo selectUserByRoleId(Integer pn,Integer pageSize,Long roleId){
        PageInfo pageInfo=sysUserService.selectUserByRoleId(pn,pageSize,roleId);
        return pageInfo;
    }
    //通过roleId 查询角色下对应的菜单
    @RequestMapping("/selectMenuByRoleId")
    @ResponseBody
    public PageInfo selectMenuByRoleId(Integer pn,Integer pageSize,Long roleId){
        PageInfo pageInfo=sysMenuService.selectMenuByRoleId(pn,pageSize,roleId);
        return pageInfo;
    }
    //授权新用户跳转页面 并携带对应的roleId到该页面上
    @RequestMapping("/addUserToRole")
    public String addUserToRole(Long roleId, Model model){
        model.addAttribute("roleId", roleId);
        return "authorization/userToRole";
    }
    //查询该角色下没有被授权的用户信息
    @RequestMapping("/selectNoAuthoUserToRole")
    @ResponseBody
    public PageInfo selectNoAuthoUserToRole(Integer pn,Integer pageSize,Long roleId,String userName){
        PageInfo pageInfo=sysUserService.selectNoAuthoUserToRole(pn,pageSize,roleId,userName);
        return pageInfo;
    }
    //批量授权
    @RequestMapping("/batchadd")
    @ResponseBody
    public Message batchadd(@RequestParam List<Long> idList,Long roleId){
        Message message=sysRoleService.batchadd(idList,roleId);
        return message;
    }
    //取消授权
    @RequestMapping("/deleteUserToRole")
    @ResponseBody
    public Message deleteUserToRole(Long userId,Long roleId){
        Message message=sysRoleService.deleteUserToRole(userId,roleId);
        return message;
    }
    //授权新新菜单跳转页面 并携带对应的roleId到该页面上
    @RequestMapping("/addMenuToRole")
    public String addMenuToRole(Long roleId,Model model){
        model.addAttribute("roleId", roleId);
        return "authorization/menuToRole";
    }

    @RequestMapping("/selectNoAuthoMenuToRole")
    @ResponseBody
    public PageInfo selectNoAuthoMenuToRole(Integer pn,Integer pageSize,Long roleId,String menuName){
        PageInfo pageInfo=sysMenuService.selectNoAuthoMenuToRole(pn,pageSize,roleId,menuName);
        return pageInfo;
    }
}
