package com.sist.action;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

public class SearchMovieResultAction implements SistAction {
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		int userno=(Integer)session.getAttribute("userno");
		request.setAttribute("userno", userno);
		
		String keyword=request.getParameter("keyword");
		request.setAttribute("keyword", keyword);
		
		
		
		return "searchMovieResult.jsp";
	}

}
