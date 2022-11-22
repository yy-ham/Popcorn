<%@page import="com.sist.vo.RatingVO"%>
<%@page import="com.sist.dao.RatingDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//새로 등록할 거
	int userno = 0;
	if(request.getParameter("userno") != null){
		userno = Integer.parseInt(request.getParameter("userno"));
	}
	int movieno = Integer.parseInt(request.getParameter("movieno"));
	String ratingcontent = request.getParameter("ratingcontent");
	
	RatingDAO ratingdao = RatingDAO.getInstance();

	//해당 userno, movieno로 등록된 평가가 이미 있으면 해당 평가 삭제
	if(ratingdao.findByUsernoAndMovieno(userno, movieno) != null){
		RatingVO ratingvo_delete = new RatingVO();
		ratingvo_delete = ratingdao.findByUsernoAndMovieno(userno, movieno);
		System.out.println("insertRating.jsp_ratingvo:"+ratingvo_delete);
		int delete_ratingno = ratingvo_delete.getRatingno();
		int delete_result = ratingdao.deleteRating(delete_ratingno);
		System.out.println("삭제결과:"+delete_result);
	}
	
	
	
	//다음 ratingno 가져오기
	int ratingno = ratingdao.getNextRatingno();
	System.out.println("nextRatingno:"+ratingno);
	//평가 등록하기
	RatingVO ratingvo_insert = new RatingVO();
	ratingvo_insert.setRatingno(ratingno);
	ratingvo_insert.setUserno(userno);
	ratingvo_insert.setMovieno(movieno);
	ratingvo_insert.setRatingcontent(ratingcontent);
	
	int re = ratingdao.insertRating(ratingvo_insert); 
%>
<%= re %>