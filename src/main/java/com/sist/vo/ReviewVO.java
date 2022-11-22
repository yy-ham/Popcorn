package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class ReviewVO {
	private int reviewno;
	private int userno;
	private int movieno;
	private String reviewcontent;
	private Date reviewdate;
}
