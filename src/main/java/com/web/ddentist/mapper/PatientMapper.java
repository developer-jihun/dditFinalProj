package com.web.ddentist.mapper;

import com.web.ddentist.vo.PatientVO;

public interface PatientMapper {
	
	/**
	 * 환자 페이지 사용자 로그인
	 * 
	 * @param ptVO 환자 페이지 사용자의 아이디가 담긴 VO
	 * @return 사용자의 환자 정보
	 */
	public PatientVO login(PatientVO ptVO);
	
	/**
	 * 환자 페이지 회원가입 폼에서 입력한 정보와 일치하는 환자 정보가 있는지 확인<br>
	 * 환자 페이지를 이용하기 위해서는 병원에서 신환 등록을 해야한다.
	 * 
	 * @param ptVO 이름, 주민등록번호, 연락처가 담긴 VO
	 * @return 환자 번호, 환자 명, 환자 연락처가 담긴 VO<br>
	 * 		   입력받은 정보와 일치하는 환자가 존재하지 않을 경우 null
	 */
	public PatientVO selectPtInfo(PatientVO ptVO);
	
	/**
	 * 진료 기록 정보 공유 동의여부 상태 변경
	 * 
	 * @param ptVO 환자 번호와 진료 기록 정보 공유 동의여부 상태가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePtMrsaYn(PatientVO ptVO);
	
	/**
	 * 아이디 중복 검사
	 * 
	 * @param ptId 중복 검사할 아이디
	 * @return 해당 아이디를 가진 사용자의 수
	 */
	public int checkId(String ptId);
	
	/**
	 * 환자에게 홈페이지 사용자 아이디, 비밀번호를 추가하고 계정 사용여부를 "1"로, 계정 권한을 "ROLE_PT"로 줌
	 * 
	 * @param ptVO 회원 정보를 등록할 사용자의 환자 번호, 사용할 아이디와 비밀번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPtAcc(PatientVO ptVO);
	
	/**
	 * 입력한 이름과 연락처와 일치하는 사용자의 아이디 반환
	 * 
	 * @param ptVO 이름, 연락처가 담긴 VO
	 * @return 입력한 정보와 일치하는 사용자의 아이디
	 */
	public String findId(PatientVO ptVO);
	
	/**
	 * 입력한 이름과 연락처와 일치하는 사용자가 존재하는지 확인
	 * 
	 * @param ptVO 이름, 연락처가 담긴 VO
	 * @return 정보가 일치하는 사용자의 환자 번호<br>
	 * 		   일치하는 사용자가 없을 경우 null
	 */
	public String findPw(PatientVO ptVO);
	
	/**
	 * 사용자 비밀번호 초기화
	 * 
	 * @param ptVO 변경할 비밀번호가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int resetPtPw(PatientVO ptVO);
	
}
