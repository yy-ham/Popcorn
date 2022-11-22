<%@page import="com.google.gson.Gson"%>
<%@page import="com.sist.vo.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.dao.BoardDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userno=Integer.parseInt(session.getAttribute("userno")+"");
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	
	BoardDAO boarddao=BoardDAO.getInstance();
	ArrayList<BoardVO> list_board=boarddao.findMyBoard(userno,pageNum);
	
	Gson gson=new Gson();
	String str=gson.toJson(list_board);
	out.print(str);
%>