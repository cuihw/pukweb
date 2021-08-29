package com.stuff.manage.ui.detail;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.MainActivity;
import com.stuff.manage.R;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.ItemData;

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

        View delBtn = root.findViewById(R.id.del_btn);
        delBtn.setOnClickListener(v->{});

        View modifyBtn = root.findViewById(R.id.modify_btn);
        modifyBtn.setOnClickListener(v->{
            MainActivity activity = (MainActivity) getActivity();
            activity.goToDetailFragment(mItemData, Constant.ACTION_MODIFY_DATA);
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

        detailViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {


            }
        });
        return root;
    }
    ItemData mItemData;
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
        setAllEditable(!isShowData);
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