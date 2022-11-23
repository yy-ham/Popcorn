package com.sist.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardDAO;
import com.sist.vo.BoardVO;

/**
 * Servlet implementation class InsertBoard
 */
@WebServlet("/InsertBoard")
public class InsertBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertBoard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardno=Integer.parseInt(request.getParameter("boardno"));
		String boardtitle=request.getParameter("boardtitle");
		int userno=Integer.parseInt(request.getParameter("userno"));
		String boardcontent=request.getParameter("boardcontent");
		
		BoardVO boardvo = new BoardVO();
		boardvo.setBoardno(boardno);
		boardvo.setBoardtitle(boardtitle);
		boardvo.setUserno(userno);
		boardvo.setBoardview(0);
		boardvo.setBoardcontent(boardcontent);
		BoardDAO boarddao = BoardDAO.getInstance();
		int re=boarddao.insertBoard(boardvo);
		
		response.setContentType("text/plain");
		PrintWriter out=response.getWriter();
		out.print(re);
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
