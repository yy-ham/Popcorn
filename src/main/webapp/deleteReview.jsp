<%@page import="com.sist.vo.ReviewVO"%>
<%@page import="com.sist.dao.ReviewDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewno = Integer.parseInt(request.getParameter("reviewno"));
	System.out.println("reviewno:"+reviewno);	
	
	ReviewDAO reviewdao = ReviewDAO.getInstance();
	int re = reviewdao.deleteReview(reviewno);
%>
<%= re %>