package com.stuff.manage.ui.login;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import android.util.Log;
import android.util.Patterns;

import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.data.OnLogin;
import com.stuff.manage.data.Result;
import com.stuff.manage.data.model.LoggedInUser;
import com.stuff.manage.R;

public class LoginViewModel extends ViewModel {

    private static final String TAG = "LoginViewModel";
    private MutableLiveData<LoginFormState> loginFormState = new MutableLiveData<>();
    private MutableLiveData<LoginResult> loginResult = new MutableLiveData<>();
    private LoginRepository loginRepository;

    LoginViewModel(LoginRepository loginRepository) {
        this.loginRepository = loginRepository;
    }

    LiveData<LoginFormState> getLoginFormState() {
        return loginFormState;
    }

    LiveData<LoginResult> getLoginResult() {
        return loginResult;
    }

    public void login(String username, String password) {
        // can be launched in a separate asynchronous job
        loginRepository.setOnLoginLister(new OnLogin() {

            @Override
            public void onlogin(boolean isLogin) {
                Log.d(TAG, "isLogin: " + isLogin);
                if (isLogin) {
                    LoggedInUser data = loginRepository.getUser();
                    loginResult.setValue(new LoginResult(new LoggedInUserView(data.getDisplayName())
                    , data));
                } else {
                    loginResult.setValue(new LoginResult(R.string.login_failed));
                }
            }
        });
        boolean requestResult = loginRepository.login(username, password);
        Log.d(TAG, "requestResult: " + requestResult);
    }

    public void loginDataChanged(String username, String password) {
        if (!isUserNameValid(username)) {
            loginFormState.setValue(new LoginFormState(R.string.invalid_username, null));
        } else if (!isPasswordValid(password)) {
            loginFormState.setValue(new LoginFormState(null, R.string.invalid_password));
        } else {
            loginFormState.setValue(new LoginFormState(true));
        }
    }

    // A placeholder username validation check
    private boolean isUserNameValid(String username) {
        return true;
    }

    // A placeholder password validation check
    private boolean isPasswordValid(String password) {
        return password != null && password.trim().length() > 5;
    }
}