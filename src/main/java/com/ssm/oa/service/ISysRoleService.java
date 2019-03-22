package com.ssm.oa.service;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysRole;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.utils.Message;

import java.util.List;

public interface ISysRoleService extends IBaseService<SysRole> {

    PageInfo<SysRole> getSelectRoleList(Integer pn, Integer pageSize, SysRole sysRole);

    List<SysRole> getRoleList();

    Message deleteRole(Long id);

    Message batchDel(List<Long> idList);

}