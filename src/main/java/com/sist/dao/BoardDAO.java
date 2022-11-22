package com.sist.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.BoardVO;
import com.sist.vo.MyPageRatingVO;

public class BoardDAO {
	private static BoardDAO dao;
	
	public static BoardDAO getInstance() {
		if(dao==null) {
			dao=new BoardDAO();
		}
		return dao;
	}
	private BoardDAO() {}
	
	public static int pageSIZE=3;
	public static int totalRecord=0;
	
	public int getTotalRecord(int userno) {
		String sql="select count(boardno) from board where userno="+userno;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int totalRecord=-1;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				totalRecord=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}} 
			if(stmt!=null) {try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
			if(conn!=null) {try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
		}
		return totalRecord;
	}
	
	public int getTotalPage(int userno) {
		int totalPage=(int)Math.ceil((double)getTotalRecord(userno)/pageSIZE);
		return totalPage;
	}
	
	//마이페이지에서 보이는 내가 쓴 게시글(제목, 날짜, 내용 일부만)
	public ArrayList<BoardVO> findMyBoard(int userno, int pageNum){
		String sql="";
		ArrayList<BoardVO> list=new ArrayList<>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		if(pageNum>0) {
			totalRecord=getTotalRecord(userno);
			int start=(pageNum-1)*pageSIZE+1;
			int end=pageNum*pageSIZE;
			sql="select * from (select rownum r,board.* from board where userno="+userno+" order by boardno) where r between "+start+" and "+end;
		}else {
			sql="select * from board where userno="+userno+" order by boardno";
		}

		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO b=new BoardVO();
				b.setBoardno(rs.getInt("boardno"));
				b.setBoardtitle(rs.getString("boardtitle"));
				b.setBoarddate(rs.getDate("boarddate")+"");
				b.setBoardcontent(rs.getString("boardcontent"));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}} 
			if(stmt!=null) {try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
			if(conn!=null) {try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
		}
		return list;
	}
	
	//마이페이지에서 더보기 눌렀을 때 보이는 게시글(게시글 전체 칼럼)
	/*
	public ArrayList<BoardVO> findMyBoardDetail(int userno){
		ArrayList<BoardVO> list=new ArrayList<>();
		String sql="select * from board where userno="+userno;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO b=new BoardVO();
				b.setBoardno(rs.getInt("boardno"));
				b.setBoardtitle(rs.getString("boardtitle"));
				b.setBoarddate(rs.getDate("boarddate")+"");
				b.setBoardview(rs.getInt("boardview"));
				b.setBoardcontent(rs.getString("boardcontent"));
				b.setBoardfile(rs.getString("boardfile"));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}} 
			if(stmt!=null) {try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
			if(conn!=null) {try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
		}
		return list;
	}*/
}
