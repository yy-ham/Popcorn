package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.ActorCastDAO;
import com.sist.dao.DirectorCastDAO;
import com.sist.dao.MovieDAO;
import com.sist.dao.ReviewDAO;
import com.sist.dao.ReviewRatingUserinfoDAO;
import com.sist.vo.ActorCastVO;
import com.sist.vo.DirectorCastVO;
import com.sist.vo.MovieVO;
import com.sist.vo.ReviewRatingUserinfoVO;

public class DetailMovieAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//영화 상세 페이지 - 영화 정보 불러오기
		int movieno = 0;
		if(request.getParameter("movieno") != null) {
			movieno = Integer.parseInt(request.getParameter("movieno"));
		}
		MovieDAO moviedao = MovieDAO.getInstance();
		MovieVO movievo = moviedao.findByMovieno(movieno);
		request.setAttribute("movievo", movievo);
		
		
		//영화 상세 페이지 - 감독 정보 불러오기
		DirectorCastDAO directorcastdao = DirectorCastDAO.getInstance();
		DirectorCastVO directorcastvo = directorcastdao.findBymovieno(movieno);
		request.setAttribute("directorcastvo", directorcastvo);
		
		//영화 상세 페이지 - 배우 정보 불러오기
		ActorCastDAO actorcastdao = ActorCastDAO.getInstance();
		ArrayList<ActorCastVO> actor_list = actorcastdao.findBymovieno(movieno);
		request.setAttribute("actor_list", actor_list);
		
		//영화 상세 페이지 - 리뷰 불러오기
		ReviewRatingUserinfoDAO reviewratinguserinfodao = ReviewRatingUserinfoDAO.getInstance();
		ArrayList<ReviewRatingUserinfoVO> review_list = reviewratinguserinfodao.findByMovieno(movieno);
		request.setAttribute("review_list", review_list);
		
		//리뷰 등록 시 다음 reviewno 가져오기
		ReviewDAO reviewdao = ReviewDAO.getInstance();
		int nextReviewno = reviewdao.getNextReviewno();
		request.setAttribute("nextReviewno", nextReviewno);
		System.out.println("nextReviewno:" + nextReviewno);
		
		
		
		return "detailMovie.jsp";
	}

}
