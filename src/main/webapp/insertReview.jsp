<%@page import="com.google.gson.Gson"%>
<%@page import="com.sist.vo.ReviewVO"%>
<%@page import="com.sist.dao.ReviewDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ReviewDAO reviewdao = ReviewDAO.getInstance();
	int userno = 0;
	int reviewno = 0;
	
	if(request.getParameter("userno") != null){
		userno = Integer.parseInt(request.getParameter("userno"));
	}
	if(request.getParameter("reviewno") != null){
		reviewno = Integer.parseInt(request.getParameter("reviewno"));
	}else{
		reviewno = reviewdao.getNextReviewno();
	}
	
	int movieno = Integer.parseInt(request.getParameter("movieno"));
	String reviewcontent = request.getParameter("reviewcontent");

	ReviewVO reviewvo = new ReviewVO();
	reviewvo.setReviewno(reviewno);
	reviewvo.setUserno(userno);
	reviewvo.setMovieno(movieno);
	reviewvo.setReviewcontent(reviewcontent);
	
	int re = reviewdao.insertReview(reviewvo);
%>
<%= re %>