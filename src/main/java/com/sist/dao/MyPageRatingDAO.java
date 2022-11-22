package com.sist.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.MyPageRatingVO;

public class MyPageRatingDAO {
	private static MyPageRatingDAO dao;
	
	public static MyPageRatingDAO getInstance() {
		if(dao==null) {
			dao=new MyPageRatingDAO();
		}
		return dao;
	}
	private MyPageRatingDAO() {}
	
	public int getTotalRecord(int userno) {
		int totalRecord=-1;
		String sql="select count(*) from (select m.movieno, movietitle, ratingcontent from "
				+ "movie m, rating r, userinfo u where m.movieno=r.movieno and u.userno=r.userno "
				+ "and u.userno="+userno+")";
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
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
	
	public ArrayList<MyPageRatingVO> findMyRating(int userno, int start, int end){
		ArrayList<MyPageRatingVO> list=new ArrayList<>();
		String sql="select * from (select rownum r, m.movieno, movietitle, poster, ratingcontent "
				+ "from movie m, rating r, userinfo u where m.movieno=r.movieno and "
				+ "u.userno=r.userno and u.userno=1) A where r between "+start+" and "+end;
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
				MyPageRatingVO r=new MyPageRatingVO();
				r.setMovieno(rs.getInt("movieno"));
				r.setMovietitle(rs.getString("movietitle"));
				r.setPoster(rs.getString("poster"));
				r.setRatingcontent(rs.getString("ratingcontent"));
				list.add(r);
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
	
}
