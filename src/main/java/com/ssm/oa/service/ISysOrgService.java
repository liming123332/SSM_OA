package com.ssm.oa.service;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysOrg;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.utils.Message;

import java.util.List;

public interface ISysOrgService extends IBaseService<SysOrg> {

    PageInfo<SysOrg> getOrgList(int pn,int pageSize);

    List<SysOrg> getList();

    Message deleteFlag(long id);

    Message batchDel(List<Long> idList);

    PageInfo<SysOrg> getSelectOrgList(int pn, int pageSize, SysOrg sysOrg);
}