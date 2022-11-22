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
import com.sist.vo.MovieRatingVO;
import com.sist.vo.MovieVO;

public class MovieRatingDAO {
	//싱글톤 방식
	private static MovieRatingDAO dao;
	public static MovieRatingDAO getInstance() {
		if(dao == null) {
			dao = new MovieRatingDAO();
		}
		return dao;
	}
	private MovieRatingDAO() {
		
	}
	
	//메인 페이지 - 좋아요 많이 받은 영화 top5
	public ArrayList<MovieRatingVO> listPopularMovie(){
		ArrayList<MovieRatingVO> list = new ArrayList<MovieRatingVO>();
		String sql = "select rownum, m.movieno, movietitle, poster, country, to_char(m.releasedate, 'yyyy') releaseyear "
				+ "from movie m, (select rownum rnum, A.* from "
				+ "(select m.movieno, count(*) from movie m, rating r "
				+ "where m.movieno = r.movieno and ratingcontent = 'good' "
				+ "group by m.movieno order by count(*) desc) A where rownum <= 5) B "
				+ "where m.movieno = B.movieno order by B.rnum";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieRatingVO mr = new MovieRatingVO();
				mr.setMovieno(rs.getInt("movieno"));
				mr.setMovietitle(rs.getString("movietitle"));
				mr.setPoster(rs.getString("poster"));
				mr.setRownum(rs.getInt("rownum"));
				mr.setReleaseyear(rs.getString("releaseyear"));
				mr.setCountry(rs.getString("country"));
				list.add(mr);
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
