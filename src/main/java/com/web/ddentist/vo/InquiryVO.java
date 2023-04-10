package com.web.ddentist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class InquiryVO {
	
	private int inqNum;
	private String ptNum;
	private String inqTitle;
	private String inqContent;
	private String inqWrtrNm;
	private Date inqDt;
	private String inqPw;
	
	private String inqDtStr;
	private int ansCount;
	private int newInqNum;
	
	private AnswerVO ansVO;
	
}
