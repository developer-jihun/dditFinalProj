package com.web.ddentist.ddit.receipt.service;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.ReceiptVO;

public interface IPreceiptService {
	
	/**
	 * 환자의 결제이력 가져옴
	 * 
	 * @return 결제이력 목록
	 */
	public List<ReceiptVO> listReceipt();
	
	/**
	 * 환자의 결제정보 가져옴
	 * 
	 * @param rctNum 가져올 결제정보의 번호
	 * @return 결제정보
	 */
	public ReceiptVO selectReceipt(int rctNum);
	
	/**
	 * 환자 결제이력을 기간으로 검색함
	 * 
	 * @param paramMap 결제 검색 시작날짜("rctSdt")와 종료날짜("rctEdt")
	 * @return 해당 기간에 이루어진 결제이력 목록
	 */
	public List<ReceiptVO> searchReceipt(Map<String, String> paramMap);
	
}
