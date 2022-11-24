package com.sist.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.UserinfoDAO;

/**
 * Servlet implementation class LoginCheck
 */
@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain;charset=utf-8");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		UserinfoDAO dao= UserinfoDAO.getInstance();
		int userno=dao.checkLogin(email,password);
		if(userno>0) {
			HttpSession session=request.getSession();
			session.setAttribute("userno", userno);
		}
		PrintWriter out=response.getWriter();
		out.print(userno);
		out.close();
		System.out.println(userno);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/plain;charset=utf-8");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		UserinfoDAO dao= UserinfoDAO.getInstance();
		int userno=dao.checkLogin(email,password);
		if(userno>0) {
			HttpSession session=request.getSession();
			session.setAttribute("userno", userno);
			System.out.println("afsadf:"+userno);
		}
		PrintWriter out=response.getWriter();
		out.print(userno);
		out.close();
		System.out.println(userno);
	}

}
