package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.DirectorCastDAO;
import com.sist.dao.DirectorDAO;
import com.sist.dao.MovieActorCastDAO;
import com.sist.dao.MovieDirectorCastDAO;
import com.sist.vo.DirectorCastVO;
import com.sist.vo.DirectorVO;
import com.sist.vo.MovieActorCastVO;
import com.sist.vo.MovieDirectorCastVO;

public class DetailDirectorAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//감독이 연출한 다른 영화 가져오기
		int directorno = 0;
		if(request.getParameter("directorno") != null) {
			directorno = Integer.parseInt(request.getParameter("directorno"));
		}
		MovieDirectorCastDAO moviedirectorcastdao = MovieDirectorCastDAO.getInstance();
		ArrayList<MovieDirectorCastVO> direcotr_movie = moviedirectorcastdao.findByDirectorno(directorno);
		request.setAttribute("director_movie", direcotr_movie);
		
		//감독 번호, 감독 이름 가져오기
		DirectorDAO directordao = DirectorDAO.getInstance();
		DirectorVO directorvo = directordao.findByDirectorno(directorno);
		request.setAttribute("directorvo", directorvo);
		
		
		return "detailDirector.jsp";
	}

}
