package com.web.ddentist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FaqVO {
	
	private int faqNum;
	private String faqType;
	private String faqTitle;
	private String faqContent;
	private String faqDt;
	
	//검색 시 keyword
	private String keyword;
	
	//페이징 처리 시 필요함
	private int currentPage;
	private int size;
	
}
