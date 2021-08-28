package com.stuff.manage.ui.add;

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

import com.stuff.manage.R;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.tools.StringUtils;

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

        addViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                // textView.setText(s);
            }
        });
        add_btn.setOnClickListener(v->{
            addItem();
        });
        return root;
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
    }

    private void notifyError(String message) {
        Toast.makeText(getContext(), message, Toast.LENGTH_SHORT).show();
    }


}