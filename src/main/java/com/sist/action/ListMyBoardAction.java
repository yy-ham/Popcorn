package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.BoardDAO;
import com.sist.vo.BoardVO;

public class ListMyBoardAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
HttpSession session = request.getSession();
		
		//로그인 정보 없을 경우
		if(session.getAttribute("userno")==null) {
			//로그인 페이지로 보내기
			return "login.jsp";
		}else {
			//세션에서 userno 가져오기
			int userno=Integer.parseInt(session.getAttribute("userno")+"");
		
			//내 게시글 불러오기
			BoardDAO boarddao=BoardDAO.getInstance();
			ArrayList<BoardVO> list_board=boarddao.findMyBoard(userno,1);
			request.setAttribute("list_board", list_board);
			
			//페이지 수 불러오기
			request.setAttribute("totalPage", boarddao.getTotalPage(userno));
			
			return "listMyBoard.jsp";
		}
	}

}
