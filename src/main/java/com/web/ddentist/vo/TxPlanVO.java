package com.web.ddentist.vo;

import lombok.Data;

@Data
public class TxPlanVO {
	
	private int txpSn;
	private String chkNum;
	private String txcCd;
	private String txpToothNum;
	private String txpContent;
	private int txpCost;
	
//	private String chkDt;
	private String chkDtStr;
	private String empNm;
	
	private String txcNm;
	
}
