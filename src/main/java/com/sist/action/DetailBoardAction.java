package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardDAO;
import com.sist.vo.BoardVO;

public class DetailBoardAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int boardno=Integer.parseInt(request.getParameter("boardno"));
		BoardDAO boarddao= BoardDAO.getInstance();
		boarddao.updateBoardView(boardno);
		BoardVO boardvo=boarddao.findByBoardno(boardno);
		request.setAttribute("boardvo", boardvo);
		return "detailBoard.jsp";
		
	}
}
