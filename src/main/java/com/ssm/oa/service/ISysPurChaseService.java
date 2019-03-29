package com.ssm.oa.service;

import com.github.pagehelper.PageInfo;
import com.ssm.oa.entity.SysPurchase;

public interface ISysPurChaseService extends IBaseService<SysPurchase> {
    PageInfo<SysPurchase> getPurchaseList(Integer pn, Integer pageSize);

    void addAndStart(SysPurchase sysPurchase);

    SysPurchase getPurchaseByTaskId(Long taskId);

    void updateByPrimaryKeySelectiveAndReShenPi(SysPurchase sysPurchase, Long taskId);
}
