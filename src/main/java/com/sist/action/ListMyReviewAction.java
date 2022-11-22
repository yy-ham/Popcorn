package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.MyPageRatingDAO;
import com.sist.dao.MyPageReviewDAO;
import com.sist.vo.MyPageRatingVO;
import com.sist.vo.MyPageReviewVO;

public class ListMyReviewAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션에서 userno 가져오기
		HttpSession session = request.getSession();
		
		//로그인 정보 없을 경우
		if(session.getAttribute("userno")==null) {
			return "login.do";
		}else {
			int userno=Integer.parseInt(session.getAttribute("userno")+"");
			
			//내 리뷰 불러오기
			MyPageReviewDAO reviewdao=MyPageReviewDAO.getInstance();
			ArrayList<MyPageReviewVO> list_review=reviewdao.findMyReview(userno);
			request.setAttribute("list_review", list_review);
			
			return "listMyReview.jsp";
		}
	}

}
