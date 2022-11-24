package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.MyPageRatingDAO;
import com.sist.vo.MyPageRatingVO;

public class ListMyRatingAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		System.out.println("userno in ListMyRating after logout: "+session.getAttribute("userno"));
		
		//로그인 정보 없을 경우
		if(session.getAttribute("userno")==null) {
			//로그인 페이지로 보내기
			return "login.jsp";
		}else {
			//세션에서 userno 가져오기
			int userno=Integer.parseInt(session.getAttribute("userno")+"");
		
			//내 평가 불러오기
			MyPageRatingDAO ratingdao=MyPageRatingDAO.getInstance();
			ArrayList<MyPageRatingVO> list_rating=ratingdao.findMyRating(userno,1,4);
			request.setAttribute("list_rating", list_rating);
			
			return "listMyRating.jsp";
		}
	}
}
