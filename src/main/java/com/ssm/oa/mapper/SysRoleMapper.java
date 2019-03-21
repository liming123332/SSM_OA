package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysRole;

import java.util.List;

public interface SysRoleMapper extends BaseMapper<SysRole> {

    List<SysRole> getSelectRoleList(SysRole sysRole);

    int batchDel(List<Long> idList);
}