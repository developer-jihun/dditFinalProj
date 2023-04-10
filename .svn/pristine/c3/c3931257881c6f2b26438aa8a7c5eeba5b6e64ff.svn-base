package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.CheckupVO;
import com.web.ddentist.vo.MediaVO;
import com.web.ddentist.vo.PatientVO;
import com.web.ddentist.vo.PiVO;
import com.web.ddentist.vo.TxNextVO;
import com.web.ddentist.vo.TxPlanVO;
import com.web.ddentist.vo.TxVO;

public interface CheckupMapper {
	
	/**
	 * 키워드와 일치하는 환자 목록을 반환
	 * 
	 * @param keyword 검색 키워드
	 * @return 키워드와 일치하는 환자 목록
	 */
	public List<PatientVO> searchPt(String keyword);
	
	/**
	 * 환자의 증상(PI) 차트 기록 목록 조회
	 * 
	 * @param searchMap 환자 번호, 시작 날짜, 종료 날짜
	 * @return 증상(PI) 차트 기록 목록
	 */
	public List<PiVO> listPtPi(Map<String, String> searchMap);
	
	/**
	 * 환자의 처치 계획(TX PLAN) 차트 기록 목록 조회
	 * 
	 * @param searchMap 환자 번호, 시작 날짜, 종료 날짜
	 * @return 처치 계획(TX PLAN) 차트 기록 목록
	 */
	public List<TxPlanVO> listPtTxPlan(Map<String, String> searchMap);
	
	/**
	 * 환자의 처치(TX) 차트 기록 목록 조회
	 * 
	 * @param searchMap 환자 번호, 시작 날짜, 종료 날짜
	 * @return 처치(TX) 차트 기록 목록
	 */
	public List<TxVO> listPtTx(Map<String, String> searchMap);
	
	/**
	 * 환자의 다음 처치 계획(TX NEXT) 차트 기록 목록 조회
	 * 
	 * @param searchMap 환자 번호, 시작 날짜, 종료 날짜
	 * @return 다음 처치 계획(TX NEXT) 차트 기록 목록
	 */
	public List<TxNextVO> listPtTxNext(Map<String, String> searchMap);
	
	/**
	 * 환자의 진료 차트 기록 목록 조회
	 * 
	 * @param searchMap 환자 번호, 시작 날짜, 종료 날짜
	 * @return 증상, 처치 계획, 처치, 다음 처치 계획을 포함한 CheckupVO의 목록
	 */
	public List<CheckupVO> listChart(Map<String, String> searchMap);
	
	/**
	 * 썸네일에서 선택한 영상이미지의 정보를 가져온다.
	 * 
	 * @param medNum 선택한 영상이미지의 영상 번호
	 * @return 영상이미지 정보
	 */
	public MediaVO selectMedia(String medNum);
	
}
