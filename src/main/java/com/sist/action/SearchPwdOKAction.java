package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.UserinfoDAO;
import com.sist.vo.UserinfoVO;

public class SearchPwdOKAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userno = Integer.parseInt(request.getParameter("userno"));
		String pwd = request.getParameter("pwd");
		String pwdRe = request.getParameter("pwdRe");
		System.out.println(pwd);
		System.out.println(pwdRe);
		System.out.println("userno:"+userno);
		
		UserinfoDAO userinfodao = UserinfoDAO.getInstance();
		int re = -1;
		if(pwd.equals(pwdRe)) {
			re = userinfodao.updatePwd(userno, pwd);
			return "mainPage.do";
		}else {
			return "searchPwdOk.jsp";
		}
		
		
		
	}

}
