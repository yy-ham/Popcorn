package com.sist.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardCommentDAO;
import com.sist.vo.BoardCommentVO;
import com.sist.vo.BoardVO;

/**
 * Servlet implementation class UpdateComment
 */
@WebServlet("/UpdateComment")
public class UpdateComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateComment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int re=-1;
		
		int boardcommentno=Integer.parseInt(request.getParameter("boardcommentno"));
		String boardcommentcontent = request.getParameter("boardcommentcontent");
		
		BoardCommentVO boardcommentvo = new BoardCommentVO();
		boardcommentvo.setBoardcommentno(boardcommentno);
		boardcommentvo.setBoardcommentcontent(boardcommentcontent);
		
		BoardCommentDAO boardcommentdao = BoardCommentDAO.getInstance();
		re=boardcommentdao.updateBoardComment(boardcommentvo);
		
		response.setContentType("text/plain;charset=utf-8");
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
