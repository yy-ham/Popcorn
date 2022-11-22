package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class ReviewRatingUserinfoVO {
	private int reviewno;
	private int userno;
	private int movieno;
	private String reviewcontent;
	private Date reviewdate;
	
	private int ratingno;
	private String ratingcontent;
	
	private String username;
	private String email;
	private String pwd;
	private String nickname;
	private String userimg;
}
