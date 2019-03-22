package com.ssm.oa.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysMenuMapper;
import com.ssm.oa.service.ISysMenuService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysMenuServiceImpl extends BaseServiceImpl<SysMenu> implements ISysMenuService {
    @Autowired
    private SysMenuMapper sysMenuMapper;
    @Override
    public BaseMapper<SysMenu> getMapper() {
        return sysMenuMapper;
    }

    @Override
    public PageInfo<SysMenu> getMenuSelectList(Integer pn, Integer pageSize, SysMenu sysMenu) {
        PageHelper.startPage(pn,pageSize);
        List<SysMenu> sysMenuList =sysMenuMapper.getMenuSelectList(sysMenu);
        PageInfo pageInfo=new PageInfo(sysMenuList);
        return pageInfo;
    }

    @Override
    public List<SysMenu> getSysMenuList() {
        return sysMenuMapper.getSysMenuList();
    }

    @Override
    public Message deleteMenu(Long id) {
        int count=sysMenuMapper.getMenuChildrenCount(id);
        Message message=new Message();
        if(count>0){
            message.setMsg("失败");
            return message;
        }
        int count1=sysMenuMapper.deleteMenu(id);
        message.setMsg("成功");
        return message;
    }

    @Override
    public Message batchDel(List<Long> idList) {
        int count=sysMenuMapper.getMenuBatchChildrenCount(idList);
        Message message=new Message();
        if(count>0){
            message.setMsg("失败");
            return message;
        }
        sysMenuMapper.deleteBatchMenu(idList);
        message.setMsg("成功");
        return message;
    }

    @Override
    public PageInfo selectMenuByRoleId(Integer pn, Integer pageSize, Long roleId) {
        PageHelper.startPage(pn, pageSize);
        List<SysMenu> sysMenuList =sysMenuMapper.selectMenuByRoleId(roleId);
        PageInfo pageInfo=new PageInfo(sysMenuList);
        return pageInfo;
    }
}
