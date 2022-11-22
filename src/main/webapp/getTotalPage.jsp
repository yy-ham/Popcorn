<%@page import="com.sist.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userno=Integer.parseInt(session.getAttribute("userno")+"");
	BoardDAO dao=BoardDAO.getInstance();
	int totalPage=dao.getTotalPage(userno);
	out.print(totalPage);
%>