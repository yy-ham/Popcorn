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

import com.sist.vo.BoardVO;
import com.sist.vo.MyPageRatingVO;

public class BoardDAO {
	private static BoardDAO dao;
	
	public static BoardDAO getInstance() {
		if(dao==null) {
			dao=new BoardDAO();
		}
		return dao;
	}
	private BoardDAO() {}
	
	public static int pageSIZE=3;
	public static int totalRecord=0;
	
	public int getTotalRecord(int userno) {
		String sql="select count(boardno) from board where userno="+userno;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		int totalRecord=-1;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				totalRecord=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}} 
			if(stmt!=null) {try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
			if(conn!=null) {try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
		}
		return totalRecord;
	}
	
	public int getTotalPage(int userno) {
		int totalPage=(int)Math.ceil((double)getTotalRecord(userno)/pageSIZE);
		return totalPage;
	}
	
	//마이페이지에서 보이는 내가 쓴 게시글(제목, 날짜, 내용 일부만)
	public ArrayList<BoardVO> findMyBoard(int userno, int pageNum){
		String sql="";
		ArrayList<BoardVO> list=new ArrayList<>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		if(pageNum>0) {
			totalRecord=getTotalRecord(userno);
			int start=(pageNum-1)*pageSIZE+1;
			int end=pageNum*pageSIZE;
			sql="select * from (select rownum r,board.* from board where userno="+userno+" order by boardno) where r between "+start+" and "+end;
		}else {
			sql="select * from board where userno="+userno+" order by boardno";
		}

		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO b=new BoardVO();
				b.setBoardno(rs.getInt("boardno"));
				b.setBoardtitle(rs.getString("boardtitle"));
				b.setBoarddate(rs.getDate("boarddate")+"");
				b.setBoardcontent(rs.getString("boardcontent"));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}} 
			if(stmt!=null) {try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
			if(conn!=null) {try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
		}
		return list;
	}
	
	
	
	
	
	
	public static int page_record=10;
	public static int total_record=1;
	public static int total_page=5;
	public static int first_record=1;
	public static int last_record=10;
	
	public int insertBoard(BoardVO vo) {
		int re=-1;
		String sql="insert into board(boardno,boardtitle,userno,boarddate,boardview,boardcontent) values(?,?,?,default,?,?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardno());
			pstmt.setString(2,vo.getBoardtitle());
			pstmt.setInt(3, vo.getUserno());
			pstmt.setInt(4, vo.getBoardview());
			pstmt.setString(5, vo.getBoardcontent());
			re=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally{
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	public String getUserNickname(int userno) {
		String sql="select nickname from userinfo where userno="+userno; 
		Connection conn =null;
		Statement stmt=null;
		ResultSet rs=null;
		String nickname=null;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				nickname=rs.getString("nickname");
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
		return nickname;
	}
	public int nextNo() {
		String sql="select nvl(max(boardno),0)+1 from board"; 
		Connection conn =null;
		Statement stmt=null;
		ResultSet rs=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				re=rs.getInt(1);
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
		return re;
	}
	
	public int getTotal_record(String category, String search) {
		String sql ="select count(boardno) from board";
		if(category!=null&&!category.equals("") && search!=null&&!category.equals("")) 
		{sql+=" where "+category+" like '%"+search+"%'";}
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()) {
				total_record=rs.getInt(1);
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
		return total_record;
	}
	
	
	
	
	public void updateBoardView(int boardno) {
		String sql="update board set boardview=boardview+1 where boardno=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		try {
			Context context= new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			pstmt.executeUpdate();
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
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
	}
	
	public BoardVO findByBoardno(int boardno) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardVO boardvo = null;
		String sql="select boardno, boardtitle, b.userno, nickname, boardcontent from board b, userinfo u where b.userno=u.userno and boardno=?";
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, boardno);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				boardvo= new BoardVO();
				boardvo.setBoardno(rs.getInt("boardno"));
				boardvo.setBoardtitle(rs.getString("boardtitle"));
				boardvo.setUserno(rs.getInt("userno"));
				boardvo.setNickname(rs.getString("nickname"));
				boardvo.setBoardcontent(rs.getString("boardcontent"));
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
			if(pstmt!=null) {
				try {
					pstmt.close();
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
		return boardvo;
	}
	
	//int no, String category, String search
	
	public ArrayList<BoardVO>listAll(HashMap<String, String> map){
		int pageno=1;
		if(map.get("no")!=null&&!map.get("no").equals("")) {
			pageno=Integer.parseInt(map.get("no"));
		}
		String category=map.get("category");
		String search=map.get("searchBoard");
		ArrayList<BoardVO> list =null;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		total_record=getTotal_record(category,search);
		total_page=(int)Math.ceil((double)total_record/page_record);
		first_record=(pageno-1)*page_record+1;
		last_record=first_record+page_record-1;
		if(last_record>total_record) {
			last_record=total_record;
		}
		
		String sql="select * from (select rownum n,a.* from("+
				"select boardno, boardtitle, u.userno , nickname, boarddate, boardview from board b, userinfo u"+ 
				" where b.userno=u.userno";
		if((category!=null&&!category.equals(""))&&(search!=null&&!search.equals(""))) {
				sql+=" and "+category+" like '%"+search+"%'";	
			};
				sql+=" order by boardno)a) where n between "+first_record+" and "+last_record;
				
		try {
			list = new ArrayList<BoardVO>();
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO vo= new BoardVO();
				vo.setBoardno(rs.getInt("boardno"));
				vo.setBoardtitle(rs.getString("boardtitle"));
				vo.setUserno(rs.getInt("userno"));
				vo.setNickname(rs.getString("nickname"));
				vo.setBoarddate(rs.getDate("boarddate")+"");
				vo.setBoardview(rs.getInt("boardview"));
				list.add(vo);
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
	
	
	public int updateBoard(BoardVO vo) {
		String sql="update board set boardtitle=?, boardcontent=?, boarddate=default where boardno=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,vo.getBoardtitle());
			pstmt.setString(2,vo.getBoardcontent());
			pstmt.setInt(3, vo.getBoardno());
			re=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("error : "+e.getMessage());
		}finally{
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return re;
	}
	
	
	public int deleteBoard(int boardno) {
		String sql="delete board where boardno="+boardno;
		Connection conn =null;
		Statement stmt=null;
		ResultSet rs=null;
		int re=-1;
		try {
			Context context = new InitialContext();
			DataSource ds=(DataSource)context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			re=stmt.executeUpdate(sql);
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
		return re;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//마이페이지에서 더보기 눌렀을 때 보이는 게시글(게시글 전체 칼럼)
	/*
	public ArrayList<BoardVO> findMyBoardDetail(int userno){
		ArrayList<BoardVO> list=new ArrayList<>();
		String sql="select * from board where userno="+userno;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			Context context=new InitialContext();
			DataSource ds=(DataSource) context.lookup("java:/comp/env/mydb");
			conn=ds.getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				BoardVO b=new BoardVO();
				b.setBoardno(rs.getInt("boardno"));
				b.setBoardtitle(rs.getString("boardtitle"));
				b.setBoarddate(rs.getDate("boarddate")+"");
				b.setBoardview(rs.getInt("boardview"));
				b.setBoardcontent(rs.getString("boardcontent"));
				b.setBoardfile(rs.getString("boardfile"));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}} 
			if(stmt!=null) {try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
			if(conn!=null) {try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}}
		}
		return list;
	}*/
}
