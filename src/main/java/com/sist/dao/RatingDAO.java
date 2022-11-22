package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.RatingVO;
import com.sist.vo.ReviewVO;

public class RatingDAO {
	//싱글톤 방식
	private static RatingDAO ratingdao;
	public static RatingDAO getInstance() {
		if(ratingdao == null) {
			ratingdao = new RatingDAO();
		}
		return ratingdao;
	}
	private RatingDAO() {
		
	}
	
	
	//다음 ratingno 가져오기
	public int getNextRatingno() {
		int ratingno = 0;
		String sql = "select nvl(max(ratingno), 0)+1 from rating";
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
				ratingno = rs.getInt(1);
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
		
		return ratingno;
	}
	
	//평가 등록하기
	public int insertRating(RatingVO r) {
		int re = -1;
		String sql = "insert into rating(ratingno, userno, movieno, ratingcontent) values(?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, r.getRatingno());
			pstmt.setInt(2, r.getUserno());
			pstmt.setInt(3, r.getMovieno());
			pstmt.setString(4, r.getRatingcontent());
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
	
	
	//평가 삭제하기
	public int deleteRating(int ratingno) {
		int re = -1;
		String sql = "delete rating where ratingno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ratingno);
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
	
	//영화 상세 페이지 - 로그인 한 사람의 평가 가져오기
	public RatingVO findByUsernoAndMovieno(int userno, int movieno) {
		RatingVO ratingvo = null;
		String sql = "select * from rating where userno = ? and movieno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userno);
			pstmt.setInt(2, movieno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ratingvo = new RatingVO();
				ratingvo.setRatingno(rs.getInt("ratingno"));
				ratingvo.setUserno(rs.getInt("userno"));
				ratingvo.setMovieno(rs.getInt("movieno"));
				ratingvo.setRatingcontent(rs.getString("ratingcontent"));
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
		return ratingvo;
	}
	
}
