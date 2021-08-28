package com.stuff.manage.data.model;

public class DeleteResp {
    private int id;
    private String ret;
    private String message;

    public void setId(int id){
        this.id = id;
    }
    public int getId(){
        return this.id;
    }
    public void setRet(String ret){
        this.ret = ret;
    }
    public String getRet(){
        return this.ret;
    }
    public void setMessage(String message){
        this.message = message;
    }
    public String getMessage(){
        return this.message;
    }

    public boolean isOk(){
        return "OK".equalsIgnoreCase(ret);
    }
}
