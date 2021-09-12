package com.stuff.manage.ui.admin;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.ActResponse;
import com.stuff.manage.tools.StringUtils;

public class AdminViewModel extends ViewModel {

    private MutableLiveData<String> mUsername;
    private MutableLiveData<ActResponse> mActResponse;

    public AdminViewModel() {
        mUsername = new MutableLiveData<>();
        mActResponse = new MutableLiveData<>();
    }
    public LiveData<ActResponse> getActResponse() {
        return mActResponse;
    }
    public LiveData<String> getUsername() {
        return mUsername;
    }

    public int changePassword(String displayName, String sessionId, String oldPassword, String newPassword) {
        //CHANGE_PASSWORD
        OkGo.<String>get(Constant.CHANGE_PASSWORD).params("uid", displayName)
                .params("sessionId", sessionId)
                .params("oldwd", oldPassword)
                .params("newwd", newPassword)
                .execute(new StringCallback() {
                    @Override
                    public void onSuccess(Response<String> response) {
                        String body = response.body();
                        ActResponse resp = StringUtils.getDataFromString(body, ActResponse.class);
                        notifyResult(resp);
                    }
                });
        return Constant.SUCCESSED;
    }

    private void notifyResult(ActResponse resp) {
    }
}