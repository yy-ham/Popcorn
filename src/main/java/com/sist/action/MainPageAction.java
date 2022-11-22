package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.MovieDAO;
import com.sist.dao.MovieRatingDAO;
import com.sist.vo.MovieRatingVO;
import com.sist.vo.MovieVO;

public class MainPageAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//메인 페이지 - 메인 이미지 불러오기
		Random r = new Random();
		int mainimg_movieno = r.nextInt(9) + 1;
		System.out.println("mainimg_movieno: " + mainimg_movieno);
		
		MovieDAO moviedao = MovieDAO.getInstance();
		String mainimg = moviedao.getMainimg(mainimg_movieno);
		System.out.println("mainimg: " + mainimg);
		
		request.setAttribute("mainimg_movieno", mainimg_movieno);
		request.setAttribute("mainimg", mainimg);
		
		//메인 페이지 - 최신영화 top5 가져오기
		ArrayList<MovieVO> latestMovie_list = moviedao.listLatestMovie();
		request.setAttribute("latestMovie_list", latestMovie_list);
		
		//메인 페이지 - 좋아요 많이 받은 영화 top5 가져오기
		MovieRatingDAO movieratingdao = MovieRatingDAO.getInstance();
		ArrayList<MovieRatingVO> popularMovie_list = movieratingdao.listPopularMovie();
		request.setAttribute("popularMovie_list", popularMovie_list);
		
		//메인 페이지 - 영화제 수상작 가져오기
		HashMap<Integer, Integer> awardWinningMovie_map = new HashMap<Integer, Integer>();
		awardWinningMovie_map.put(1, 2);
		awardWinningMovie_map.put(2, 3);
		awardWinningMovie_map.put(3, 10);
		awardWinningMovie_map.put(4, 1);
		awardWinningMovie_map.put(5, 6);
		ArrayList<MovieVO> awardWinningMovie_list = moviedao.listAwardWinningMovie(awardWinningMovie_map);
		request.setAttribute("awardWinningMovie_list", awardWinningMovie_list);
		
		return "mainPage.jsp";
	}

}
