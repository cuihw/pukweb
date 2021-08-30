package com.stuff.manage.tools;

import android.content.Context;
import android.view.Gravity;
import android.widget.Toast;

public class ToastT {

    public static void show(Context c, String msg) {
        Toast toast = Toast.makeText(c, msg, Toast.LENGTH_LONG);
        toast.setGravity(Gravity.CENTER, 0, 0);
        toast.show();
    }

    public static void show(Context c, int msg) {
        Toast toast = Toast.makeText(c, msg, Toast.LENGTH_LONG);
        toast.setGravity(Gravity.CENTER, 0, 0);
        toast.show();
    }

}
