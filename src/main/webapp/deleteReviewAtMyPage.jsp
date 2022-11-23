<%@page import="com.sist.dao.ReviewDAO"%>
<%@page import="com.sist.dao.RatingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int reviewno=Integer.parseInt(request.getParameter("userno"));
ReviewDAO dao=ReviewDAO.getInstance();
int re=dao.deleteReview(reviewno);
out.print(re);
%>