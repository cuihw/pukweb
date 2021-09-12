package com.stuff.manage.ui.admin;

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
import com.stuff.manage.data.LoginRepository;
import com.stuff.manage.data.model.ActResponse;
import com.stuff.manage.tools.ToastT;

public class AdminFragment extends Fragment {

    private AdminViewModel AdminViewModel;
    private Button confirm; // confirm_btn

    private EditText oldPassword;
    private EditText newPassword;
    private EditText newPassword1;

    TextView usertextView;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        AdminViewModel =
                new ViewModelProvider(this).get(AdminViewModel.class);
        View root = inflater.inflate(R.layout.fragment_admin, container, false);
        usertextView = root.findViewById(R.id.name);

        oldPassword = root.findViewById(R.id.old_password);
        newPassword = root.findViewById(R.id.new_password);
        newPassword1 = root.findViewById(R.id.new_password1);

        confirm = root.findViewById(R.id.confirm_btn);
        confirm.setOnClickListener(v->{changePassword();});
        AdminViewModel.getActResponse().observe(getViewLifecycleOwner(), new Observer<ActResponse>() {
            @Override
            public void onChanged(ActResponse actResponse) {
                upDateResult(actResponse);
            }
        });

        AdminViewModel.getUsername().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                usertextView.setText(s);
            }
        });
        return root;
    }

    @Override
    public void onStart() {
        super.onStart();

        if (!isLogin()) {
            goToLogin();
            return;
        }
        usertextView.setText("用户： " + displayName);
    }

    private void goToLogin() {
        ToastT.show(getContext(), "you are not login");
        MainActivity act = (MainActivity) getActivity();
        act.goToLoginActivity();
    }
    private void goToMain() {
        MainActivity act = (MainActivity) getActivity();
        act.goToMainFragment(false);
    }
    private void upDateResult(ActResponse actResponse) {
        if (actResponse.isOk()) {
            ToastT.show(getContext(),"修改成功");
            goToMain();
        }
        ToastT.show(getContext(),"修改失败");
    }

    String sessionId;
    String displayName;
    private boolean isLogin() {
        LoginRepository repo = LoginRepository.getInstance();

        if (repo == null) return false;

        if (!repo.isLoggedIn()) return false;
        sessionId = repo.getUser().getSessionId();

        if (TextUtils.isEmpty(sessionId)) return false;
        displayName = repo.getUser().getDisplayName();

        if (TextUtils.isEmpty(displayName)) return false;

        return true;
    }

    private void changePassword() {
        String oldStr = oldPassword.getText().toString();

        if (TextUtils.isEmpty(oldStr)) {
            ToastT.show(getContext(), "老密码不能为空");
            return;
        }
        String newStr = newPassword.getText().toString();
        if (TextUtils.isEmpty(newStr)) {
            ToastT.show(getContext(), "密码不能为空");
            return;
        }
        if (TextUtils.equals(oldStr, newStr)) {
            ToastT.show(getContext(), "新老密码不能相同");
            return;
        }

        String newStr1 = newPassword1.getText().toString();
        if (!TextUtils.equals(newStr1, newStr)) {
            ToastT.show(getContext(), "新密码不相同");
            return;
        }


        AdminViewModel.changePassword(displayName,sessionId, oldStr, newStr);
    }
}