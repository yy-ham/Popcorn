package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.UserinfoDAO;
import com.sist.vo.UserinfoVO;

public class DetailUserinfoAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		//로그인 정보 없을 경우
		if(session.getAttribute("userno")==null) {
			//로그인 페이지로 보내기
			return "login.do";
		}else {
			//세션에서 userno 가져오기
			int userno=Integer.parseInt(session.getAttribute("userno")+"");
			//dao로 userinfo 불러오기
			UserinfoDAO userinfodao=UserinfoDAO.getInstance();
			UserinfoVO userinfovo=userinfodao.findByUserno(userno);
			request.setAttribute("userinfovo", userinfovo);
			request.setAttribute("re_img", request.getAttribute("re_img"));
			
			return "detailUserinfo.jsp";
		}
	}

}
