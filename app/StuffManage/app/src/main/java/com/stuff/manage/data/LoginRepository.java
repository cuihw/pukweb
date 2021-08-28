package com.stuff.manage.data;

import android.util.Log;

import com.stuff.manage.data.model.LoggedInUser;

/**
 * Class that requests authentication and user information from the remote data source and
 * maintains an in-memory cache of login status and user credentials information.
 */
public class LoginRepository {

    private static final String TAG = "";
    private static volatile LoginRepository instance;

    private LoginDataSource dataSource;
    OnLogin onLoginListener;

    // If user credentials will be cached in local storage, it is recommended it be encrypted
    // @see https://developer.android.com/training/articles/keystore
    private LoggedInUser user = null;

    // private constructor : singleton access
    private LoginRepository(LoginDataSource dataSource) {
        this.dataSource = dataSource;
    }

    public static LoginRepository getInstance(LoginDataSource dataSource) {
        if (instance == null) {
            instance = new LoginRepository(dataSource);
        }
        return instance;
    }

    public static LoginRepository getInstance() {
        return instance;
    }

    public boolean isLoggedIn() {
        if (user == null) return false;
        if (user.getResponse() == null) return  false;
        return "OK".equalsIgnoreCase(user.getResponse().getRet());
    }

    public void logout() {
        user = null;
        dataSource.logout();
    }
    public LoggedInUser getUser() {
        return user;
    }

    public void setLoggedInUser(LoggedInUser user) {
        this.user = user;
        boolean islogined = isLoggedIn();
        Log.d(TAG ,"islogined: " + islogined);

        // notify the onLoginListener
        if (onLoginListener != null) {
            onLoginListener.onlogin(islogined);
        }
    }

    public boolean login(String username, String password) {
        // handle login
        boolean result = dataSource.login(username, password);
        return result;
    }

    public void setOnLoginLister(OnLogin onLogin) {
        onLoginListener = onLogin;
    }
}