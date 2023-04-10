package com.web.ddentist.vo;

import lombok.Data;

@Data
public class DiseaseVO {
	
	private String disCd;
	private String disKorNm;
	private String disEnNm;
	
	private String color; // 전자차트에서 색상을 지정하는데 사용
	
}
