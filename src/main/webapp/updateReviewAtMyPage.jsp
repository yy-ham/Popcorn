<%@page import="com.sist.dao.ReviewDAO"%>
<%@page import="com.sist.dao.RatingDAO"%>
<%@page import="com.sist.vo.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int reviewno=Integer.parseInt(request.getParameter("reviewno"));
	String reviewcontent=request.getParameter("reviewcontent");
	ReviewVO reviewvo=new ReviewVO();
	reviewvo.setReviewno(reviewno);
	reviewvo.setReviewcontent(reviewcontent);
	ReviewDAO reviewdao=ReviewDAO.getInstance();
	out.print(reviewdao.updateReview(reviewvo));
%>