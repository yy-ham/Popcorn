package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardDAO;

public class InsertBoardAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardDAO boarddao= BoardDAO.getInstance();
		int boardno=boarddao.nextNo();
		request.setAttribute("boardno", boardno);

		int userno=Integer.parseInt(request.getParameter("userno"));
		request.setAttribute("userno", userno);
		String nickname=boarddao.getUserNickname(userno);
		request.setAttribute("nickname", nickname);
	
		return "insertBoard.jsp";
	}

}
