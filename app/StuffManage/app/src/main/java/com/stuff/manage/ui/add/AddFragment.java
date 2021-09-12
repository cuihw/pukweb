package com.stuff.manage.ui.add;

import android.app.AlertDialog;
import android.app.Notification;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
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
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.tools.StringUtils;
import com.stuff.manage.ui.login.LoginActivity;

//nav_add
public class AddFragment extends Fragment {

    private AddViewModel addViewModel;
    private ItemData itemData;
    private EditText cname;
    private EditText ename;
    private EditText casno;
    private EditText mformula;
    private EditText mweight;
    private EditText place;
    private EditText buyer;
    private EditText other;
    private Button add_btn;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        addViewModel =
                new ViewModelProvider(this).get(AddViewModel.class);

        View root = inflater.inflate(R.layout.fragment_add, container, false);

        cname = root.findViewById(R.id.cname);
        ename = root.findViewById(R.id.ename);
        casno = root.findViewById(R.id.casno);
        mweight = root.findViewById(R.id.mweight);
        mformula = root.findViewById(R.id.mformula);
        place = root.findViewById(R.id.place);
        buyer = root.findViewById(R.id.buyer);
        other = root.findViewById(R.id.other);

        add_btn = root.findViewById(R.id.add_btn);

        addViewModel.getActRespLiveData().observe(getViewLifecycleOwner(), new Observer<ActResponse>() {
            @Override
            public void onChanged(@Nullable ActResponse s) {
                // textView.setText(s);
                handlerActResponse(s);
            }
        });
        add_btn.setOnClickListener(v->{
            addItem();
        });
        return root;
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

    private void handlerActResponse(ActResponse s) {
        if (s.isOk()) {
            clearEditText();
            showDialog("添加成功，是否继续添加");
        } else {
            Toast.makeText(getContext(), s.getMessage(),Toast.LENGTH_LONG).show();
        }
    }

    private  AlertDialog alertdialog;
    private void showDialog(String message) {
        if (alertdialog != null ) {
            alertdialog.dismiss();
            alertdialog =  null;
        }

        AlertDialog.Builder alertdialogbuilder = new AlertDialog.Builder(getContext());
        alertdialogbuilder.setMessage(message);
        alertdialogbuilder.setPositiveButton("是", new DialogInterface.OnClickListener(){
            @Override
            public void onClick(DialogInterface dialog, int which) {
                alertdialog.dismiss();
            }
        });
        alertdialogbuilder.setNeutralButton("取消", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                alertdialog.dismiss();
                // go to Main fragment.
                MainActivity activity = (MainActivity) getActivity();
                boolean isfreshData = true;
                activity.goToMainFragment(isfreshData);
            }
        });
        alertdialog = alertdialogbuilder.create();
        alertdialog.show();
    }

    private void addItem() {
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

        /*cname;  ename; casno; mformula; mweight; place; buyer; other; */
        itemData = new ItemData();
        itemData.setCname(cnameStr);
        itemData.setEname(enameStr);
        itemData.setCasno(casnoStr);
        itemData.setMformula(mformulaStr);
        itemData.setMweight(mweightStr);
        itemData.setPlace(placeStr);
        itemData.setBuyer(buyerStr);
        itemData.setOther(otherStr);

        int ret = addViewModel.addNewItem(itemData);

        if (ret == Constant.NOT_LOGIN) {
            Toast.makeText(getContext(), "you are not login", Toast.LENGTH_LONG).show();
            MainActivity act = (MainActivity) getActivity();
            act.goToLoginActivity();
        }
    }

    private void notifyError(String message) {
        Toast.makeText(getContext(), message, Toast.LENGTH_SHORT).show();
    }


}