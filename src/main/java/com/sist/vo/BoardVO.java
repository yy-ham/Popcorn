package com.sist.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int boardno;
	private String boardtitle, boarddate;
	private String nickname;	// join으로 nickname도 보여줄 수 있어야해서 포함시킴
	private int userno;				
	private int boardview;
	private String boardcontent, boardfile;
}
