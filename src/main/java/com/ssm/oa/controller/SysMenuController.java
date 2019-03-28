package com.ssm.oa.controller;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.service.ISysMenuService;
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
@RequestMapping("/sysMenu")
public class SysMenuController  {
    @Autowired
    private ISysMenuService sysMenuService;
    @RequestMapping("/menuInfo")
    public String menuInfo(){
        return "/menu/menuList";
    }

    @RequestMapping("/select")
    @ResponseBody
    public PageInfo getMenuSelectList(Integer pn,Integer pageSize, SysMenu sysMenu){
        PageInfo<SysMenu> pageInfo=sysMenuService.getMenuSelectList(pn,pageSize,sysMenu);
        return pageInfo;
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "/menu/menu_add";
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<SysMenu> getSysMenuList(){
        List<SysMenu> sysMenuList =sysMenuService.getSysMenuList();
        return sysMenuList;
    }

    @RequestMapping("/addMenu")
    @ResponseBody
    public Message addMenu(SysMenu sysMenu){
        Message message=new Message();
        int count = sysMenuService.insertSelective(sysMenu);
        if(count>0){
            message.setMsg("成功！");
            return message;
        }
        message.setMsg("失败！");
        return message;
    }

    @RequestMapping("/deleteMenu")
    @ResponseBody
    public Message deleteMenu(Long id){
        Message message=sysMenuService.deleteMenu(id);
        return message;
    }

    @RequestMapping("/batchDel")
    @ResponseBody
    public Message batchDel(@RequestParam List<Long> idList){
        Message message=sysMenuService.batchDel(idList);
        return message;
    }

    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id, Model model){
        SysMenu sysMenu = sysMenuService.selectByPrimaryKey(id);
        model.addAttribute("sysMenu",sysMenu);
        return "/menu/menu_update";
    }

    @RequestMapping("/updateMenu")
    @ResponseBody
    public Message updateMenu(SysMenu sysMenu){
        int count = sysMenuService.updateByPrimaryKeySelective(sysMenu);
        Message message=new Message();
        if(count>0){
            message.setMsg("修改成功");
            return message;
        }
        message.setMsg("修改失败");
        return message;
    }


}
