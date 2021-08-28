package com.stuff.manage.data;

import android.util.Log;

import com.google.gson.Gson;
import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.model.LoggedInUser;
import com.stuff.manage.data.model.LoginResponse;
import com.stuff.manage.tools.StringUtils;

import static android.content.ContentValues.TAG;

/**
 * Class that handles authentication w/ login credentials and retrieves user information.
 */
public class LoginDataSource {

    public boolean login(String username, String password) {

        try {
            // TODO: handle loggedInUser authentication
            //http://127.0.0.1/mmmmanage/chklogin_mm.asp?uid=wangbw&password=123456

            OkGo.<String>get(Constant.LOGIN)
                    .params("uid", username) //
                    .params("password", password)
                    .execute(new StringCallback(){
                        @Override
                        public void onSuccess(Response<String> response) {
                            String body =  response.body();
                            Log.d(TAG, "response: " +  body);
                            LoginResponse result = StringUtils.getDataFromString(body,LoginResponse.class);
                            Log.d(TAG, "result : " +  result);
                            notifyLoginResponse(username, result);
                        }

                        @Override
                        public void onError(Response<String> response) {
                            Log.d(TAG, "onError: " +  response.body());
                            notifyLoginResponse("", null);
                            super.onError(response);
                        }

                        @Override
                        public void onFinish() {
                            Log.d(TAG, "onFinish");
                            super.onFinish();
                        }
                    });
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private void notifyLoginResponse(String username,  LoginResponse result) {
        LoginRepository repo = LoginRepository.getInstance(this);

        if (result == null) {
            repo.setLoggedInUser(null);
            return;
        }
        LoggedInUser loggedInUser = new LoggedInUser(result.getMd5Result() ,  username);
        loggedInUser.setResponse(result);
        repo.setLoggedInUser(loggedInUser);
    }

    public void logout() {
        // TODO: revoke authentication
    }
}