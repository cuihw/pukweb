package com.stuff.manage.ui.login;

import android.util.Log;

import androidx.annotation.Nullable;

import com.stuff.manage.data.model.LoggedInUser;

/**
 * Authentication result : success (user details) or error message.
 */
class LoginResult {
    @Nullable
    private LoggedInUserView success;
    @Nullable
    private Integer error;  //"Login failed"

    private LoggedInUser data;

    LoginResult(@Nullable Integer error) {
        this.error = error;
    }

    LoginResult(@Nullable LoggedInUserView success) {
        this.success = success;
    }

    LoginResult(@Nullable LoggedInUserView success, LoggedInUser data ) {
        this.success = success;
        this.data = data;
    }

    @Nullable
    LoggedInUserView getSuccess() {
        return success;
    }
    LoggedInUser getData() {
        return data;
    }

    @Nullable
    Integer getError() {
        return error;
    }
}