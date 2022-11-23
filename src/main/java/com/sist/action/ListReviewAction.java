package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.ReviewRatingUserinfoDAO;
import com.sist.vo.ReviewRatingUserinfoVO;

public class ListReviewAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int movieno = 0;
		if(request.getParameter("movieno") != null) {
			movieno = Integer.parseInt(request.getParameter("movieno"));
		}
		ReviewRatingUserinfoDAO reviewratinguserinfodao = ReviewRatingUserinfoDAO.getInstance();
		ArrayList<ReviewRatingUserinfoVO> review_list = reviewratinguserinfodao.findByMovieno(movieno);
		request.setAttribute("review_list", review_list);
		request.setAttribute("movieno", movieno);
		
		return "listReview.jsp";
	}

}
