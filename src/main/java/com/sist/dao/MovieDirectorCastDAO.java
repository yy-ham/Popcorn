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
import com.sist.vo.MovieDirectorCastVO;

public class MovieDirectorCastDAO {
	//싱글톤 방식
	private static MovieDirectorCastDAO dao;
	public static MovieDirectorCastDAO getInstance() {
		if(dao == null) {
			dao = new MovieDirectorCastDAO();
		}
		return dao;
	}
	private MovieDirectorCastDAO() {
		
	}
	
	//감독이 연출한 다른 영화 가져오기
	public ArrayList<MovieDirectorCastVO> findByDirectorno(int directorno){
		ArrayList<MovieDirectorCastVO> list = new ArrayList<MovieDirectorCastVO>();
		String sql = "select directorname, m.movieno, poster, movietitle, position, releasedate, genre "
				+ "from movie m, director d, cast c "
				+ "where m.movieno = c.movieno and d.directorno = c.directorno and "
				+ "d.directorno = ? order by releasedate desc";
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
			while(rs.next()) {
				MovieDirectorCastVO mdc = new MovieDirectorCastVO();
				mdc.setDirectorname(rs.getString("directorname"));
				mdc.setMovieno(rs.getInt("movieno"));
				mdc.setMovietitle(rs.getString("movietitle"));
				mdc.setPosition(rs.getString("position"));
				mdc.setReleasedate(rs.getDate("releasedate"));
				mdc.setGenre(rs.getString("genre"));
				mdc.setPoster(rs.getString("poster"));
				System.out.println(mdc);
				list.add(mdc);
			}
		} catch (Exception e) {
			System.out.println("error_:" + e.getMessage());
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
