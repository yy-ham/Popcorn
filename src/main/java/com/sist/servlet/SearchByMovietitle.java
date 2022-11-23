package com.sist.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sist.dao.MovieDAO;
import com.sist.vo.MovieVO;

/**
 * Servlet implementation class SearchByMovietitle
 */
@WebServlet("/SearchByMovietitle")
public class SearchByMovietitle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchByMovietitle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String movietitle=request.getParameter("movietitle");
		MovieDAO moviedao = MovieDAO.getInstance();
		ArrayList<MovieVO> list=moviedao.searchByMovietitle(movietitle);
		Gson gson = new Gson();
		String str=gson.toJson(list);
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(str);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
