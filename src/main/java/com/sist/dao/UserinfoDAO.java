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
}
