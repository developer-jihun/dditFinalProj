package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.CheckupVO;

public interface PcheckupMapper {
	
	/**
	 * 환자의 진료기록을 설정한 기간에 맞게 가져온다.
	 * @param Map 환자 번호 (시작날짜 끝날짜)
	 * @return 
	 */
	public List<CheckupVO> pCheckupList(Map<String, String> ptInfo);
	
	/**
	 * 환자의 진료기록에 대한 정보, 진료영상,처방내역을 가져온다
	 * @param checkupVO(진료번호)
	 * @return 진료건에 대한  정보, 진료영상,처방내역 
	 */
	public CheckupVO detailCheckup(CheckupVO checkupVO);
}
