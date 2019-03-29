package com.ssm.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysPurchase;
import com.ssm.oa.entity.SysUser;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysPurchaseMapper;
import com.ssm.oa.service.ISysPurChaseService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
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
    private TaskService taskService;

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

    @Override
    public SysPurchase getPurchaseByTaskId(Long taskId) {
        //通过taskId获取task对象
        Task task=taskService.createTaskQuery().taskId(taskId.toString()).singleResult();
        //通过task对象获取processInstance对象
        ProcessInstance processInstance =
                runtimeService
                        .createProcessInstanceQuery()
                        .processInstanceId(task.getProcessInstanceId())
                        .singleResult();
        //通过processInstance对象获取 businessKey
        String businessKey=processInstance.getBusinessKey();

        SysPurchase sysPurchase=sysPurchaseMapper.selectByPrimaryKey(Long.parseLong(businessKey));
        return sysPurchase;
    }

    @Override
    public void updateByPrimaryKeySelectiveAndReShenPi(SysPurchase sysPurchase, Long taskId) {
        sysPurchaseMapper.updateByPrimaryKeySelective(sysPurchase);
        Map<String,Object> map=new HashMap<>();
        if(sysPurchase.getFlag()==1){
            map.put("flag", true);
            map.put("account",sysPurchase.getMoney());
        }else if(sysPurchase.getFlag()==0){
            map.put("flag",false);
        }
        taskService.complete(taskId.toString(), map);
    }
}
