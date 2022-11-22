<%@page import="com.sist.dao.UserinfoDAO"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pwd_input=request.getParameter("pwd_input");
	int userno=Integer.parseInt(session.getAttribute("userno")+"");
	UserinfoDAO dao=UserinfoDAO.getInstance();
	int re=dao.checkPwd(userno, pwd_input);
	out.print(re);
%>