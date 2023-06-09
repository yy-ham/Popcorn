package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sist.vo.BoardVO;
import com.sist.vo.MyPageRatingVO;
import com.sist.vo.UserinfoVO;

public class UserinfoDAO {
	private static UserinfoDAO dao;
	
	public static UserinfoDAO getInstance() {
		if(dao==null) {
			dao=new UserinfoDAO();
		}
		return dao;
	}
	private UserinfoDAO() {}
	
	public int checkLogin(String email,String password) {
		int userno=-1;
		String sql="select userno from userinfo where email='"+email+"' and pwd='"+password+"'";
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				userno=rs.getInt("userno");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}} 
			if(stmt!=null) {try {stmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return userno;
	}
	
	public UserinfoVO findByUserno(int userno){
		UserinfoVO u=null;
		String sql="select * from userinfo where userno="+userno;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				u=new UserinfoVO();
				u.setUserno(rs.getInt("userno"));
				u.setUsername(rs.getString("username"));
				u.setEmail(rs.getString("email"));
				u.setPwd(rs.getString("pwd"));
				u.setNickname(rs.getString("nickname"));
				u.setUserimg(rs.getString("userimg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}} 
			if(stmt!=null) {try {stmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return u;
	}
	
	public int checkEmail(String email_input){
		int re=-1;
		String sql="select count(email) from userinfo where email=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, email_input);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				re=rs.getInt(1);
				System.out.println("re:"+re);
				System.out.println("rs.getInt(1):"+rs.getInt(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}} 
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}
	
	public int getNextUserno() {
		int userno = 0;
		String sql = "select nvl(max(userno), 0)+1 from userinfo";
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
				userno = rs.getInt(1);
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
		
		return userno;
	}
	
	public int insertUserinfo(UserinfoVO u){
		String sql="insert into userinfo(userno,username,email,pwd,nickname,userimg) values(?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, u.getUserno());
			pstmt.setString(2, u.getUsername());
			pstmt.setString(3, u.getEmail());
			pstmt.setString(4, u.getPwd());
			pstmt.setString(5, u.getNickname());
			pstmt.setString(6, u.getUserimg());
			re=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}
	
	public int updateUserimg(int userno,String userimg){
		String sql="update userinfo set userimg=? where userno=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userimg);
			pstmt.setInt(2, userno);
			re=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}
	
	public int checkNickname(String nickname_input){
		int re=-1;
		String sql="select count(nickname) from userinfo where nickname=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, nickname_input);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				re=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}} 
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}
	
	public int updateNickname(int userno,String nickname){
		String sql="update userinfo set nickname=? where userno=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			pstmt.setInt(2, userno);
			re=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}
	
	public int checkPwd(int userno, String pwd_input){
		int re=-1;
		String sql="select pwd from userinfo where userno="+userno;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String correctPwd=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				correctPwd=rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}} 
			if(stmt!=null) {try {stmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		if(correctPwd.equals(pwd_input)) {
			re=1;
		}
		return re;
	}
	
	public int updatePwd(int userno,String pwd){
		String sql="update userinfo set pwd=? where userno=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setInt(2, userno);
			re=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}
	
	//비밀번호 재설정 전 이름, 이메일 입력. 해당 이름과 이메일로 검색된 레코드가 있을 경우 수정페이지로.
	public UserinfoVO searchPwd(String username, String email) {
		UserinfoVO userinfovo = null;
		String sql = "select * from userinfo where username = ? and email = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:/comp/env/mydb");
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userinfovo = new UserinfoVO();
				userinfovo.setUserno(rs.getInt("userno"));
				userinfovo.setUsername(rs.getString("username"));
				userinfovo.setEmail(rs.getString("email"));
				userinfovo.setPwd(rs.getString("pwd"));
				userinfovo.setNickname(rs.getString("nickname"));
				userinfovo.setUserimg(rs.getString("userimg"));
			}
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());
		}finally {
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
		return userinfovo;
	}
}
