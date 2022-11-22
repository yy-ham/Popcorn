<%@page import="com.sist.dao.UserinfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String nickname=request.getParameter("nickname");
	UserinfoDAO dao=UserinfoDAO.getInstance();
	int re=dao.checkNickname(nickname);
	out.print(re);
%>