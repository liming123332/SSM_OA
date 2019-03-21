package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysOrg;

import java.util.List;

public interface SysOrgMapper extends BaseMapper<SysOrg> {

    List<SysOrg> getOrgList();

    int countParent(long id);

    int batchCount(List<Long> idList);

    void batchDel(List<Long> idList);

    List<SysOrg> getSelectOrgList(SysOrg sysOrg);
}