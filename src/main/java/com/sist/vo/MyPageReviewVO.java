package com.sist.vo;

import lombok.Data;

@Data
public class MyPageReviewVO {
	private int movieno;
	private String movietitle, poster;
	private int reviewno;
	private String reviewcontent, reviewdate, ratingcontent;
}
