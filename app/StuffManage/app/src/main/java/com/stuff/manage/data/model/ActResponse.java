package com.stuff.manage.data.model;

public class ActResponse {
    // {"ret":"ok","message":"Data was added successfully."}

    private String ret;
    private String message;
    public void setRet(String ret) {
        this.ret = ret;
    }
    public String getRet() {
        return ret;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    public String getMessage() {
        return message;
    }

    public boolean isOk(){
        return "OK".equalsIgnoreCase(ret);
    }
}
