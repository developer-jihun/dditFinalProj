package com.web.ddentist.mapper;

import java.util.List;

import com.web.ddentist.vo.ChairVO;
import com.web.ddentist.vo.CheckupVO;
import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.EmployeeVO;
import com.web.ddentist.vo.FamilyVO;
import com.web.ddentist.vo.PatientVO;
import com.web.ddentist.vo.QuestionnaireVO;
import com.web.ddentist.vo.RcvmtVO;
import com.web.ddentist.vo.RegistVO;
import com.web.ddentist.vo.UnderlyingConditionVO;

public interface DeskMapper {
	
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
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPatient(PatientVO patientVO);
	
	/**
	 * 환자 정보 수정
	 * 
	 * @param patientVO 환자 정보가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePatient(PatientVO patientVO);
	
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
	 * 환자 진료 기록 조회<br>진료 기록이 존재하는 환자는 정보를 삭제할 수 없다.
	 * 
	 * @param ptNum 환자 번호
	 * @return 해당 환자의 진료 건수
	 */
	public int countCheckupRecord(String ptNum);
	
	/**
	 * 환자 정보 삭제
	 * 
	 * @param ptNum 환자 번호
	 * @return 성공 : SUCCESS, 실패 : FAILED, 진료기록이 있어 거부됨 : DENIED
	 */
	public int deletePatient(String ptNum);
	
	/**
	 * 문진표 작성
	 * 
	 * @param queVO 문진표 내용
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertQue(QuestionnaireVO queVO);
	
	/**
	 * 기저질환 작성
	 * 
	 * @param conList 기저질환 목록
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertUCon(List<UnderlyingConditionVO> conList);
	
	/**
	 * 회원 문진표 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 회원의 문진표와 기저질환 정보가 담긴 VO
	 */
	public QuestionnaireVO selectQue(String ptNum);
	
	/**
	 * 기저질환의 수를 확인<br>
	 * 만약 기존에 등록된 기저질환이 있는데 요청으로 들어온 기저질환이 0개라면<br>
	 * 클라이언트에서 기저질환을 모두 지운 것이다. 
	 * 
	 * @param ptNum 환자 번호
	 * @return 기저질환의 수
	 */
	public int checkUConCount(String ptNum);
	
	/**
	 * 기저질환을 모두 삭제<br>
	 * 기저질환 수정을 위해 기존에 있던 기저질환 정보를 모두 삭제한다.
	 * 
	 * @param ptNum 환자 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int resetUCon(String ptNum);
	
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
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertRegist(RegistVO regVO);
	
	/**
	 * 접수 취소
	 * 
	 * @param regVO 취소할 접수 건의 접수 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int cancelRegist(RegistVO regVO);
	
	/**
	 * 환자의 가족정보 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 해당 환자의 가족 목록
	 */
	public List<FamilyVO> listFamily(String ptNum);
	
	/**
	 * 환자의 진료정보 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 해당 환자의 진료 목록
	 */
	public List<CheckupVO> listCheckup(String ptNum);
	
	/**
	 * 환자의 수납정보 조회
	 * 
	 * @param ptNum 환자 번호
	 * @return 해당 환자의 수납 목록
	 */
	public List<RcvmtVO> listRcvmt(String ptNum);
	
	/**
	 * 환자 가족관계 추가
	 * 
	 * @param famVO 가족관계 정보가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertFamily(FamilyVO famVO);
	
	/**
	 * 가족관계가 추가되면 반대쪽의 환자에게도 가족관계를 추가해준다.
	 * 
	 * @param famVO 가족관계 정보가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertFamilyTheOtherSide(FamilyVO famVO);
	
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
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateFamily(FamilyVO famVO);
	
	/**
	 * 가족관계가 수정되면 반대쪽 환자의 가족관계도 수정한다.
	 * 
	 * @param famVO 가족관계 정보가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateFamilyTheOtherSide(FamilyVO famVO);
	
	/**
	 * 환자 가족관계 삭제
	 * 
	 * @param famVO 삭제할 가족관계의 환자 번호와 가족 환자 번호가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFamily(FamilyVO famVO);
	
	/**
	 * 가족관계 삭제되면 반대쪽 환자의 가족관계도 삭제한다.
	 * 
	 * @param famVO 삭제할 가족관계의 환자 번호와 가족 환자 번호가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFamilyTheOtherSide(FamilyVO famVO);
	
}
