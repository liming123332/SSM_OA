package com.ssm.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysOrg;
import com.ssm.oa.mapper.BaseMapper;
import com.ssm.oa.mapper.SysOrgMapper;
import com.ssm.oa.service.ISysOrgService;
import com.ssm.oa.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysOrgServiceImpl extends BaseServiceImpl<SysOrg> implements ISysOrgService {
    @Autowired
    private SysOrgMapper sysOrgMapper;
    @Override
    public BaseMapper<SysOrg> getMapper() {
        return sysOrgMapper;
    }

    @Override
    public PageInfo<SysOrg> getOrgList(int pn,int pageSize) {
        PageHelper.startPage(pn,pageSize);
        List<SysOrg> list=sysOrgMapper.getOrgList();
        PageInfo pageInfo=new PageInfo(list);
        return pageInfo;
    }

    @Override
    public List<SysOrg> getList() {
        return sysOrgMapper.getOrgList();
    }

    @Override
    public Message deleteFlag(long id) {
        Message message=new Message();
        int count=sysOrgMapper.countParent(id);
        if(count>0){
            message.setMsg("失败");
           return message;
        }else{
            SysOrg sysOrg=new SysOrg();
            sysOrg.setOrgId(id);
            sysOrg.setFlag(false);
            sysOrgMapper.updateByPrimaryKeySelective(sysOrg);
            message.setMsg("成功");
            return message;
        }

    }

    @Override
    public Message batchDel(List<Long> idList) {
        Message message=new Message();
        int count=sysOrgMapper.batchCount(idList);
        if(count>0){
            message.setMsg("失败");
            return message;
        }else {
            sysOrgMapper.batchDel(idList);
            message.setMsg("成功");
            return message;
        }

    }

    @Override
    public PageInfo<SysOrg> getSelectOrgList(int pn, int pageSize, SysOrg sysOrg) {
        PageHelper.startPage(pn,pageSize);
        List<SysOrg> selectOrgList = sysOrgMapper.getSelectOrgList(sysOrg);
        PageInfo pageInfo=new PageInfo(selectOrgList);
        return pageInfo;
    }
}
