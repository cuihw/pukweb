package com.stuff.manage.data.model;

import java.util.List;

public class AllDatas {

    private List<ItemData> data;
    private String ret;
    private String message;

    public void setData(List<ItemData> data) {
        this.data = data;
    }

    public List<ItemData> getData() {
        return this.data;
    }

    public void setRet(String ret) {
        this.ret = ret;
    }

    public String getRet() {
        return this.ret;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }

}
