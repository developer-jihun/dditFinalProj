package com.web.ddentist.ddit.pcheckup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.PcheckupMapper;
import com.web.ddentist.vo.CheckupVO;

public interface PcheckupService {
	
	/**
	 * 환자의 진료기록을 설정한 기간에 맞게 가져온다.
	 * @param Map 환자 번호 (시작날짜 끝날짜)
	 * @return 환자의 진료기록 리스트
	 */
	public List<CheckupVO> pCheckupList(Map<String, String> ptInfo);
	
	/**
	 * 환자의 진료기록에 대한 정보, 진료영상,처방내역을 가져온다
	 * @param checkupVO(진료번호)
	 * @return 진료건에 대한  정보, 진료영상,처방내역 
	 */
	public CheckupVO detailCheckup(CheckupVO checkupVO);
	
}
