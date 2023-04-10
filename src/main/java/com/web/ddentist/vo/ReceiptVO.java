package com.web.ddentist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReceiptVO {

	private int rctNum;
	private String rcvmtNum;
	private Date rctIssueDt;
	private int rcvmtRctSn;
	private String rctPayOpt;
	private String rctCardComp;
	private String rctCardNum;
	private String rctAcceptNum;
	private int rctAmt;

	private int rcvmtDscntAmt;

	private String ptNum;
	private String ptNm;
	private String rctIssueDtStr;

	private String rcvmtType;

	private String hiNm;

}
