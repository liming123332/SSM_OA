package com.ssm.oa.utils;

import java.util.HashMap;
import java.util.Map;

public class Message {
    private String msg;
    private Map<String,Object> data=new HashMap();

    public Message() {
    }

    public Message(String msg, Map<String, Object> data) {
        this.msg = msg;
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}
