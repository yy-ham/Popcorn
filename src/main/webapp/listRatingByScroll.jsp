<%@page import="com.google.gson.Gson"%>
<%@page import="com.sist.vo.MyPageRatingVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.dao.MyPageRatingDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("userno")!=null){
		int userno=Integer.parseInt(session.getAttribute("userno")+"");
		int end=Integer.parseInt(request.getParameter("end"));
		MyPageRatingDAO ratingdao=MyPageRatingDAO.getInstance();
		ArrayList<MyPageRatingVO> list_rating=ratingdao.findMyRating(userno,end-3,end);
		Gson gson=new Gson();
		String str=gson.toJson(list_rating);
		out.print(str);
	}else{
		response.sendRedirect("login.do");
	}
%>