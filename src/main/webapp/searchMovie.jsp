<%@page import="com.google.gson.Gson"%>
<%@page import="com.sist.vo.MovieVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.dao.MovieDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String keyword = request.getParameter("keyword");
	System.out.println("keyword:"+keyword);
	
	ArrayList<MovieVO> list;
	Gson gson = new Gson();
	String str = "";
	
	//키워드가 있는 경우에만 dao 동작
		MovieDAO moviedao = MovieDAO.getInstance();
		list = moviedao.searchMovie(keyword);
		System.out.println("list:"+list);
		str = gson.toJson(list);
%>
<%= str %>