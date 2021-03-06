package com.ssm.oa.service;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.utils.Message;

import java.util.List;

public interface ISysUserService extends IBaseService<SysUser> {

    PageInfo<SysUser> getSelectUserList(Integer pn, Integer pageSize, SysUser sysUser);

    Message deleteUser(Long id);

    Message batchDel(List<Long> idList);

    PageInfo selectUserByRoleId(int pn, int pageSize, Long roleId);

    PageInfo selectNoAuthoUserToRole(Integer pn, Integer pageSize, Long roleId, String userName);

    SysUser checkLogin(SysUser sysUser);

    List<SysMenu> getMenu(Long userId);

    SysUser getUserByName(String username);
}