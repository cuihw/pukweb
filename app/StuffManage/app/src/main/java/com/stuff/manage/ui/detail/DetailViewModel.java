package com.stuff.manage.ui.detail;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.data.model.ActResponse;
import com.stuff.manage.data.model.DeleteResp;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.tools.StringUtils;

public class DetailViewModel extends ViewModel {

    private MutableLiveData<DeleteResp> mDeleteResp;
    private MutableLiveData<ActResponse> mActResponse;

    public DetailViewModel() {
        mDeleteResp = new MutableLiveData<>();
        mActResponse = new MutableLiveData<>();
        // mText.setValue("This is admin fragment");
    }

    public LiveData<ActResponse> getmActResponse() {
        return mActResponse;
    }

    public LiveData<DeleteResp> getmDeleteResp() {
        return mDeleteResp;
    }

    public boolean deleteItemData(ItemData itemData) {
        return deleteItem(itemData.getID());
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
        mDeleteResp.setValue(dataResp);
    }

    public boolean upDateItemdata(ItemData mItemData) {
        LoginRepository repo = LoginRepository.getInstance();
        if(repo == null) return false;

        String session = repo.getUser().getSessionId();

        OkGo.<String>get(Constant.UPDATE_ITEMS)
                .params("ID", mItemData.getID())
                .params("sessionId", session)
                .params("ename", mItemData.getEname())
                .params("casno", mItemData.getCasno())
                .params("mformula", mItemData.getMformula())
                .params("mweight", mItemData.getMweight())
                .params("place", mItemData.getPlace())
                .params("buyer", mItemData.getBuyer())
                .params("other", mItemData.getOther())
                .execute(new StringCallback(){
                    @Override
                    public void onSuccess(Response<String> response) {
                        String body = response.body();
                        ActResponse dataAct = StringUtils.getDataFromString(body, ActResponse.class);
                        mActResponse.setValue(dataAct);
                    }
                });



        return true;
    }
}