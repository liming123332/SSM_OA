package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysRole;
import com.ssm.oa.service.ISysMenuService;
import com.ssm.oa.service.ISysRoleService;
import com.ssm.oa.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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

    @RequestMapping("/authInfo")
    public String authInfo(){
        return "authorization/authList";
    }

    @RequestMapping("/getRole")
    @ResponseBody
    public List<SysRole> getRole(){
        List<SysRole> roleList = sysRoleService.getRoleList();
        return roleList;
    }
    @RequestMapping("/selectUserByRoleId")
    @ResponseBody
    public PageInfo selectUserByRoleId(Integer pn,Integer pageSize,Long roleId){
        PageInfo pageInfo=sysUserService.selectUserByRoleId(pn,pageSize,roleId);
        return pageInfo;
    }

    @RequestMapping("/selectMenuByRoleId")
    @ResponseBody
    public PageInfo selectMenuByRoleId(Integer pn,Integer pageSize,Long roleId){
        PageInfo pageInfo=sysMenuService.selectMenuByRoleId(pn,pageSize,roleId);
        return pageInfo;
    }
}
