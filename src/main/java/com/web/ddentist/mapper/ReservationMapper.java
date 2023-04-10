package com.web.ddentist.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.HospitalInfoVO;
import com.web.ddentist.vo.ReservationVO;

public interface ReservationMapper {
	
	/**
	 * 예약 추가
	 * @param vo 예약 정보가 담긴 vo(이름, 전화번호, 호소증상, 시간, 의사, 경과시간)
	 * @return 성공시 1, 실패시0 반환
	 */
	public int create(ReservationVO vo);
	
	/**
	 * 기간에 따른 예약 리스트를 가져온다
	 * @param dateMap 리스트를 가져올 기간
	 * @return 예약 리스트 반환
	 */
	public List<ReservationVO> getAllList(Map<String, String> dateMap);
	
	/**
	 * 예약 상태를 변경 시킨다
	 * @param map 변경시킬 예약 번호
	 * @return 성공시 1, 실패시 0 반환
	 */
	public int changeStat(Map<String, String> map);
	
	/**
	 * 예약이 있는 의사 목록을 가져온다
	 * @param map 예약 시간이 담긴 Map
	 * @return 의사 List 반환
	 */
	public List<String> selectOption(Map<String, Date> map);

	/**
	 * 전체 의사 정보를 가져온다
	 * @return 의사 List 반환
	 */
	public List<Map<String, String>> empInfo();
	
	/**
	 * 예약 구분을 가져온다
	 * @return 예약 구분 List
	 */
	public List<Map<String, String>> resvState();
	
	/**
	 * 예약 종료시간이 오늘날짜보다 이전인 예약 건수를
	 * 예약 미이행으로 상태를 변경시킨다
	 * @return 변경된 예약 건수를 리턴시킨다.
	 */
	public int previousRes();
	
	/**
	 * 병원 오픈 시간 휴식시간을 가져온다.
	 * @return 오픈시간과 휴식시간이 담긴 vo
	 */
	public HospitalInfoVO openTime();
	
}
