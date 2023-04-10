package com.web.ddentist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RcvmtVO {
	
	private String rcvmtNum;
	private String ptNum;
	private String chkNum;
	private int rcvmtAmt;
	private int rcvmtDscntAmt;
	private String rcvmtStatus;
	private int rcvmtBalance;
	private int rcvmtGramt;
	private Date rcvmtDt;
	private String rcvmtType;
	
	private String ptNm;
	private String empNm;
	private String rcvmtDtStr;
	private int rctAmt;
	
}
