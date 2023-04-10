package com.web.ddentist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatMemberVO {

	private String empNum;
	private int chatgrpNum;
	private Date chatgrpLastread;

	private String empNm;

}
