package com.stuff.manage.ui.home;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.MainActivity;
import com.stuff.manage.R;
import com.stuff.manage.data.CacheData;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.AllDatas;
import com.stuff.manage.data.model.DeleteResp;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.ui.adapter.StuffAdapter;
import com.stuff.manage.ui.login.LoginActivity;

import java.util.List;

public class HomeFragment extends Fragment {

    private static final String TAG = "HomeFragment";
    private HomeViewModel homeViewModel;

    private ListView listview;

    StuffAdapter adapter;

    private static final int ACTION_MODIFY = 1;
    private static final int ACTION_DELETE = 2;
    private static final int ACTION_DETAIL = 3;

    private static int sMenuPosition = 0;

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
        homeViewModel.getDeleteResp().observe(getViewLifecycleOwner(), new Observer<DeleteResp>() {
            @Override
            public void onChanged(DeleteResp deleteResp) {
                handleDeleteResp(deleteResp);
            }
        });


        initView();
        return root;
    }

    private void handleDeleteResp(DeleteResp deleteResp) {
        if (deleteResp.isOk()) {
            Toast.makeText(getContext(),"delete OK", Toast.LENGTH_SHORT);
            homeViewModel.getAllData();
            return;
        } else {
            if (deleteResp.getMessage().contains("not login")) {
                // go to login activity.
                Toast.makeText(getContext(),deleteResp.getMessage(), Toast.LENGTH_SHORT);

                Intent intent=new Intent(getContext(), LoginActivity.class);
                intent.putExtra(Constant.CLEAR_LOGIN_DATA, true);
                startActivity(intent);
                getActivity().finish();
            }
        }
    }

    private void updataListView(AllDatas datas) {
        List<ItemData> data = datas.getData();
        adapter.setList(data);
    }

    private void initView() {
        adapter = new StuffAdapter(getContext());
        listview.setAdapter(adapter);

        listview.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {
                Log.d(TAG, "position: " + position);
                sMenuPosition = position;
                return false;
            }
        });

        listview.setOnCreateContextMenuListener(new View.OnCreateContextMenuListener() {
            @Override
            public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
                //add(int groupId, int itemId, int order, CharSequence title);
                int groupId = 0;
                menu.add(groupId, ACTION_MODIFY, 1,"修改");
                menu.add(groupId, ACTION_DELETE, 1,"删除");
                menu.add(groupId, ACTION_DETAIL, 1,"查看详情");
            }
        });
    }

    @Override
    public boolean onContextItemSelected(@NonNull MenuItem item) {
        int itemId = item.getItemId();
        Log.d(TAG, "itemId: " + itemId);
        // homeViewModel  sMenuPosition

        switch (itemId) {
            case ACTION_MODIFY:
                modifyData(sMenuPosition);
                break;
            case ACTION_DELETE:
                deleteData(sMenuPosition);
                break;
            case ACTION_DETAIL:
                detailData(sMenuPosition);
                break;
        }
        return super.onContextItemSelected(item);
    }

    private void detailData(int position) {

        Toast.makeText(getContext(), "detailData", Toast.LENGTH_SHORT).show();
    }

    private void modifyData(int position) {
        Toast.makeText(getContext(), "modifyData", Toast.LENGTH_SHORT).show();
    }

    private void deleteData(int position) {

        Toast.makeText(getContext(), "deleteData", Toast.LENGTH_SHORT).show();
        if (CacheData.cAllDatas == null) return;
        if (CacheData.cAllDatas.getData() == null) return;
        if (CacheData.cAllDatas.getData().size() <= position) return;

        ItemData itemData = CacheData.cAllDatas.getData().get(position);
        homeViewModel.deleteItem(itemData.getID());
    }
}