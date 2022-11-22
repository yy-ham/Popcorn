package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.ReviewRatingUserinfoVO;

public class ReviewRatingUserinfoDAO {
	//싱글톤
	private static ReviewRatingUserinfoDAO reviewratinguserinfodao;
	public static ReviewRatingUserinfoDAO getInstance() {
		if(reviewratinguserinfodao == null) {
			reviewratinguserinfodao = new ReviewRatingUserinfoDAO();
		}
		return reviewratinguserinfodao;
	}
	private ReviewRatingUserinfoDAO() {
		
	}
	
	//영화 상세 페이지 - 해당 영화 전체 리뷰 조회(최신순)
	public ArrayList<ReviewRatingUserinfoVO> findByMovieno(int movieno){
		ArrayList<ReviewRatingUserinfoVO> list = new ArrayList<ReviewRatingUserinfoVO>();
		String sql = "select nickname, userimg, A.* from userinfo u, "
				+ "(select rv.*, rt.ratingcontent "
				+ "from review rv left outer join rating rt "
				+ "on rv.movieno = rt.movieno and rv.userno = rt.userno "
				+ "where rv.movieno = ?) A "
				+ "where u.userno = A.userno order by reviewdate desc";
		ReviewRatingUserinfoVO rru = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movieno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rru = new ReviewRatingUserinfoVO();
				rru.setNickname(rs.getString("nickname"));
				rru.setUserimg(rs.getString("userimg"));
				rru.setReviewno(rs.getInt("reviewno"));
				rru.setUserno(rs.getInt("userno"));
				rru.setMovieno(rs.getInt("movieno"));
				rru.setReviewcontent(rs.getString("reviewcontent"));
				rru.setReviewdate(rs.getDate("reviewdate"));
				rru.setRatingcontent(rs.getString("ratingcontent"));
				list.add(rru);
			}
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		}
		
		return list;
	}
	
	public ReviewRatingUserinfoVO findByMovienoAndReviewno(int movieno, int reviewno){
		ReviewRatingUserinfoVO rru = null;
		String sql = "select nickname, userimg, A.* from userinfo u, "
				+ "(select rv.*, rt.ratingcontent "
				+ "from review rv left outer join rating rt "
				+ "on rv.movieno = rt.movieno and rv.userno = rt.userno "
				+ "where rv.movieno = ? and rv.reviewno = ?) A "
				+ "where u.userno = A.userno";
		ReviewRatingUserinfoVO reviewratinguserinfovo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movieno);
			pstmt.setInt(2, reviewno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewratinguserinfovo = new ReviewRatingUserinfoVO();
				reviewratinguserinfovo.setNickname(rs.getString("nickname"));
				reviewratinguserinfovo.setUserimg(rs.getString("userimg"));
				reviewratinguserinfovo.setReviewno(rs.getInt("reviewno"));
				reviewratinguserinfovo.setUserno(rs.getInt("userno"));
				reviewratinguserinfovo.setMovieno(rs.getInt("movieno"));
				reviewratinguserinfovo.setReviewcontent(rs.getString("reviewcontent"));
				reviewratinguserinfovo.setReviewdate(rs.getDate("reviewdate"));
				reviewratinguserinfovo.setRatingcontent(rs.getString("ratingcontent"));
			}
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		}
		
		return reviewratinguserinfovo;
	}
	
	
}
