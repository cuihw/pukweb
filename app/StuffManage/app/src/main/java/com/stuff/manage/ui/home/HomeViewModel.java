package com.stuff.manage.ui.home;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.google.gson.Gson;
import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.AllDatas;

public class HomeViewModel extends ViewModel {

    private MutableLiveData<String> mText;

    private MutableLiveData<AllDatas> allDatas;

    // AllDatas allDatas;
    // http://127.0.0.1/mmmmanage/displayup_mm.asp?page=0
    public HomeViewModel() {
        allDatas = new MutableLiveData<>();

        //http://127.0.0.1/mmmmanage/chklogin_mm.asp?uid=wangbw&password=123456

        OkGo.<String>get(Constant.GET_ALL_ITEMS).execute(new StringCallback(){
            @Override
            public void onSuccess(Response<String> response) {
                String body = response.body();
                Gson gson = new Gson();
                AllDatas datas = gson.fromJson(body, AllDatas.class);
                allDatas.setValue(datas);
            }
        });
    }

    public LiveData<String> getText() {
        return mText;
    }

    public LiveData<AllDatas> getAllDatas() {
        return allDatas;
    }


}