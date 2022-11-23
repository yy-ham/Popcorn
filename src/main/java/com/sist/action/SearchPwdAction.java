package com.sist.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.UserinfoDAO;
import com.sist.vo.UserinfoVO;

public class SearchPwdAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		
		UserinfoDAO userinfodao = UserinfoDAO.getInstance();
		UserinfoVO userinfovo = userinfodao.searchPwd(username, email);

		//해당 이름이랑 이메일로 가입된 회원정보가 있어야 비밀번호 재설정 페이지로 넘어가기
		if(userinfovo != null) {
			request.setAttribute("userinfovo", userinfovo);
			System.out.println("yes");
			return "searchPwdOk.jsp";
		}else {
			System.out.println("no");
			return "searchPwd.jsp";
		}
		
	}

}
