package com.yangshan;


import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hspcadmin on 2016-11-23.
 */
public class SearchServlet extends HttpServlet {
    static List<String> datas = new ArrayList<String>();
    static {

        datas.add("jemas");
        datas.add("apple");
        datas.add("ajax");
        datas.add("bellis");
        datas.add("balana");
        datas.add("cmill");
        datas.add("clpopl");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String keyword = request.getParameter("keyword");
        //获得关键字之后进行处理，得到关联数据
        List<String> listdata = getData(keyword);
        response.getWriter().write(JSONArray.fromObject(listdata).toString());

    }
    public List<String> getData(String keyword){

        List<String> list = new ArrayList<String>();
        for (String data:datas)
            if (data.contains(keyword)){
                list.add(data);
            }
        return list;
    }
}
