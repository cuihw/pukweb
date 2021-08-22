package com.stuff.manage.data;

import android.util.Log;

import com.google.gson.Gson;
import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.model.LoggedInUser;

import java.io.IOException;

import static android.content.ContentValues.TAG;

/**
 * Class that handles authentication w/ login credentials and retrieves user information.
 */
public class LoginDataSource {

    public Result<LoggedInUser> login(String username, String password) {

        try {
            // TODO: handle loggedInUser authentication
            //http://127.0.0.1/mmmmanage/chklogin_mm.asp?uid=wangbw&password=123456

            OkGo.<String>get(Constant.LOGIN)
                    .params("uid", username) //
                    .params("password", password)
                    .execute(new StringCallback(){
                        @Override
                        public void onSuccess(Response<String> response) {
                            Log.d(TAG, "response : " +  response);
                            Gson gson = new Gson();
                            LoginResult result = gson.fromJson(String.valueOf(response), LoginResult.class);

                            Log.d(TAG, "result : " +  result);
                        }
                    });

            LoggedInUser fakeUser =
                    new LoggedInUser(
                            java.util.UUID.randomUUID().toString(),
                            "Jane Doe");
            return new Result.Success<>(fakeUser);
        } catch (Exception e) {
            return new Result.Error(new IOException("Error logging in", e));
        }
    }

    public void logout() {
        // TODO: revoke authentication
    }
}