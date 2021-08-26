package com.stuff.manage.ui.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.stuff.manage.R;
import com.stuff.manage.data.model.ItemData;

import java.util.List;

public class StuffAdapter extends BaseAdapter {

    List<ItemData> list;
    Context mContext;

    public StuffAdapter(Context context) {
        mContext = context;
    }
    @Override
    public int getCount() {
        if (list == null)  return 0;
        return list.size();
    }

    @Override
    public Object getItem(int position) {
        if (list == null)  return null;
        if (position > (getCount() -1)) return null;
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    class ViewHolder{
        TextView cname;
        TextView ename;
        TextView cas_no;
        TextView mformula;
        TextView place;
    }
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        View view;
        if (convertView == null) {
            view = LayoutInflater.from(mContext).inflate(R.layout.item_data_layout, parent, false);
            viewHolder = new ViewHolder();
            viewHolder.cname = (TextView) view.findViewById(R.id.cname);
            viewHolder.ename = (TextView) view.findViewById(R.id.ename);
            viewHolder.cas_no = (TextView) view.findViewById(R.id.cas_no);
            viewHolder.mformula = (TextView) view.findViewById(R.id.mformula);
            viewHolder.place = (TextView) view.findViewById(R.id.place);
            view.setTag(viewHolder);// 将ViewHolder存储在View中。
        } else {
            view = convertView;
            viewHolder = (ViewHolder) view.getTag(); //重新获取ViewHolder

        }

        ItemData data = (ItemData) getItem(position);
        if (data == null) {
            viewHolder.cname.setText("Empty data");
        } else  {
            viewHolder.cname.setText(data.getCname());
            viewHolder.ename.setText(data.getEname());
            viewHolder.cname.setText(data.getCname());
            viewHolder.cname.setText(data.getCname());
            viewHolder.cname.setText(data.getCname());
            viewHolder.cname.setText(data.getCname());
        }
        return view;
    }

    public List<ItemData> getList() {
        return list;
    }

    public void setList(List<ItemData> list) {
        this.list = list;
        notifyDataSetChanged();
    }
}
