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

public class CastDAO {
	//싱글톤 방식
	private static CastDAO dao;
	public static CastDAO getInstance() {
		if(dao == null) {
			dao = new CastDAO();
		}
		return dao;
	}
	private CastDAO() {
		
	}
	
	
}
