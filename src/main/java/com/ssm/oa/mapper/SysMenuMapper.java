package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysMenu;

import java.util.List;

public interface SysMenuMapper extends BaseMapper<SysMenu>{

    List<SysMenu> getMenuSelectList(SysMenu sysMenu);

    List<SysMenu> getSysMenuList();

    int getMenuChildrenCount(Long id);

    int deleteMenu(Long id);

    int getMenuBatchChildrenCount(List<Long> idList);

    int deleteBatchMenu(List<Long> idList);

    List<SysMenu> selectMenuByRoleId(Long roleId);
}