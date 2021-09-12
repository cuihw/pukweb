package com.stuff.manage;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.view.Menu;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
import com.google.android.material.navigation.NavigationView;
import com.stuff.manage.data.Constant;
import com.stuff.manage.data.model.ItemData;
import com.stuff.manage.ui.login.LoginActivity;

import androidx.annotation.NonNull;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "MainActivity";
    private AppBarConfiguration mAppBarConfiguration;

    private NavController navController;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        checkLogin();
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_home, R.id.nav_add, R.id.nav_search, R.id.nav_admin, R.id.nav_detail)
                .setDrawerLayout(drawer)
                .build();

        navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);

        drawer.addDrawerListener(new DrawerLayout.DrawerListener() {
            @Override
            public void onDrawerSlide(@NonNull View drawerView, float slideOffset) {

            }

            @Override
            public void onDrawerOpened(@NonNull View drawerView) {

            }

            @Override
            public void onDrawerClosed(@NonNull View drawerView) {

            }

            @Override
            public void onDrawerStateChanged(int newState) {

            }
        });

        getNavController();
    }

    private void checkLogin() {
        //http://localhost:60425/mmmmanage/chkloggedin_mm.asp?uid=wangbw&sessionId=7818c88d9dfdbfb7e19c77362f0e0820

    }

    public NavController getNavController() {
        // Log.d(TAG, "getNavController nav_add");
        // navController.navigate(R.id.nav_add);
        return navController;
    }


    @Override
    public boolean onSupportNavigateUp() {
        Log.d(TAG, "onSupportNavigateUp");
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration)
                || super.onSupportNavigateUp();
    }

    public void goToLoginActivity() {
        Intent intent=new Intent(this, LoginActivity.class);
        intent.putExtra(Constant.CLEAR_LOGIN_DATA, true);
        startActivity(intent);
        finish();
    }

    public void goToMainFragment(boolean isfreshData) {
        Bundle args = new Bundle();
        args.putBoolean("isfreshData", isfreshData);
        navController.navigate(R.id.nav_home);
    }

    public void goToDetailFragment(ItemData itemData, int actionShowData) {
        Bundle args = new Bundle();
        args.putString("ItemData", ItemData.toJsonString(itemData));
        args.putInt("action", actionShowData);
        navController.navigate(R.id.nav_detail, args);
    }


}