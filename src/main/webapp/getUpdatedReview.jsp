<%@page import="com.sist.dao.MyPageReviewDAO"%>
<%@page import="com.sist.vo.MyPageReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	int reviewno=Integer.parseInt(request.getParameter("reviewno"));
	MyPageReviewVO reviewvo=new MyPageReviewVO();
	MyPageReviewDAO dao=MyPageReviewDAO.getInstance();
	reviewvo=dao.findByReviewno(reviewno);
	out.print(reviewvo.getReviewcontent());
%>