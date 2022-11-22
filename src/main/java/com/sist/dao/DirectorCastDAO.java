package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.DirectorCastVO;

public class DirectorCastDAO {
	//싱글톤 방식
	private static DirectorCastDAO dao;
	public static DirectorCastDAO getInstance() {
		if(dao == null) {
			dao = new DirectorCastDAO();
		}
		return dao;
	}
	private DirectorCastDAO() {
		
	}
	
	//영화 상세 페이지 - 감독 정보 가져오기
	public DirectorCastVO findBymovieno(int movieno) {
		DirectorCastVO dc = null;
		String sql = "select d.directorno, directorname, directorimg, c.movieno, position "
				+ "from director d, cast c "
				+ "where d.directorno = c.directorno and c.movieno = ?";
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
			if(rs.next()) {
				dc = new DirectorCastVO();
				dc.setDirectorno(rs.getInt("directorno"));
				dc.setDirectorname(rs.getString("directorname"));
				dc.setDirectorimg(rs.getString("directorimg"));
				dc.setMovieno(rs.getInt("movieno"));
				dc.setPosition(rs.getString("position"));
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
		return dc;
	}
}
