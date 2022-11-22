package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.MovieDAO;
import com.sist.dao.ReviewDAO;
import com.sist.dao.ReviewRatingUserinfoDAO;
import com.sist.vo.MovieVO;
import com.sist.vo.ReviewRatingUserinfoVO;
import com.sist.vo.ReviewVO;

public class DetailReviewAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reviewno = 0;
		if(request.getParameter("reviewno") != null) {
			reviewno = Integer.parseInt(request.getParameter("reviewno"));
		}
		int movieno = 0;
		if(request.getParameter("movieno") != null) {
			movieno = Integer.parseInt(request.getParameter("movieno"));
		}
		
		ReviewRatingUserinfoDAO reviewratinguserinfodao = ReviewRatingUserinfoDAO.getInstance();
		ReviewRatingUserinfoVO reviewratinguserinfovo = reviewratinguserinfodao.findByMovienoAndReviewno(movieno, reviewno);
		request.setAttribute("reviewrating", reviewratinguserinfovo);
		
		MovieDAO moviedao = MovieDAO.getInstance();
		MovieVO movievo = moviedao.findByMovieno(movieno);
		request.setAttribute("movie", movievo);
		
		return "detailReview.jsp";
	}

}
