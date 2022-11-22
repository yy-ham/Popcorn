<%@page import="com.sist.dao.MyPageRatingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userno=Integer.parseInt(session.getAttribute("userno")+"");
	MyPageRatingDAO ratingdao=MyPageRatingDAO.getInstance();
	int totalRecord=ratingdao.getTotalRecord(userno);
	out.print(totalRecord);
%>