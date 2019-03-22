package com.ssm.oa.service;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysMenu;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.utils.Message;

import java.util.List;

public interface ISysMenuService extends IBaseService<SysMenu>{

    PageInfo<SysMenu> getMenuSelectList(Integer pn, Integer pageSize, SysMenu sysMenu);

    List<SysMenu> getSysMenuList();

    Message deleteMenu(Long id);

    Message batchDel(List<Long> idList);

    PageInfo selectMenuByRoleId(Integer pn, Integer pageSize, Long roleId);

    PageInfo selectNoAuthoMenuToRole(Integer pn, Integer pageSize, Long roleId, String menuName);
}