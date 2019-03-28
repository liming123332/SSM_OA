package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysUserMapper extends BaseMapper<SysUser> {

    List<SysUser> getSelectUserList(SysUser sysUser);

    int deleteUser(Long id);

    int batchDel(List<Long> idList);

    List<SysUser> selectUserByRoleId(Long roleId);

    List<SysUser> selectNoAuthoUserToRole(@Param("roleId") Long roleId,@Param("userName") String userName);

    SysUser checkLogin(SysUser sysUser);

    List<SysMenu> getMenu(Long userId);

    SysUser getUserByName(String username);
}