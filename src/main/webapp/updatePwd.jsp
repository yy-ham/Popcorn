<%@page import="com.sist.dao.UserinfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pwd=request.getParameter("pwd");
	int userno=Integer.parseInt(session.getAttribute("userno")+"");
	UserinfoDAO dao=UserinfoDAO.getInstance();
	int re=dao.updatePwd(userno, pwd);
	out.print(re);
%>