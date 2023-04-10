package com.web.ddentist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CrmVO {
	
	private int crmNum;
	private String ptNum;
	private String crmPrcsStatus;
	private Date crmPrcsCmptnDt;
	private String crmReason;
	private Date crmEth;
	private Date crmNxResvDt;
	
	private String ptNm;
	private String ptPhone;
	private String crmPrcsCmptnDtStr;
	private String crmEthStr;
	private String crmNxResvDtStr;
}
