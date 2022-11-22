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
import com.sist.vo.ActorVO;
import com.sist.vo.DirectorVO;

public class ActorDAO {
	//싱글톤 방식
	private static ActorDAO dao;
	public static ActorDAO getInstance() {
		if(dao == null) {
			dao = new ActorDAO();
		}
		return dao;
	}
	private ActorDAO() {
		
	}
	
	//actorno로 배우 정보 가져오기
	//directorno로 감독 정보 가져오기
		public ActorVO findByActorno(int actorno) {
			ActorVO a = null;
			String sql = "select * from actor where actorno = ?";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				Context context = new InitialContext();
				DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, actorno);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					a = new ActorVO();
					a.setActorno(rs.getInt("actorno"));
					a.setActorname(rs.getString("actorname"));
					a.setActorimg(rs.getString("actorimg"));
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
			return a;
		}
}
