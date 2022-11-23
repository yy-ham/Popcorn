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
 * Servlet implementation class UpdateBoard
 */
@WebServlet("/UpdateBoard")
public class UpdateBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBoard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int re=-1;
		String boardtitle=request.getParameter("boardtitle");
		String boardcontent=request.getParameter("boardcontent");
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		BoardVO boardvo = new BoardVO();
		boardvo.setBoardtitle(boardtitle);
		boardvo.setBoardcontent(boardcontent);
		boardvo.setBoardno(boardno);
		BoardDAO boarddao = BoardDAO.getInstance();
		re=boarddao.updateBoard(boardvo);
		PrintWriter out= response.getWriter();
		response.setContentType("text/plain;charset=utf-8");
		out.print(re);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
