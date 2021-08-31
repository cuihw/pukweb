package com.stuff.manage.ui.detail;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.MainActivity;
import com.stuff.manage.R;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.ActResponse;
import com.stuff.manage.data.model.DeleteResp;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.tools.StringUtils;
import com.stuff.manage.tools.ToastT;

public class DetailFragment extends Fragment {

    private static final String TAG = "DetailFragment";
    private DetailViewModel detailViewModel;
    private boolean isShowData;

    private EditText cname;
    private EditText ename;
    private EditText casno;
    private EditText mformula;
    private EditText mweight;
    private EditText place;
    private EditText buyer;
    private EditText other;
    private EditText identify;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        detailViewModel =
                new ViewModelProvider(this).get(DetailViewModel.class);
        View root = inflater.inflate(R.layout.fragment_detail, container, false);
        detailBtnLayout = root.findViewById(R.id.detail_btn_layout);
        modifyBtnLayout = root.findViewById(R.id.modify_btn_layout);

        // confirm_btn 确认修改
        View confirmBtn = root.findViewById(R.id.confirm_btn);
        confirmBtn.setOnClickListener(view->confirmModifyItemData());


        // cancel_btn
        View cancelBtn = root.findViewById(R.id.cancel_btn);
        cancelBtn.setOnClickListener(v->goHomeFragment(false));

        View delBtn = root.findViewById(R.id.del_btn);
        delBtn.setOnClickListener(v->{
            // 删除后退出此页面.
            deleteItemData();
        });

        // modify data
        View modifyBtn = root.findViewById(R.id.modify_btn);
        modifyBtn.setOnClickListener(v->{
            MainActivity activity = (MainActivity) getActivity();
            activity.goToDetailFragment(mItemData, Constant.ACTION_MODIFY_DATA);
        });

        detailViewModel.getmActResponse().observe(getViewLifecycleOwner(), new Observer<ActResponse>() {
            @Override
            public void onChanged(ActResponse actResponse) {
                ToastT.show(getContext(),actResponse.getMessage());
                if (actResponse.isOk()) {
                    goHomeFragment(true);
                } else if (actResponse.getMessage().contains("not login")) {
                    goLogin();
                }
            }
        });

        cname = root.findViewById(R.id.cname);
        ename = root.findViewById(R.id.ename);
        casno = root.findViewById(R.id.casno);
        mweight = root.findViewById(R.id.mweight);
        mformula = root.findViewById(R.id.mformula);
        place = root.findViewById(R.id.place);
        buyer = root.findViewById(R.id.buyer);
        other = root.findViewById(R.id.other);
        identify = root.findViewById(R.id.identify);



