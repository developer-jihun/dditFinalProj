package com.web.ddentist.hospital.crm.sms.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.web.ddentist.hospital.crm.sms.util.SmsSendUtil;
import com.web.ddentist.mapper.SmsMapper;
import com.web.ddentist.vo.CrmVO;
import com.web.ddentist.vo.SmsTemplateVO;
import com.web.ddentist.vo.SmsVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SmsScheduleService {

	@Autowired
	private SmsSendUtil smsSendUtil;
	@Autowired
	private SmsMapper smsMapper;

	public void getCrmOnSchedule() {

		log.info("------------------------------------------------------------");
		log.info(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		log.info("------------------------------------------------------------");

		/*
		String smsContentTemplateForResv = "";
		String smsContentTemplateForCmptnTreat = "";
		List<SmsTemplateVO> tplRepList = smsMapper.selectTplRep();
		for(SmsTemplateVO smsTplVO : tplRepList) {
			if(smsTplVO.getTplType().equals("SMS_RESV")) {
				smsContentTemplateForResv = smsTplVO.getTplSmsContent();
			} else if (smsTplVO.getTplType().equals("SMS_REGARD")) {
				smsContentTemplateForCmptnTreat = smsTplVO.getTplSmsContent();
			}
		}

		List<CrmVO> scheduledCrmList = smsMapper.listCrmOnSchedule();
		for(CrmVO crm : scheduledCrmList) {

			try {
				String smsContent = "";
				switch (crm.getCrmReason()) {
				case "예약":
					smsContent = smsSendUtil.parseSmsContent(smsContentTemplateForResv, crm.getPtNm(), crm.getCrmNxResvDtStr());
					break;
				case "진료":
					smsContent = smsSendUtil.parseSmsContent(smsContentTemplateForCmptnTreat, crm.getPtNm(), null);
					break;
				default:
					continue;
				}

				smsSendUtil.sendSms(crm.getPtPhone(), smsContent);

				SmsVO smsVO = new SmsVO();
				smsVO.setPtNum(crm.getPtNum());
				smsVO.setPtNm(crm.getPtNm());
				smsVO.setPtPhone(crm.getPtPhone());
				smsVO.setSmsContent(smsContent);

				smsMapper.insertSms(smsVO);
				smsMapper.updateCrmStatus(crm.getCrmNum());

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		*/

	}

}
