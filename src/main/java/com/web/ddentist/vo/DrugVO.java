package com.web.ddentist.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DrugVO {
	private int drugNum;
	private String drugNm;
	private String drugNmEn;
	private String drugType;
	private String drugIngre;
	private String drugComp;
	private int drugCount;
	
	private String prcpNum;
	private int dosage; //1회 투약량
	private int doses; //1일 투약횟수
	private int dosesdate; //총 투약일수
	
	private int drugList[];
	
	//약품:발주약품 = 1:N
	private List<PurchaseDrugVO> purchaseDrugList;
	

	
}

