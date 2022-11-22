package com.sist.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.MyPageReviewVO;

public class MyPageReviewDAO {
private static MyPageReviewDAO dao;
	
	public static MyPageReviewDAO getInstance() {
		if(dao==null) {
			dao=new MyPageReviewDAO();
		}
		return dao;
	}
	private MyPageReviewDAO() {}
	
	public ArrayList<MyPageReviewVO> findMyReview(int userno){
		ArrayList<MyPageReviewVO> list=new ArrayList<>();
		String sql="select A.movieno, movietitle, poster, reviewno, reviewcontent, reviewdate, ratingcontent from "
				+ "(select m.movieno, rv.userno, movietitle, poster, reviewno, reviewcontent, reviewdate "
				+ "from movie m, review rv "
				+ "where m.movieno=rv.movieno "
				+ "and userno="+userno+") A left outer join rating rt "
				+ "on A.movieno=rt.movieno and "
				+ "A.userno=rt.userno "
				+ "where A.userno="+userno;
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
				MyPageReviewVO r=new MyPageReviewVO();
				r.setMovieno(rs.getInt("movieno"));
				r.setMovietitle(rs.getString("movietitle"));
				r.setPoster(rs.getString("poster"));
				r.setReviewno(rs.getInt("reviewno"));
				r.setReviewcontent(rs.getString("reviewcontent"));
				r.setReviewdate(rs.getDate("reviewdate")+"");
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
	
	public MyPageReviewVO findByReviewno(int reviewno){
		MyPageReviewVO r=null;
		String sql="select A.movieno, movietitle, poster, reviewno, reviewcontent, reviewdate, ratingcontent from "
				+ "(select m.movieno, rv.userno, movietitle, poster, reviewno, reviewcontent, reviewdate "
				+ "from movie m, review rv "
				+ "where m.movieno=rv.movieno "
				+ "and reviewno="+reviewno+") A left outer join rating rt "
				+ "on A.movieno=rt.movieno and "
				+ "A.userno=rt.userno "
				+ "where A.reviewno="+reviewno;
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
				r=new MyPageReviewVO();
				r.setMovieno(rs.getInt("movieno"));
				r.setMovietitle(rs.getString("movietitle"));
				r.setPoster(rs.getString("poster"));
				r.setReviewno(rs.getInt("reviewno"));
				r.setReviewcontent(rs.getString("reviewcontent"));
				r.setReviewdate(rs.getDate("reviewdate")+"");
				r.setRatingcontent(rs.getString("ratingcontent"));
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
		return r;
	}
}
