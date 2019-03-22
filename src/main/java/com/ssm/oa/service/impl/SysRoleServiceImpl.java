package com.ssm.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.entity.SysRole;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysMenuMapper;
import com.ssm.oa.mapper.SysRoleMapper;
import com.ssm.oa.service.ISysRoleService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements ISysRoleService {
    @Autowired
    private SysRoleMapper sysRoleMapper;
    @Override
    public BaseMapper<SysRole> getMapper() {
        return sysRoleMapper;
    }

    @Override
    public PageInfo<SysRole> getSelectRoleList(Integer pn, Integer pageSize, SysRole sysRole) {
        PageHelper.startPage(pn,pageSize);
        List<SysRole> sysRoleList= sysRoleMapper.getSelectRoleList(sysRole);
        PageInfo pageInfo=new PageInfo(sysRoleList);
        return pageInfo;
    }

    @Override
    public List<SysRole> getRoleList() {
        return sysRoleMapper.getRoleList();
    }

    @Override
    public Message deleteRole(Long id) {
        Message message=new Message();
        if(id==1L){
            message.setMsg("失败");
            return message;
        }else {
            SysRole sysRole = new SysRole();
            sysRole.setRoleId(id);
            sysRole.setFlag(false);
            sysRoleMapper.updateByPrimaryKeySelective(sysRole);
            message.setMsg("成功");
            return message;
        }
    }

    @Override
    public Message batchDel(List<Long> idList) {
        Message message=new Message();
        boolean flag=false;
        for (Long aLong : idList) {
            if(aLong==1L){
                flag=true;
                break;
            }
        }
        if(flag){
            message.setMsg("失败");
            return message;
        }
        sysRoleMapper.batchDel(idList);
        message.setMsg("成功");
        return message;
    }

    @Override
    public Message batchadd(List<Long> idList, Long roleId) {
        Message message=new Message();
        int count=sysRoleMapper.batchadd(idList,roleId);
        if(count>0){
            message.setMsg("成功");
            return message;
        }
        message.setMsg("失败");
        return message;
    }

    @Override
    public Message deleteUserToRole(Long userId, Long roleId) {
        Message message=new Message();
        int count=sysRoleMapper.deleteUserToRole(userId,roleId);
        if(count>0){
            message.setMsg("成功");
            return message;
        }
        message.setMsg("失败");
        return message;
    }

}
