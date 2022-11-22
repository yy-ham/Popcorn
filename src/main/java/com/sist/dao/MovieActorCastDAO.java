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
import com.sist.vo.MovieActorCastVO;
import com.sist.vo.MovieDirectorCastVO;

public class MovieActorCastDAO {
	//싱글톤 방식
	private static MovieActorCastDAO dao;
	public static MovieActorCastDAO getInstance() {
		if(dao == null) {
			dao = new MovieActorCastDAO();
		}
		return dao;
	}
	private MovieActorCastDAO() {
		
	}
	
	//배우가 출연한 다른 영화 가져오기
	public ArrayList<MovieActorCastVO> findByActorno(int actorno){
		ArrayList<MovieActorCastVO> list = new ArrayList<MovieActorCastVO>();
		String sql = "select actorname, m.movieno, poster, movietitle, position, role, releasedate, genre "
				+ "from movie m, actor a, cast c "
				+ "where m.movieno = c.movieno and a.actorno = c.actorno and "
				+ "a.actorno = ? order by releasedate desc";
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
			while(rs.next()) {
				MovieActorCastVO mac = new MovieActorCastVO();
				mac.setActorname(rs.getString("actorname"));
				mac.setMovieno(rs.getInt("movieno"));
				mac.setPoster(rs.getString("poster"));
				mac.setMovietitle(rs.getString("movietitle"));
				mac.setPosition(rs.getString("position"));
				mac.setRole(rs.getString("role"));
				mac.setReleasedate(rs.getDate("releasedate"));
				mac.setGenre(rs.getString("genre"));
				list.add(mac);
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
