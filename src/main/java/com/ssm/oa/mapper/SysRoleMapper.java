package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysRoleMapper extends BaseMapper<SysRole> {

    List<SysRole> getSelectRoleList(SysRole sysRole);

    int batchDel(List<Long> idList);

    List<SysRole> getRoleList();

    int batchadd(@Param("idList") List<Long> idList,@Param("roleId") Long roleId);

    int deleteUserToRole(@Param("userId") Long userId,@Param("roleId") Long roleId);
}