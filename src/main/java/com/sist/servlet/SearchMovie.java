package com.sist.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sist.dao.BoardDAO;
import com.sist.vo.BoardVO;
import com.sist.vo.PageVO;

/**
 * Servlet implementation class SearchMovie
 */
@WebServlet("/SearchMovie")
public class SearchMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchMovie() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		
		int pageno=1;
		if(request.getParameter("pageno")!=null&&!(request.getParameter("pageno")).equals("")) {
			pageno = Integer.parseInt(request.getParameter("pageno"));
		}
		int prev=pageno-1;
		int next=pageno+1;
		
		String category="boardtitle";
		switch(request.getParameter("category")) {
		case "제목":category="boardtitle";break;
		case "내용":category="boardcontent";break;
		case "작성자":category="nickname";
		}
		String search=request.getParameter("searchBoard");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("no", pageno+"");
		map.put("category", category);
		map.put("searchBoard", search);
		BoardDAO boarddao = BoardDAO.getInstance();
		
		
		ArrayList<BoardVO> list =boarddao.listAll(map);
		int cnt=list.size();
		int total_page=BoardDAO.total_page;
		PageVO pagevo = new PageVO(pageno, prev, next, total_page,cnt);
		Gson gson = new Gson();
		String gson_list=gson.toJson(list);
		String gson_pagevo=gson.toJson(pagevo);
		String str="";
		if(cnt>0) {
			gson_list=gson_list.replace("]",",");
			str=gson_list+gson_pagevo+"]";
		}else {
			str=gson_pagevo;
		}
		
		PrintWriter out = response.getWriter();
		out.print(str);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
