<%@page import="com.google.gson.Gson"%>
<%@page import="com.sist.vo.ReviewVO"%>
<%@page import="com.sist.dao.ReviewDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userno = 0;
	int reviewno = Integer.parseInt(request.getParameter("reviewno"));
	if(request.getParameter("userno") != null){
		userno = Integer.parseInt(request.getParameter("userno"));
	}
	int movieno = Integer.parseInt(request.getParameter("movieno"));
	String reviewcontent = request.getParameter("reviewcontent");

	ReviewDAO reviewdao = ReviewDAO.getInstance();
	ReviewVO reviewvo = new ReviewVO();
	reviewvo.setReviewno(reviewno);
	reviewvo.setUserno(userno);
	reviewvo.setMovieno(movieno);
	reviewvo.setReviewcontent(reviewcontent);
	
	int re = reviewdao.insertReview(reviewvo);
%>
<%= re %>