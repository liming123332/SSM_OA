package com.ssm.oa.service.impl;

import com.ssm.oa.entity.SysAudit;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysAuditMapper;
import com.ssm.oa.service.ISysAuditService;
import org.activiti.engine.TaskService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class SysAuditServiceImpl extends BaseServiceImpl<SysAudit> implements ISysAuditService {

    @Autowired
    private SysAuditMapper sysAuditMapper;

    @Autowired
    private TaskService taskService;

    @Override
    public BaseMapper<SysAudit> getMapper() {
        return sysAuditMapper;
    }

    @Override
    public void insertAndComplement(SysAudit sysAudit, Long taskId) {
        Subject subject = SecurityUtils.getSubject();
        SysUser sysUser = (SysUser) subject.getPrincipal();
        sysAudit.setUserId(sysUser.getUserId());
        sysAudit.setUserName(sysUser.getUserName());
        sysAuditMapper.insertSelective(sysAudit);
        Map<String,Object> map=new HashMap<>();
        map.put("flag",sysAudit.getStatus());
        taskService.complete(taskId.toString(), map);
    }
}
