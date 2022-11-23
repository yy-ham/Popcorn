package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.BoardCommentVO;
import com.sist.vo.BoardVO;

public class BoardCommentDAO {
	
	private static BoardCommentDAO dao;
	public static BoardCommentDAO getInstance() {
		if(dao==null) {
			dao=new BoardCommentDAO();
		}
		return dao;
	}
	
	private BoardCommentDAO() {}
	
	public int updateBoardComment(BoardCommentVO vo) {
		String sql="update boardcomment set boardcommentcontent=?, boardcommentdate=default where boardcommentno=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,vo.getBoardcommentcontent());
			pstmt.setInt(2, vo.getBoardcommentno());
			re=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally{
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	public int deleteBoardComment(int boardcommentno) {
		String sql="delete boardcomment where boardcommentno="+boardcommentno;
		Connection conn =null;
		Statement stmt=null;
		ResultSet rs=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			re=stmt.executeUpdate(sql);
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(stmt!=null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	
	
	public static int nextNo() {
		String sql="select nvl(max(boardcommentno),0)+1 from boardcomment"; 
		Connection conn =null;
		Statement stmt=null;
		ResultSet rs=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				re=rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(stmt!=null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	public int insertBoardComment(BoardCommentVO boardcommentvo) {
		String sql="insert into boardcomment(boardcommentno,boardno,userno,boardcommentcontent,boardcommentdate) values(?,?,?,?,default)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, boardcommentvo.getBoardcommentno());
			pstmt.setInt(2, boardcommentvo.getBoardno());
			pstmt.setInt(3, boardcommentvo.getUserno());
			pstmt.setString(4, boardcommentvo.getBoardcommentcontent());
			re=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally{
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	public ArrayList<BoardCommentVO>findByBoardno(int boardno){
		ArrayList<BoardCommentVO> list =null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select boardcommentno, b.userno, boardcommentcontent, nickname, boardcommentdate from boardcomment b, userinfo u where b.userno=u.userno and boardno=?";
		try {
			list = new ArrayList<BoardCommentVO>();
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardCommentVO boardcommentvo= new BoardCommentVO();
				boardcommentvo.setBoardcommentno(rs.getInt("boardcommentno"));
				boardcommentvo.setUserno(rs.getInt("userno"));
				boardcommentvo.setBoardcommentcontent(rs.getString("boardcommentcontent"));
				boardcommentvo.setNickname(rs.getString("nickname"));
				boardcommentvo.setBoardcommentdate(rs.getDate("boardcommentdate")+"");
				list.add(boardcommentvo);
			}
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	
}
