package com.stuff.manage.ui.detail;

import android.text.TextUtils;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.lzy.okgo.request.GetRequest;
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

        GetRequest<String> okGoRequest = OkGo.<String>get(Constant.UPDATE_ITEMS);
        okGoRequest.params("ID", mItemData.getID()).params("sessionId", session);
        if (!TextUtils.isEmpty(mItemData.getCname())) okGoRequest.params("cname", mItemData.getCname());
        if (!TextUtils.isEmpty(mItemData.getEname())) okGoRequest.params("ename", mItemData.getEname());
        if (!TextUtils.isEmpty(mItemData.getCasno())) okGoRequest.params("casno", mItemData.getCasno());
        if (!TextUtils.isEmpty(mItemData.getMformula())) okGoRequest.params("mformula", mItemData.getMformula());
        if (!TextUtils.isEmpty(mItemData.getMweight())) okGoRequest.params("mweight", mItemData.getMweight());
        if (!TextUtils.isEmpty(mItemData.getPlace())) okGoRequest.params("place", mItemData.getPlace());
        if (!TextUtils.isEmpty(mItemData.getBuyer())) okGoRequest.params("buyer", mItemData.getBuyer());
        if (!TextUtils.isEmpty(mItemData.getOther())) okGoRequest.params("other", mItemData.getOther());

        okGoRequest.execute(new StringCallback() {
                    @Override
                    public void onSuccess(Response<String> response) {
                        String body = response.body();
                        ActResponse dataAct = StringUtils.getDataFromString(body, ActResponse.class);
                        mActResponse.setValue(dataAct);
                    }

            @Override
            public void onError(Response<String> response) {
                super.onError(response);
                ActResponse resp = new ActResponse();
                resp.setRet("error"); resp.setMessage(" server error！");
                mActResponse.setValue(resp);
            }
        });
        return true;
    }
}