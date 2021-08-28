package com.stuff.manage.data.model;

import com.google.gson.Gson;

/**
 * Data class that captures user information for logged in users retrieved from LoginRepository
 */
public class LoggedInUser {

    private String userId;
    private String displayName;

    private LoginResponse response;

    public LoggedInUser(String userId, String displayName) {
        this.userId = userId;
        this.displayName = displayName;
    }

    public String getUserId() {
        return userId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public LoginResponse getResponse() {
        return response;
    }

    public void setResponse(LoginResponse response) {
        this.response = response;
    }

    public String toGsonString() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }

    public static LoggedInUser toObject(String json) {
        Gson gson = new Gson();
        return gson.fromJson(json, LoggedInUser.class);
    }

}