package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.UserinfoDAO;
import com.sist.vo.UserinfoVO;

public class InsertUserinfoOKAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserinfoDAO dao=UserinfoDAO.getInstance();
		UserinfoVO u=new UserinfoVO();
		u.setUserno(dao.getNextUserno());
		System.out.println("nextuserno:"+dao.getNextUserno());
		u.setUsername(request.getParameter("username"));
		u.setEmail(request.getParameter("email"));
		u.setPwd(request.getParameter("pwd"));
		u.setNickname(request.getParameter("nickname"));
		
		int re=dao.insertUserinfo(u);
		String msg="";
		if(re==1) {
			msg="회원가입에 성공했습니다.";
		}else {
			msg="오류 발생";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", msg);
		
		return "insertUserinfoOK.jsp";
	}

}
