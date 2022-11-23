package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.sist.dao.BoardDAO;
import com.sist.vo.BoardVO;

public class ListBoardAction implements SistAction {
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageno=1;
		
		if(request.getParameter("pageno")!=null&&!(request.getParameter("pageno")).equals("")) {
			pageno = Integer.parseInt(request.getParameter("pageno"));
		}
		
		BoardDAO boarddao = BoardDAO.getInstance();
		int prev=pageno-1;
		int next=pageno+1;
		if(prev>1) {
			request.setAttribute("prev", prev);
		}
		if(next<=BoardDAO.total_page) {
			request.setAttribute("next", next);
		}
		
		String category="";
		if(request.getParameter("category")!=null&&!(request.getParameter("category")).equals("")) {
			category="boardtitle";
			switch(request.getParameter("category")) {
			case "제목":category="boardtitle";break;
			case "내용":category="boardcontent";break;
			case "작성자":category="nickname";
			}
		}
		request.setAttribute("category", category);

		String searchBoard="";
		if(request.getParameter("searchBoard")!=null&&!(request.getParameter("searchBoard")).equals("")) {
			searchBoard=request.getParameter("searchBoard");
		}
		request.setAttribute("searchBoard",searchBoard);
		
		
		/*System.out.println("no:"+pageno);
		System.out.println("category:"+category);
		System.out.println("searchBoard:"+searchBoard);*/
		
		HashMap<String, String> map= new HashMap<String, String>();
		map.put("no", pageno+"");
		map.put("category", category);
		map.put("searchBoard",searchBoard );
		
		ArrayList<BoardVO> list=boarddao.listAll(map);
		request.setAttribute("list", list);
		
		int total_page=BoardDAO.total_page;
		request.setAttribute("total_page",total_page);
		
		return "listBoard.jsp";
	}

}
