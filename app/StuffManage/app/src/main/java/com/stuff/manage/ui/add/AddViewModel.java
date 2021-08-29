package com.stuff.manage.ui.add;

import android.text.TextUtils;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.lzy.okgo.OkGo;
import com.lzy.okgo.callback.StringCallback;
import com.lzy.okgo.model.Response;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.data.model.ActResponse;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.tools.StringUtils;

public class AddViewModel extends ViewModel {

    public static final int NOT_LOGIN = 100;
    public static final int SUCCESSED = 0;
    private MutableLiveData<ActResponse> ActRespLiveData;

    public AddViewModel() {
        ActRespLiveData = new MutableLiveData<>();
    }

    public LiveData<ActResponse> getActRespLiveData() {
        return ActRespLiveData;
    }

    //add_mm.asp?sessionId=fdt43w54543re43&cname="test"&ename="test1"&casno="casno1"
    //&mformula="mformula"&mweight=451&place="place1"&buyer="buyer"&other="other1"
    public int addNewItem(ItemData data) {
        LoginRepository repo = LoginRepository.getInstance();
        if (repo == null) return NOT_LOGIN;
        if (!repo.isLoggedIn()) return NOT_LOGIN;
        String sessionId = repo.getUser().getSessionId();
        if (TextUtils.isEmpty(sessionId)) return NOT_LOGIN;

        OkGo.<String>get(Constant.ADD_ITEMS).params("cname", data.getCname())
                .params("ename", data.getEname())
                .params("casno", data.getCasno())
                .params("mformula", data.getMformula())
                .params("mweight", data.getMweight())
                .params("place", data.getPlace())
                .params("buyer", data.getBuyer())
                .params("other", data.getOther())
                .params("sessionId", sessionId)
                .execute(new StringCallback() {
                    @Override
                    public void onSuccess(Response<String> response) {
                        String body = response.body();
                        ActResponse resp = StringUtils.getDataFromString(body, ActResponse.class);
                        notifyResult(resp);
                    }

                });

        return SUCCESSED;
    }

    private void notifyResult(ActResponse resp) {
        ActRespLiveData.setValue(resp);
    }

}