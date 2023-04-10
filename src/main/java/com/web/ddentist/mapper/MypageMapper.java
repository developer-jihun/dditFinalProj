package com.web.ddentist.mapper;

import java.util.Map;

import com.web.ddentist.vo.PatientVO;

public interface MypageMapper {
	
	/**
	 * 개인정보 수정을 위해 입력한 비밀번호가 일치하는지 확인
	 * 
	 * @param paramMap 사용자 아이디와 비밀번호가 담긴 Map
	 * @return 해당 아이디와 비밀번호를 가진 환자의 환자 번호<br>
	 * 		   아이디, 비밀번호가 일치하는 환자가 없을 경우 null 반환
	 */
	public PatientVO checkAcc(Map<String, String> paramMap);
	
	/**
	 * 개인정보 수정
	 * 
	 * @param ptVO 사용자의 환자 번호, 연락처, 주소가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePtInfo(PatientVO ptVO);
	
	/**
	 * 사용자 비밀번호 변경
	 * 
	 * @param ptVO 사용자의 환자 번호, 새로운 비밀번호가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePtPw(PatientVO ptVO);
	
}
