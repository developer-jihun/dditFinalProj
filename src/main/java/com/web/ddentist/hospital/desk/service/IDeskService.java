package com.web.ddentist.hospital.desk.service;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.ChairVO;
import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.EmployeeVO;
import com.web.ddentist.vo.FamilyVO;
import com.web.ddentist.vo.PatientVO;
import com.web.ddentist.vo.QuestionnaireVO;
import com.web.ddentist.vo.RegistVO;

public interface IDeskService {
	
	/**
	 * 공통 코드 조회
	 * 
	 * @param commGrCd 조회할 공통 코드의 그룹 코드
	 * @return 해당 그룹 코드의 공통 코드 목록
	 */
	public List<CommonCodeVO> listCommonCode(String commGrCd);
	
	/**
	 * 접수에서 선택할 의사 목록 조회
	 * 
	 * @return 직급이 의사인 직원 목록
	 */
	public List<EmployeeVO> listEmployee();
	
	/**
	 * 진료 의자 목록 조회
	 * 
	 * @return 진료 의자 목록
	 */
	public List<ChairVO> listChair();
	
	/**
	 * 환자 등록
	 * 
	 * @param patientVO 환자 정보가 담긴 VO
	 * @return 성공 : 환자 번호, 실패 : FAILED
	 */
	public String insertPatient(PatientVO patientVO);
	
	/**
	 * 환자 정보 수정
	 * 
	 * @param patientVO 환자 정보가 담긴 VO
	 * @return 성공 : UPDATE, 실패 : FAILED
	 */
	public String updatePatient(PatientVO patientVO);
	
	/**
	 * 환자 검색
	 * 
	 * @param keyword 환자 검색에 입력한 키워드
	 * @return 해당 키워드에 일치하는 환자 VO 목록
	 */
	public List<PatientVO> searchPatient(String keyword);
	
	/**
	 * 환자 정보 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 환자 정보가 담긴 VO
	 */
	public PatientVO selectPatient(String ptNum);
	
	/**
	 * 환자 정보 삭제
	 * 
	 * @param ptNum 환자 번호
	 * @return 성공 : SUCCESS, 실패 : FAILED, 진료기록이 있어 거부됨 : DENIED
	 */
	public String deletePatient(String ptNum);
	
	/**
	 * 문진표 작성
	 * 
	 * @param queVO 문진표 내용
	 * @return 성공 : "INSERT", 실패 : "FAILED"
	 */
	public String insertQue(QuestionnaireVO queVO);
	
	/**
	 * 회원 문진표 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 회원의 문진표와 기저질환 정보가 담긴 VO
	 */
	public QuestionnaireVO selectQue(String ptNum);
	
	/**
	 * 회원 문진표 수정
	 * 
	 * @param queVO 문진표 내용
	 * @return 성공 : "UPDATE", 실패 : "FAILED"
	 */
	public String updateQue(QuestionnaireVO queVO);
	
	/**
	 * 접수 목록 조회
	 * 
	 * @return 오늘의 접수 목록
	 */
	public List<RegistVO> listRegist();
	
	/**
	 * 접수 추가
	 * 
	 * @param regVO 접수 정보가 담긴 VO
	 * @return 성공 : "SUCCESS", 실패 : "FAILED"
	 */
	public String insertRegist(RegistVO regVO);
	
	/**
	 * 접수 취소
	 * 
	 * @param regVO 취소할 접수 건의 접수 번호
	 * @return 성공 : "SUCCESS", 실패 : "FAILED"
	 */
	public String cancelRegist(RegistVO regVO);
	
	/**
	 * 환자의 가족, 진료, 수납 정보 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 해당 환자의 가족, 진료, 수납 정보 목록<br>
	 * 가족관계 정보 key : familyList<br>
	 * 진료내역 정보 key : checkupList<br>
	 * 수납내역 정보 key : rcvmtList
	 */
	public Map<String, Object> selectDetail(String ptNum);
	
	/**
	 * 환자 가족관계 추가
	 * 
	 * @param famVO 가족관계 정보가 담긴 VO
	 * @return 성공 : "INSERT", 실패 : "FAILED"
	 */
	public String insertFamily(FamilyVO famVO);
	
	/**
	 * 환자 가족관계 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 해당 환자의 가족인 환자의 목록
	 */
	public List<FamilyVO> listFamily(String ptNum);
	
	/**
	 * 환자와 가족환자의 관계 조회
	 * 
	 * @param famVO 환자 번호와 가족인 환자의 번호가 담긴 VO
	 * @return 두 환자의 가족관계
	 */
	public FamilyVO selectFamily(FamilyVO famVO);
	
	/**
	 * 환자 가족관계 수정
	 * 
	 * @param famVO 가족관계 정보가 담긴 VO
	 * @return 성공 : "UPDATE", 실패 : "FAILED"
	 */
	public String updateFamily(FamilyVO famVO);
	
	/**
	 * 환자 가족관계 삭제
	 * 
	 * @param famVO 삭제할 가족관계의 환자 번호와 가족 환자 번호가 담긴 VO
	 * @return 성공 : "SUCCESS", 실패 : "FAILED"
	 */
	public String deleteFamily(FamilyVO famVO);
	
}
