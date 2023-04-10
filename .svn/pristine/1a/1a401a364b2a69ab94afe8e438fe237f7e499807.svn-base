package com.web.ddentist.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;



//발주
@Data
public class PurchaseVO {
	private String purNum;
	private int purCost;
	private Date purDt;
	private String purStatus;
	
	//발주 : 발주 약품 = 1 : N
	private List<PurchaseDrugVO> purchaseDrugList;
	
	//시작 기간
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	
	//종료 기간
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	
	}
