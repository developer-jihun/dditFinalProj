package com.web.ddentist.hospital.crm.sms.util;

import java.util.List;

import lombok.Data;

@Data
public class SmsDetails{

	private String smsContent;
	private List<String> ptNumList;
	private List<String> crmNumList;

}
