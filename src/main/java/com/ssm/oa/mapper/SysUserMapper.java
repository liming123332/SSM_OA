package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysUser;

import java.util.List;

public interface SysUserMapper extends BaseMapper<SysUser> {

    List<SysUser> getSelectUserList(SysUser sysUser);

    int deleteUser(Long id);

    int batchDel(List<Long> idList);
}