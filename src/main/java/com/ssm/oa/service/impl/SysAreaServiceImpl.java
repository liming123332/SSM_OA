package com.ssm.oa.service.impl;

import com.ssm.oa.entity.SysArea;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysAreaMapper;
import com.ssm.oa.service.ISysAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SysAreaServiceImpl extends BaseServiceImpl<SysArea> implements ISysAreaService {
    @Autowired
    private SysAreaMapper sysAreaMapper;
    @Override
    public BaseMapper<SysArea> getMapper() {
        return sysAreaMapper;
    }
}
