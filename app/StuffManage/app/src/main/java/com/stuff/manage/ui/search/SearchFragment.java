package com.stuff.manage.ui.search;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.R;
import com.stuff.manage.tools.ToastT;

public class SearchFragment extends Fragment {

    private SearchViewModel searchViewModel;
    private EditText searchText;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        searchViewModel =
                new ViewModelProvider(this).get(SearchViewModel.class);
        View root = inflater.inflate(R.layout.fragment_search, container, false);
        final TextView textView = root.findViewById(R.id.search_result_total);
        searchText = root.findViewById(R.id.search_text);

        final Button searchBtn = root.findViewById(R.id.search_btn);
        searchBtn.setOnClickListener(v->{searchRequest();});

        searchViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        return root;
    }

    private void searchRequest() {
        String sKey = searchText.getText().toString();
        if (TextUtils.isEmpty(sKey)) {
            ToastT.show(getContext(), "搜索关键字不能为空.");
            return;
        }

        if (!searchViewModel.searchRequest(sKey)) {
            ToastT.show(getContext(), "没有登录.");
        }
    }
}