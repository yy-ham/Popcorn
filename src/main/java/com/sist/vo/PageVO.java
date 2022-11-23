package com.sist.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PageVO {
	private int pageno;
	private int prev;
	private int next;
	private int total_page;
	private int cnt;
}
