<%@page import="com.sist.dao.UserinfoDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path=request.getRealPath("data");
MultipartRequest multi=new MultipartRequest(request, path, 1024*1024*5, "utf-8",
		new DefaultFileRenamePolicy());
String fname="";
if(multi.getFile("imgInput")!=null){
	fname=multi.getFile("imgInput").getName();
}

UserinfoDAO dao=UserinfoDAO.getInstance();
int userno=Integer.parseInt(session.getAttribute("userno")+"");
int re=dao.updateUserimg(userno, fname);
out.print(re);
%>