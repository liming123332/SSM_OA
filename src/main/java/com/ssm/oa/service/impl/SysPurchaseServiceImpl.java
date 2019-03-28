package com.ssm.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysPurchase;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysPurchaseMapper;
import com.ssm.oa.service.ISysPurChaseService;
import org.activiti.engine.RuntimeService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class SysPurchaseServiceImpl extends BaseServiceImpl<SysPurchase> implements ISysPurChaseService {

    @Autowired
    private SysPurchaseMapper sysPurchaseMapper;

    @Autowired
    private RuntimeService runtimeService;

    @Override
    public BaseMapper<SysPurchase> getMapper() {
        return sysPurchaseMapper;
    }

    @Override
    public PageInfo<SysPurchase> getPurchaseList(Integer pn, Integer pageSize) {
        PageHelper.startPage(pn, pageSize);
        List<SysPurchase> sysPurchaseList=sysPurchaseMapper.getPurchaseList();
        PageInfo pageInfo=new PageInfo(sysPurchaseList);
        return pageInfo;
    }

    @Override
    public void addAndStart(SysPurchase sysPurchase) {
        Subject subject =SecurityUtils.getSubject();
        SysUser sysUser = (SysUser) subject.getPrincipal();
        sysPurchase.setUserId(sysUser.getUserId());
        sysPurchase.setUserName(sysUser.getUserName());
        sysPurchaseMapper.insertSelective(sysPurchase);
        String businessKey=sysPurchase.getId().toString();
        Map<String,Object> map=new HashMap<>();
        map.put("account", sysPurchase.getMoney());
        map.put("administrationId", 2);
        map.put("managerId",3);
        map.put("financeId",4);
        map.put("currentId",1);
        runtimeService.startProcessInstanceByKey("purchase",businessKey,map);
    }
}
