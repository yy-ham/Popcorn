package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class MovieActorCastVO {
	private int movieno;
	private String movietitle;
	private String genre;
	private String country;
	private int runningtime;
	private Date releasedate;
	private String agelimit;
	private String story;
	private String poster;
	private String mainimg;
	
	private int actorno;
	private String actorname;
	private String actorimg;
	
	private String role;
	private String position;
}
