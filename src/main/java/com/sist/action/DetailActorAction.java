package com.sist.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.ActorDAO;
import com.sist.dao.MovieActorCastDAO;
import com.sist.vo.ActorVO;
import com.sist.vo.MovieActorCastVO;

public class DetailActorAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//배우가 출연한 다른 영화 가져오기
		int actorno = 0;
		if(request.getParameter("actorno") != null) {
			actorno = Integer.parseInt(request.getParameter("actorno"));
		}
		MovieActorCastDAO movieactorcastdao = MovieActorCastDAO.getInstance();
		ArrayList<MovieActorCastVO> actor_movie = movieactorcastdao.findByActorno(actorno);
		request.setAttribute("actor_movie", actor_movie);
		
		//배우 정보 가져오기
		ActorDAO actordao = ActorDAO.getInstance();
		ActorVO actorvo = actordao.findByActorno(actorno);
		request.setAttribute("actorvo", actorvo);
		
		return "detailActor.jsp";
	}

}
