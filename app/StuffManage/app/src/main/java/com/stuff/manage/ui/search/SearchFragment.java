package com.stuff.manage.ui.search;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.MainActivity;
import com.stuff.manage.R;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.data.model.SearchResultData;
import com.stuff.manage.tools.ToastT;
import com.stuff.manage.ui.adapter.StuffAdapter;

import java.util.List;

public class SearchFragment extends Fragment {

    private SearchViewModel searchViewModel;
    private EditText searchText;

    private TextView totalText;

    private ListView searchResult;
    private String TAG = "SearchFragment";

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        searchViewModel =
                new ViewModelProvider(this).get(SearchViewModel.class);
        View root = inflater.inflate(R.layout.fragment_search, container, false);
        totalText = root.findViewById(R.id.search_result_total);
        searchText = root.findViewById(R.id.search_text);
        searchResult = root.findViewById(R.id.search_result);

        final Button searchBtn = root.findViewById(R.id.search_btn);
        searchBtn.setOnClickListener(v->{searchRequest();});

        searchViewModel.getResultData().observe(getViewLifecycleOwner(), new Observer<SearchResultData>() {
            @Override
            public void onChanged(SearchResultData searchResultData) {
                handleSearchResult(searchResultData);
            }
        });
        initListView();
        return root;
    }
    StuffAdapter adapter;

    private void initListView() {
        adapter = new StuffAdapter(getContext());
        searchResult.setAdapter(adapter);
        searchResult.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                detailData(position);
            }
        });
    }

    private void detailData(int position) {
        Log.d(TAG, "detail data");
        MainActivity activity = (MainActivity) getActivity();

        ItemData itemData = getItemData(position);
        if (itemData == null) return;
        activity.goToDetailFragment(itemData, Constant.ACTION_SHOW_DATA);
    }

    private ItemData getItemData(int position) {
        return adapter.getItem(position);
    }

    private void handleSearchResult(SearchResultData searchResultData) {
        if (!searchResultData.isOK()) {
            ToastT.show(getContext(), searchResultData.getMessage());
            return;
        }

        if (searchResultData.getTotal() == 0) {
            ToastT.show(getContext(), "没有搜索到数据。");
            return;
        }
        List<ItemData> data = searchResultData.getData();

        adapter.setList(data);

        totalText.setText("一共搜索到：" + searchResultData.getTotal());
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