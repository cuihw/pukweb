package com.stuff.manage.ui.home;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.google.gson.Gson;
import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.CacheData;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.data.model.AllDatas;
import com.stuff.manage.data.model.DeleteResp;
import com.stuff.manage.tools.StringUtils;

public class HomeViewModel extends ViewModel {

    private MutableLiveData<String> mText;
    private int currentDataPage = 1;

    private MutableLiveData<AllDatas> allDatas;

    private MutableLiveData<DeleteResp> deleteResp;

    // AllDatas allDatas;
    public HomeViewModel() {
        allDatas = new MutableLiveData<>();
        deleteResp = new MutableLiveData<>();
        getAllData();
    }

    public void getAllData() {
        // http://127.0.0.1/mmmmanage/displayup_mm.asp?page=0   size 30;
        OkGo.<String>get(Constant.GET_ALL_ITEMS)
                .params("page", currentDataPage)
                .execute(new StringCallback(){
                    @Override
                    public void onSuccess(Response<String> response) {
                        String body = response.body();
                        Gson gson = new Gson();
                        AllDatas datas = gson.fromJson(body, AllDatas.class);
                        CacheData.cAllDatas = datas;
                        allDatas.setValue(datas);
                    }
                });
    }

    public LiveData<String> getText() {
        return mText;
    }

    public void goNextPage(){
        currentDataPage ++;
    }


    public void setCurrentDataPage(int page) {
        currentDataPage = page;
    }

    public int getCurrentDataPage() {
        return currentDataPage;
    }

    public LiveData<AllDatas> getAllDatas() {
        return allDatas;
    }

    public void setLivDatas(AllDatas datas){
        allDatas.setValue(datas);
    }

    public boolean deleteItem(int id) {

        // mmmmanage/delete_mm.asp?sessionId=$MD5~P$B64$pw35QN4Ci43BhqCjyKDbLg==$ikzmgEGd2yXlO8VxavImQQ==&ID=2294
        LoginRepository repo = LoginRepository.getInstance();
        if(repo == null) return false;

        String session = repo.getUser().getSessionId();

        OkGo.<String>get(Constant.DELETE_ITEMS)
                .params("ID", id)
                .params("sessionId", session)
                .execute(new StringCallback() {
                    @Override
                    public void onSuccess(Response<String> response) {
                        String body = response.body();
                        DeleteResp dataResp = StringUtils.getDataFromString(body, DeleteResp.class);
                        handleDeleteResp(dataResp);
                    }
                });
        return true;
    }

    private void handleDeleteResp(DeleteResp dataResp) {
        deleteResp.setValue(dataResp);
    }

    public MutableLiveData<DeleteResp> getDeleteResp() {
        return deleteResp;
    }

}