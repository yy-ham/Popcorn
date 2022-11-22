<%@page import="com.google.gson.Gson"%>
<%@page import="com.sist.vo.RatingVO"%>
<%@page import="com.sist.dao.RatingDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userno = Integer.parseInt(request.getParameter("userno"));
	int movieno = Integer.parseInt(request.getParameter("movieno"));

	System.out.println("userno:"+userno);
	System.out.println("movieno:"+movieno);
	
	RatingDAO ratingdao = RatingDAO.getInstance();
	RatingVO ratingvo;
	
	String re = "";
	
	if(ratingdao.findByUsernoAndMovieno(userno, movieno) != null){
		ratingvo = ratingdao.findByUsernoAndMovieno(userno, movieno);
		String ratingcontent = ratingvo.getRatingcontent();
		System.out.println("ratingvo:" + ratingvo);
		System.out.println("ratingcontent:" + ratingcontent);
		Gson gson = new Gson();
		re = gson.toJson(ratingcontent);
	}
%>
<%= re %>