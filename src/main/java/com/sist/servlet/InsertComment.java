package com.sist.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.dao.BoardCommentDAO;
import com.sist.vo.BoardCommentVO;

/**
 * Servlet implementation class InsertComment
 */
@WebServlet("/InsertComment")
public class InsertComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertComment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardCommentno = BoardCommentDAO.nextNo();
		int boardno= Integer.parseInt(request.getParameter("boardno"));
		int userno=1;
		/*HttpSession session=request.getSession();
		(int)session.getAttribute("userno");*/
		String boardCommentContent = request.getParameter("boardCommentContent");
		
		BoardCommentVO boardcommentvo = new BoardCommentVO();
		boardcommentvo.setBoardcommentno(boardCommentno);
		boardcommentvo.setBoardno(boardno);
		boardcommentvo.setUserno(userno);
		boardcommentvo.setBoardcommentcontent(boardCommentContent);
		BoardCommentDAO boardcommentdao = BoardCommentDAO.getInstance();
		int re=boardcommentdao.insertBoardComment(boardcommentvo);
		
		response.setContentType("text/plain;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.print(re);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
