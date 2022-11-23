package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.ActorCastVO;
import com.sist.vo.MovieActorCastVO;
import com.sist.vo.MovieDirectorCastVO;
import com.sist.vo.MovieVO;

public class MovieDAO {
	//싱글톤 방식
	private static MovieDAO moviedao;
	public static MovieDAO getInstance() {
		if(moviedao == null) {
			moviedao = new MovieDAO();
		}
		return moviedao;
	}
	private MovieDAO() {
		
	}
	
	//메인 페이지 - 영화 메인 이미지 가져오기
	public String getMainimg(int movieno) {
		String mainimg = "";
		String sql = "select mainimg from movie where movieno = ?";
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
				mainimg = rs.getString(1);
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
		return mainimg;
	}

	//메인 페이지 - 영화 검색하기
	/*public ArrayList<MovieVO> searchMovie(String keyword){
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		String sql = "select movieno, poster, movietitle from movie where movietitle like '%"+keyword+"%'";
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
				MovieVO m = new MovieVO();
				m.setMovieno(rs.getInt("movieno"));
				m.setPoster(rs.getString("poster"));
				m.setMovietitle(rs.getString("movietitle"));
				list.add(m);
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
	*/
	
	public ArrayList<MovieVO> searchByMovietitle(String movietitle) {
		ArrayList<MovieVO> list=null;
		String sql="select * from movie where movietitle like '%"+movietitle+"%'";
		Connection conn =null;
		Statement stmt=null;
		ResultSet rs = null;
		try {
			list= new ArrayList<MovieVO>();
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				MovieVO movievo = new MovieVO();
				movievo.setMovieno(rs.getInt("movieno"));
				movievo.setMovietitle(rs.getString("movietitle"));
				movievo.setGenre(rs.getString("genre"));
				movievo.setCountry(rs.getString("country"));
				movievo.setRunningtime(rs.getInt("runningtime"));
				movievo.setReleasedate(rs.getDate("releasedate"));
				movievo.setAgelimit(rs.getString("agelimit"));
				movievo.setStory(rs.getString("story"));
				movievo.setPoster(rs.getString("poster"));
				list.add(movievo);
			}
			
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(stmt!=null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		return list;
		
	}
	
	
	//영화 메인 페이지 - 자동 추천 검색어
	public ArrayList<String> searchMovietitle(String keyword){
		System.out.println("dao_keyword:"+keyword);
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select movietitle from movie where movietitle like '%"+keyword+"%'";
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
				String movietitle = rs.getString("movietitle");
				System.out.println("movietitle:"+movietitle);
				list.add(movietitle);
			}
		} catch (Exception e) {
			System.out.println("error1:" + e.getMessage());
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
	
	//메인 페이지 - 최신영화 top 5
	public ArrayList<MovieVO> listLatestMovie(){
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		String sql = "select rownum, movieno, poster, movietitle, to_char(releasedate, 'yyyy') releaseyear, country "
				+ "from (select movieno, poster, movietitle, releasedate, country "
				+ "from movie order by releasedate desc) where rownum <= 5";
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
				MovieVO m = new MovieVO();
				m.setMovieno(rs.getInt("movieno"));
				m.setPoster(rs.getString("poster"));
				m.setMovietitle(rs.getString("movietitle"));
				m.setReleaseyear(rs.getString("releaseyear"));
				m.setCountry(rs.getString("country"));
				list.add(m);
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
	
	//메인 페이지 - 영화제 수상작 top5
	public ArrayList<MovieVO> listAwardWinningMovie(HashMap<Integer, Integer> movieno){
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		String sql = "select movieno, poster, movietitle, to_char(releasedate, 'yyyy') releaseyear, country "
				+ "from movie where movieno = ? or movieno = ? or movieno = ? "
				+ "or movieno = ? or movieno = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movieno.get(1));
			pstmt.setInt(2, movieno.get(2));
			pstmt.setInt(3, movieno.get(3));
			pstmt.setInt(4, movieno.get(4));
			pstmt.setInt(5, movieno.get(5));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieVO m = new MovieVO();
				m.setMovieno(rs.getInt("movieno"));
				m.setPoster(rs.getString("poster"));
				m.setMovietitle(rs.getString("movietitle"));
				m.setReleaseyear(rs.getString("releaseyear"));
				m.setCountry(rs.getString("country"));
				list.add(m);
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
	
	//영화 상세 페이지 - 영화 상세 정보 가져오기
	public MovieVO findByMovieno(int movieno) {
		MovieVO m = null;
		String sql = "select * from movie where movieno = ?";
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
				m = new MovieVO();
				m.setMovieno(rs.getInt("movieno"));
				m.setMovietitle(rs.getString("movietitle"));
				m.setGenre(rs.getString("genre"));
				m.setCountry(rs.getString("country"));
				m.setRunningtime(rs.getInt("runningtime"));
				m.setReleasedate(rs.getDate("releasedate"));
				m.setAgelimit(rs.getString("agelimit"));
				m.setStory(rs.getString("story"));
				m.setPoster(rs.getString("poster"));
				m.setMainimg(rs.getString("mainimg"));
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
		
		return m;
	}


	
	
}
