package com.sist.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int boardno;
	private String boardtitle, boarddate;
	private int boardview;
	private String boardcontent, boardfile;
}
