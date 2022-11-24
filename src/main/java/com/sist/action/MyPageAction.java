package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.BoardDAO;
import com.sist.dao.MyPageRatingDAO;
import com.sist.dao.MyPageReviewDAO;
import com.sist.dao.UserinfoDAO;
import com.sist.vo.BoardVO;
import com.sist.vo.MyPageRatingVO;
import com.sist.vo.MyPageReviewVO;
import com.sist.vo.UserinfoVO;

public class MyPageAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션에서 userno 가져오기
		HttpSession session = request.getSession();
		//session.setAttribute("userno", 1);	//나중에 수정
		
		//로그인 정보 없을 경우
		if(session.getAttribute("userno")==null) {
			//로그인 페이지로 보내기
			return "login.jsp";
		}else {
			//세션에서 userno 가져오기
			int userno=Integer.parseInt(session.getAttribute("userno")+"");
		
			UserinfoDAO userinfodao=UserinfoDAO.getInstance();
			UserinfoVO userinfovo=userinfodao.findByUserno(userno);
			request.setAttribute("userinfovo", userinfovo);
			
			//내 평가 불러오기
			MyPageRatingDAO ratingdao=MyPageRatingDAO.getInstance();
			ArrayList<MyPageRatingVO> list_rating=ratingdao.findMyRating(userno,1,7);
			request.setAttribute("list_rating", list_rating);
			
			//내 리뷰 불러오기
			MyPageReviewDAO reviewdao=MyPageReviewDAO.getInstance();
			ArrayList<MyPageReviewVO> list_review=reviewdao.findMyReview(userno);
			request.setAttribute("list_review", list_review);
			
			//내 게시글 불러오기
			BoardDAO boarddao=BoardDAO.getInstance();
			ArrayList<BoardVO> list_board=boarddao.findMyBoard(userno,0);
			request.setAttribute("list_board", list_board);
			
			return "myPage.jsp";
		}
	}

}
