package com.ssm.oa.service;

import com.ssm.oa.entity.SysAudit;

public interface ISysAuditService extends IBaseService<SysAudit> {
    void insertAndComplement(SysAudit sysAudit, Long taskId);
}
