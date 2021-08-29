package com.stuff.manage.ui.admin;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.stuff.manage.R;

public class AdminFragment extends Fragment {

    private AdminViewModel AdminViewModel;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        AdminViewModel =
                new ViewModelProvider(this).get(AdminViewModel.class);
        View root = inflater.inflate(R.layout.fragment_admin, container, false);
        final TextView textView = root.findViewById(R.id.text_admin);
        AdminViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        return root;
    }
}