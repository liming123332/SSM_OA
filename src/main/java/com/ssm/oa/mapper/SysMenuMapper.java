package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysMenuMapper extends BaseMapper<SysMenu>{

    List<SysMenu> getMenuSelectList(SysMenu sysMenu);

    List<SysMenu> getSysMenuList();

    int getMenuChildrenCount(Long id);

    int deleteMenu(Long id);

    int getMenuBatchChildrenCount(List<Long> idList);

    int deleteBatchMenu(List<Long> idList);

    List<SysMenu> selectMenuByRoleId(Long roleId);

    List<SysMenu> selectNoAuthoMenuToRole(@Param("roleId") Long roleId, @Param("menuName") String menuName);
}