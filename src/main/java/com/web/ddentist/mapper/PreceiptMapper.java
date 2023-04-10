package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.ReceiptVO;

public interface PreceiptMapper {
	
	/**
	 * 환자의 결제이력 목록 가져옴
	 * 
	 * @param paramMap 결제이력을 조회할 환자의 환자 번호("ptNum"), 시작날짜("rctSdt"), 종료날짜("rctEdt")
	 * @return 결제이력 목록
	 */
	public List<ReceiptVO> listReceipt(Map<String, String> paramMap);
	
	/**
	 * 환자의 결제정보 가져옴
	 * 
	 * @param rctNum 가져올 결제정보의 번호
	 * @return 결제정보
	 */
	public ReceiptVO selectReceipt(int rctNum);
	
}
