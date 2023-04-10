package com.web.ddentist.hospital.checkup.service;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.CheckupVO;
import com.web.ddentist.vo.MediaVO;
import com.web.ddentist.vo.PatientVO;

public interface ICheckupService {
	
	/**
	 * 키워드와 일치하는 환자 목록을 반환
	 * 
	 * @param keyword 검색 키워드
	 * @return 키워드와 일치하는 환자 목록
	 */
	public List<PatientVO> searchPt(String keyword);
	
	/**
	 * 진료 차트 목록 조회
	 * 
	 * @param searchMap 환자 번호, 시작 날짜, 종료 날짜
	 * @return List&lt;PiVO&gt;, List&lt;TxPlanVO&gt; List&lt;TxVO&gt;, List&lt;TxNextVO&gt; 을 포함한 Map 객체<br>
	 * List&lt;PiVO&gt;의 key : piList<br>
	 * List&lt;TxPlanVO&gt;의 key : txpList<br>
	 * List&lt;TxVO&gt;의 key : txList<br>
	 * List&lt;TxNextVO&gt;의 key : txnList
	 */
//	public Map<String, Object> listChart(Map<String, String> searchMap);
	
	/**
	 * 진료 차트 목록 조회
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
