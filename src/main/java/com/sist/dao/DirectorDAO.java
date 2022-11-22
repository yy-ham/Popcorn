package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.ActorCastVO;
import com.sist.vo.DirectorCastVO;
import com.sist.vo.DirectorVO;

public class DirectorDAO {
	//싱글톤 방식
	private static DirectorDAO dao;
	public static DirectorDAO getInstance() {
		if(dao == null) {
			dao = new DirectorDAO();
		}
		return dao;
	}
	private DirectorDAO() {
		
	}
	
	//directorno로 감독 정보 가져오기
	public DirectorVO findByDirectorno(int directorno) {
		DirectorVO d = null;
		String sql = "select * from director where directorno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, directorno);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				d = new DirectorVO();
				d.setDirectorno(rs.getInt("directorno"));
				d.setDirectorname(rs.getString("directorname"));
				d.setDirectorimg(rs.getString("directorimg"));
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
		return d;
	}
}
