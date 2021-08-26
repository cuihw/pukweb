package com.stuff.manage.ui.home;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.R;
import com.stuff.manage.data.model.AllDatas;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.ui.adapter.StuffAdapter;

import java.util.List;

public class HomeFragment extends Fragment {

    private HomeViewModel homeViewModel;

    private ListView listview;

    StuffAdapter adapter;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        homeViewModel =
                new ViewModelProvider(this).get(HomeViewModel.class);

        View root = inflater.inflate(R.layout.fragment_home, container, false);

        listview = root.findViewById(R.id.listview);

        homeViewModel.getAllDatas().observe(getViewLifecycleOwner(), new Observer<AllDatas>() {
            @Override
            public void onChanged(@Nullable AllDatas datas) {
                // textView.setText(s);
                updataListView(datas);
            }
        });

        initView();
        return root;
    }

    private void updataListView(AllDatas datas) {
        List<ItemData> data = datas.getData();
        adapter.setList(data);
    }

    private void initView() {
        adapter = new StuffAdapter(getContext());
        listview.setAdapter(adapter);
    }


}