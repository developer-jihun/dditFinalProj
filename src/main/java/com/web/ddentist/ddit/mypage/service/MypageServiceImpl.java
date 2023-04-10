package com.web.ddentist.ddit.mypage.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.MypageMapper;
import com.web.ddentist.mapper.PatientMapper;
import com.web.ddentist.patient.service.PatientDetails;
import com.web.ddentist.vo.PatientVO;

@Service
public class MypageServiceImpl implements IMypageService {
	
	@Autowired
	private MypageMapper mypageMapper;
	@Autowired
	private PatientMapper ptMapper;
	
	@Override
	public int updatePtInfo(Map<String, String> paramMap) {
		PatientDetails ptDetails = (PatientDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String ptId = ptDetails.getPtVO().getPtId();
		paramMap.put("ptId", ptId);
		
		PatientVO ptVO = mypageMapper.checkAcc(paramMap);
		if(ptVO == null) return -1;
		String ptNum = ptDetails.getPtVO().getPtNum();
		if(!ptNum.equals(ptVO.getPtNum())) {
			return -1;
		}
		
		ptVO.setPtId(ptId);
		String ptPhone = paramMap.get("ptPhone1") + paramMap.get("ptPhone2") + paramMap.get("ptPhone3");
		ptVO.setPtPhone(ptPhone);
		ptVO.setPtZip(paramMap.get("ptZip"));
		ptVO.setPtAddr(paramMap.get("ptAddr"));
		ptVO.setPtAddrDet(paramMap.get("ptAddrDet"));
		
		int result = mypageMapper.updatePtInfo(ptVO);
		if(result > 0) {
			PatientVO newPtVO = ptMapper.login(ptVO);
			ptDetails.setPtVO(newPtVO);
		}
		
		return result;
	}
	
	@Override
	public int updatePtPw(Map<String, String> paramMap) {
		PatientDetails ptDetails = (PatientDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String ptId = ptDetails.getPtVO().getPtId();
		paramMap.put("ptId", ptId);
		
		PatientVO ptVO = mypageMapper.checkAcc(paramMap);
		if(ptVO == null) return -1;
		String ptNum = ptDetails.getPtVO().getPtNum();
		if(!ptNum.equals(ptVO.getPtNum())) {
			return -1;
		}
		
		ptVO.setPtId(ptId);
		String newPtPw = paramMap.get("newPtPw");
		ptVO.setPtPw(newPtPw);
		int result = mypageMapper.updatePtPw(ptVO);
		if(result > 0) {
			PatientVO newPtVO = ptMapper.login(ptVO);
			ptDetails.setPtVO(newPtVO);
		}
		
		return result;
	}
	
}
