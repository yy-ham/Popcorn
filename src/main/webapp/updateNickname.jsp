<%@page import="com.sist.dao.UserinfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String nickname=request.getParameter("nickname");
	int userno=Integer.parseInt(session.getAttribute("userno")+"");
	UserinfoDAO dao=UserinfoDAO.getInstance();
	int re=dao.updateNickname(userno, nickname);
	out.print(re);
%>