package com.stuff.manage.ui.search;

import android.util.Log;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.data.model.SearchResultData;
import com.stuff.manage.tools.StringUtils;

public class SearchViewModel extends ViewModel {

    private MutableLiveData<String> mTotal;
    private String TAG = "SearchViewModel";

    private MutableLiveData<SearchResultData> resultData;

    public SearchViewModel() {
        mTotal = new MutableLiveData<>();
        resultData = new MutableLiveData<>();
    }

    public LiveData<String> getTotal() {
        return mTotal;
    }
    public LiveData<SearchResultData> getResultData() {
        return resultData;
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
                SearchResultData data = StringUtils.getDataFromString(body, SearchResultData.class);
                resultData.setValue(data);
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