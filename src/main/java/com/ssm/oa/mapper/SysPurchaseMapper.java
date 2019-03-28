package com.ssm.oa.mapper;

import com.ssm.oa.entity.SysPurchase;

import java.util.List;

public interface SysPurchaseMapper extends BaseMapper<SysPurchase> {

    List<SysPurchase> getPurchaseList();
}