package com.stuff.manage.tools;

import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;

public class MyStringCallback extends StringCallback {

    @Override
    public void onSuccess(Response<String> response) {
    }

    @Override
    public void onError(Response<String> response) {
        super.onError(response);

    }
}
