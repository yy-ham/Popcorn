package com.sist.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardCommentVO {
	private int boardcommentno;
	private int boardno;
	private int userno;
	private String nickname;		//nickname은 댓글 작성한 사람을 보여줄때 쓴다.
	private String boardcommentcontent;
	private String boardcommentdate;
}
