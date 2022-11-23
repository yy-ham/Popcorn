<%@page import="com.sist.dao.UserinfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email=request.getParameter("email");
	UserinfoDAO dao=UserinfoDAO.getInstance();
	int re=dao.checkEmail(email);
	out.print(re);
%>