        detailViewModel.getmDeleteResp().observe(getViewLifecycleOwner(), new Observer<DeleteResp>() {
            @Override
            public void onChanged(@Nullable DeleteResp s) {

                ToastT.show(getContext(),s.getMessage());
                if (s.isOk()) {
                    goHomeFragment(true);
                } else if (s.getMessage().contains("not login")) {
                    goLogin();
                }
            }
        });
        return root;
    }

    private void confirmModifyItemData() {

        String cnameStr = cname.getText().toString();
        if (TextUtils.isEmpty(cnameStr) ) {
            notifyError("中文名不能为空");
            return;
        }

        String enameStr = ename.getText().toString();
        if (TextUtils.isEmpty(enameStr) ) {
            notifyError("英文名不能为空");
            return;
        }

        String casnoStr = casno.getText().toString();

        if (TextUtils.isEmpty(casnoStr) ) {
            notifyError("CAS NO 不能为空");
            return;
        }

        String mformulaStr = mformula.getText().toString();
        String mweightStr = mweight.getText().toString();
        if (TextUtils.isEmpty(mweightStr)) {
            notifyError("分子量不能空");
            return;
        }

        if (!StringUtils.isPureDigital(mweightStr)) {
            notifyError("分子量必须是正整数");
            return;
        }

        String placeStr = place.getText().toString();
        if (TextUtils.isEmpty(placeStr)) {
            notifyError("存放地点不能为空");
            return;
        }
        String buyerStr = buyer.getText().toString();
        String otherStr = other.getText().toString();

        if ( StringUtils.isEqual(mItemData.getBuyer(),  buyerStr)
                && StringUtils.isEqual(mItemData.getCname(),  cnameStr)
                && StringUtils.isEqual(mItemData.getEname(),  enameStr)
                && StringUtils.isEqual(mItemData.getCasno(),  casnoStr)
                && StringUtils.isEqual(mItemData.getMformula(),  mformulaStr)
                && StringUtils.isEqual(mItemData.getMweight(),  mweightStr)
                && StringUtils.isEqual(mItemData.getPlace(),  placeStr)
                && StringUtils.isEqual(mItemData.getOther(),  otherStr) ) {
            notifyError("没有改动，不修改。");
            return;
        }

        mItemData.setCname(cnameStr);
        mItemData.setEname(enameStr);
        mItemData.setCasno(casnoStr);
        mItemData.setMformula(mformulaStr);
        mItemData.setMweight(mweightStr);
        mItemData.setPlace(placeStr);
        mItemData.setBuyer(buyerStr);
        mItemData.setOther(otherStr);

        detailViewModel.upDateItemdata(mItemData);

    }

    private void notifyError(String message) {
        ToastT.show(getContext(), message);
    }

    private void goLogin() {
        MainActivity act = (MainActivity)getActivity();
        act.goToLoginActivity();
    }

    private Dialog mAlertdialog;

    private void deleteItemData() {
        // 弹出对话框，确认删除
        AlertDialog.Builder alertdialogbuilder = new AlertDialog.Builder(getContext());
        alertdialogbuilder.setTitle("确认删除");
        alertdialogbuilder.setMessage("是否确认删除此条记录？");
        alertdialogbuilder.setPositiveButton("是", new DialogInterface.OnClickListener(){

            @Override
            public void onClick(DialogInterface dialog, int which) {
                mAlertdialog.dismiss();
                if(!detailViewModel.deleteItemData(mItemData)) {
                    // 没有登录，转登录界面。
                    ToastT.show(getContext(),"Please login");
                    goLogin();
                }
            }
        });
        alertdialogbuilder.setNeutralButton("取消", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                mAlertdialog.dismiss();
            }
        });
        mAlertdialog = alertdialogbuilder.create();
        mAlertdialog.show();
    }

    private void goHomeFragment(boolean b){
        // go to Main fragment.
        MainActivity activity = (MainActivity) getActivity();
        boolean isfreshData = true;
        activity.goToMainFragment(isfreshData);
    }

    ItemData mItemData;

    LinearLayout detailBtnLayout;  // detail_btn_layout
    LinearLayout modifyBtnLayout;  // modify_btn_layout

    @Override
    public void onStart() {
        super.onStart();
        Log.d(TAG, "isShowData: " + isShowData);
        Bundle arguments = getArguments();
        String itemDataStr = arguments.getString("ItemData");
        Log.d(TAG, "ItemData: " + itemDataStr);
        if (TextUtils.isEmpty(itemDataStr)) {
            Toast.makeText(getContext(), "显示数据详情出错！", Toast.LENGTH_LONG).show();
            getParentFragmentManager().popBackStack();
            return;
        }

        mItemData = ItemData.getObjectStr(itemDataStr);

        int action = arguments.getInt("action");

        if (action == Constant.ACTION_SHOW_DATA) {
            isShowData = true;
            detailBtnLayout.setVisibility(View.VISIBLE);
            modifyBtnLayout.setVisibility(View.GONE);
        } else  {
            detailBtnLayout.setVisibility(View.GONE);
            modifyBtnLayout.setVisibility(View.VISIBLE);
        }
        setEditText(mItemData);


    }

    private void setEditText(ItemData itemData) {
        identify.setText(itemData.getID()+ "");
        cname.setText(itemData.getCname());
        ename.setText(itemData.getEname());
        casno.setText(itemData.getCasno());
        mformula.setText(itemData.getMformula());
        mweight.setText(itemData.getMweight());
        place.setText(itemData.getPlace());
        buyer.setText(itemData.getBuyer());
        other.setText(itemData.getOther());
        if(isShowData) setAllEditable(false);
    }

    private void setAllEditable(boolean editable) {
        setEditable(cname, editable) ;
        setEditable(ename, editable) ;
        setEditable(casno, editable) ;
        setEditable(mformula, editable) ;
        setEditable(mweight, editable) ;
        setEditable(place, editable) ;
        setEditable(buyer, editable) ;
        setEditable(other, editable) ;
    }

    private void  setEditable(EditText editText, boolean isEditable) {
        editText.setEnabled(isEditable);
        editText.setFocusable(isEditable);
    }

    private void clearEditText() {
        cname.setText("");
        ename.setText("");
        casno.setText("");
        mformula.setText("");
        mweight.setText("");
        place.setText("");
        buyer.setText("");
        other.setText("");
    }
}