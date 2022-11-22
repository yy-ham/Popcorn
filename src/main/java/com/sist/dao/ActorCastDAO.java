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

public class ActorCastDAO {
	//싱글톤 방식
	private static ActorCastDAO dao;
	public static ActorCastDAO getInstance() {
		if(dao == null) {
			dao = new ActorCastDAO();
		}
		return dao;
	}
	private ActorCastDAO() {
		
	}
	
	//영화 상세 페이지 - 배우 정보 가져오기
	public ArrayList<ActorCastVO> findBymovieno(int movieno) {
		ArrayList<ActorCastVO> list = new ArrayList<ActorCastVO>();
		String sql = "select a.actorno, actorname, actorimg, c.movieno, position, role "
				+ "from actor a, cast c "
				+ "where a.actorno = c.actorno and c.movieno = ?";
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
				ActorCastVO ac = new ActorCastVO();
				ac.setActorno(rs.getInt("actorno"));
				ac.setActorname(rs.getString("actorname"));
				ac.setActorimg(rs.getString("actorimg"));
				ac.setMovieno(rs.getInt("movieno"));
				ac.setPosition(rs.getString("position"));
				ac.setRole(rs.getString("role"));
				list.add(ac);
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
		return list;
	}
}
