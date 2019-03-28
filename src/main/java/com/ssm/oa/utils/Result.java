package com.ssm.oa.utils;

import java.util.List;

public class Result<T> {
    private int code;
    private List<T> list;
    private int total;

    public Result(int code, List<T> list, int total) {
        this.code = code;
        this.list = list;
        this.total = total;
    }

    public Result() {
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}
