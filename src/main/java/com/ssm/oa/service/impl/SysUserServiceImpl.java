package com.ssm.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysUserMapper;
import com.ssm.oa.service.ISysUserService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysUserServiceImpl extends BaseServiceImpl<SysUser> implements ISysUserService {
    @Autowired
    private SysUserMapper sysUserMapper;
    @Override
    public BaseMapper<SysUser> getMapper() {
        return sysUserMapper;
    }

    @Override
    public PageInfo<SysUser> getSelectUserList(Integer pn, Integer pageSize, SysUser sysUser) {
        PageHelper.startPage(pn,pageSize);
        List<SysUser> sysUserList =sysUserMapper.getSelectUserList(sysUser);
        PageInfo pageInfo=new PageInfo(sysUserList);
        return pageInfo;
    }

    @Override
    public Message deleteUser(Long id) {
       Message message=new Message();
       int count= sysUserMapper.deleteUser(id);
       if(count>0){
            message.setMsg("成功");
            return message;
       }
       message.setMsg("失败");
       return message;
    }

    @Override
    public Message batchDel(List<Long> idList) {
        Message message =new Message();
        int count=sysUserMapper.batchDel(idList);
        if(count>0){
            message.setMsg("成功");
            return message;
        }
        message.setMsg("失败");
        return message;
    }

    @Override
    public PageInfo selectUserByRoleId(int pn, int pageSize, Long roleId) {
        PageHelper.startPage(pn, pageSize);
        List<SysUser> sysUserList =sysUserMapper.selectUserByRoleId(roleId);
        PageInfo pageInfo=new PageInfo(sysUserList);
        return pageInfo;
    }

    @Override
    public PageInfo selectNoAuthoUserToRole(Integer pn, Integer pageSize, Long roleId, String userName) {
        PageHelper.startPage(pn, pageSize);
        List<SysUser> sysUserList =sysUserMapper.selectNoAuthoUserToRole(roleId,userName);
        PageInfo pageInfo=new PageInfo(sysUserList);
        return pageInfo;
    }

}
