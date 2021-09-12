package com.stuff.manage.data;

public class Constant {

    public final static String SERVER_ADDRESS = "http://192.168.2.43/mmmmanage/";

    public static final int NOT_LOGIN = 100;

    public static final int SUCCESSED = 0;
    // mmmmanage/chklogin_mm.asp?uid=wangbw&password=mmm123
    // {"ret":"error","message":"Please input correctly username and password."}
    public final static String LOGIN = SERVER_ADDRESS + "chklogin_mm.asp";

    // get all
    public final static String GET_ALL_ITEMS = SERVER_ADDRESS + "displayup_mm.asp";

    // delete item
    public final static String DELETE_ITEMS = SERVER_ADDRESS + "delete_mm.asp";


    public final static String SHARE_NAME = "application";

    public static final String LOGIN_DATA = "login_data";


    public static final String CLEAR_LOGIN_DATA = "CLEAR_LOGIN_DATA";

    // add item
    public final static String ADD_ITEMS = SERVER_ADDRESS + "add_mm.asp";
    public final static String UPDATE_ITEMS = SERVER_ADDRESS + "reviseOK_mm.asp";

    public static final int ACTION_SHOW_DATA = 1;
    public static final int ACTION_MODIFY_DATA = 2;

    // search text
    public final static String SEARCH = SERVER_ADDRESS + "searchre_mm.asp";
    // change password
    public final static String CHANGE_PASSWORD = SERVER_ADDRESS + "adminpwd_mm.asp";

}
