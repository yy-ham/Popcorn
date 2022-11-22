package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.ReviewVO;

public class ReviewDAO {
	//싱글톤 방식
	private static ReviewDAO reviewdao;
	public static ReviewDAO getInstance() {
		if(reviewdao == null) {
			reviewdao = new ReviewDAO();
		}
		return reviewdao;
	}
	private ReviewDAO() {
		
	}
	
	
	//다음 reviewno 가져오기
	public int getNextReviewno() {
		int reviewno = 0;
		String sql = "select nvl(max(reviewno), 0)+1 from review";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewno = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return reviewno;
	}
	
	//reviewno로 리뷰 가져오기
	public ReviewVO findByReviewno(int reviewno) {
		ReviewVO reviewvo = null;
		String sql = "select * from review where reviewno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewvo = new ReviewVO();
				reviewvo.setReviewno(rs.getInt("reviewno"));
				reviewvo.setUserno(rs.getInt("userno"));
				reviewvo.setMovieno(rs.getInt("movieno"));
				reviewvo.setReviewcontent(rs.getString("reviewcontent"));
				reviewvo.setReviewdate(rs.getDate("reviewdate"));
			}
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return reviewvo;
	}
	
	
	//리뷰 등록하기
	public int insertReview(ReviewVO r) {
		int re = -1;
		String sql = "insert into review(reviewno, userno, movieno, reviewcontent) values(?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, r.getReviewno());
			pstmt.setInt(2, r.getUserno());
			pstmt.setInt(3, r.getMovieno());
			pstmt.setString(4, r.getReviewcontent());
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	//리뷰 수정하기
	public int updateReview(ReviewVO r) {
		int re = -1;
		String sql = "update review set reviewcontent = ? where reviewno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, r.getReviewcontent());
			pstmt.setInt(2, r.getReviewno());
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	//리뷰 삭제하기
	public int deleteReview(int reviewno) {
		int re = -1;
		String sql = "delete review where reviewno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewno);
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
}
