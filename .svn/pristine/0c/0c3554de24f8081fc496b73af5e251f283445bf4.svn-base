package com.web.ddentist.patient.service;

import java.util.Map;

import com.web.ddentist.vo.PatientVO;

public interface IPatientService {

	/**
	 * 회원가입을 위해 입력한 정보와 일치하는 환자정보가 있는지 확인 후<br>
	 * 일치하는 환자 정보가 존재할 경우 연락처로 인증번호가 담긴 SMS를 발송
	 *
	 * @param ptVO 이름, 주민등록번호, 연락처가 담긴 VO
	 * @return 성공 : "SUCCESS", 실패 : "FAILED", 일치정보 없음 : "NONE", 이미 회원인 환자 : "ALREADY"
	 */
	public String sendAuthNum(PatientVO ptVO);

	/**
	 * 인증번호 확인
	 *
	 * @param paramMap 사용자가 입력한 인증번호 ("authNum")
	 * @return 성공 : "SUCCESS", 실패 : "FAILED"
	 */
	public String checkAuthNum(Map<String, String> paramMap);

	/**
	 * 진료 기록 정보 공유 동의여부 상태 변경
	 *
	 * @param ptVO 진료 기록 정보 공유 동의여부 상태가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePtMrsaYn(PatientVO ptVO);

	/**
	 * 아이디 중복 검사
	 *
	 * @param ptId 중복 검사할 아이디
	 * @return 사용가능 : "SUCCESS", 사용불가능 : "FAILED"
	 */
	public String checkId(String ptId);

	/**
	 * 환자에게 홈페이지 사용자 아이디, 비밀번호를 추가하고 계정 사용여부를 "1"로, 계정 권한을 "ROLE_PT"로 줌
	 *
	 * @param ptVO 회원 정보를 등록할 사용자의 환자 번호, 사용할 아이디와 비밀번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPtAcc(PatientVO ptVO);

	/**
	 * 아이디 찾기를 위한 휴대폰 인증번호 발송
	 *
	 * @param ptVO 인증번호를 받을 연락처가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public String sendFindIdPwAuthNum(PatientVO ptVO);

	/**
	 * 입력한 이름과 연락처와 일치하는 사용자의 아이디 반환
	 *
	 * @param paramMap 이름("ptNm"), 연락처("ptPhone1", "ptPhone2", "ptPhone3")
	 * @return 입력한 정보와 일치하는 사용자의 아이디
	 */
	public String findId(Map<String, String> paramMap);

	/**
	 * 비밀번호 초기화를 위해 입력한 이름과 연락처와 일치하는 사용자의 존재 여부 확인
	 *
	 * @param paramMap 이름("ptNm"), 연락처("ptPhone1", "ptPhone2", "ptPhone3")
	 * @return 성공 : 1, 실패 : 0
	 */
	public int findPw(Map<String, String> paramMap);

	/**
	 * 사용자 비밀번호 초기화
	 *
	 * @param ptVO 변경할 비밀번호가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int resetPtPw(PatientVO ptVO);

}
