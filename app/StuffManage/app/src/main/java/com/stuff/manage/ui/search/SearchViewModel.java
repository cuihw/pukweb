package com.stuff.manage.ui.search;

import android.util.Log;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.Callback;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Progress;
import com.lzy.okgo.model.Response;
import com.lzy.okgo.request.base.Request;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.tools.ToastT;

public class SearchViewModel extends ViewModel {

    private MutableLiveData<String> mText;
    private String TAG = "SearchViewModel";

    public SearchViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("This is slideshow fragment");
    }

    public LiveData<String> getText() {
        return mText;
    }

    public boolean searchRequest(String sKey) {
        // SEARCH
        LoginRepository repo = LoginRepository.getInstance();
        if(repo == null) return false;

        String session = repo.getUser().getSessionId();

        OkGo.<String>get(Constant.SEARCH)
                .params("text", sKey)
                .params("sessionId", session).execute(new StringCallback() {
            @Override
            public void onSuccess(Response<String> response) {
                String body = response.body();

            }

            @Override
            public void onError(Response<String> response) {
                super.onError(response);
                Log.d(TAG, response.body());
            }
        });

        return true;
    }
}