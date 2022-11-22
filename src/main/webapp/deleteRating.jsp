<%@page import="com.sist.vo.RatingVO"%>
<%@page import="com.sist.dao.RatingDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userno = Integer.parseInt(request.getParameter("userno"));
	int movieno = Integer.parseInt(request.getParameter("movieno"));
	
	System.out.println("ajax--delete-------");
	System.out.println("userno:"+userno);
	System.out.println("movieno:"+movieno);
	
	RatingDAO ratingdao = RatingDAO.getInstance();
	RatingVO ratingvo = ratingdao.findByUsernoAndMovieno(userno, movieno);
	System.out.println("ratingvo:"+ratingvo);
	
	int ratingno = ratingvo.getRatingno();
	System.out.println("ratingno:"+ratingno);
	
	int re = ratingdao.deleteRating(ratingno);
%>
<%= re %>