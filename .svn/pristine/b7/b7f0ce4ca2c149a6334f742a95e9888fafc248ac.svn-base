package com.web.ddentist.hospital.manage.empInfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.DepartmentVO;
import com.web.ddentist.vo.EmployeeVO;
import com.web.ddentist.vo.JbgdVO;

public interface IEmpInfoService {
	// 직원 등록
	public int createEmp(EmployeeVO employeeVO);

	// 사번 자동생성
	public String getEmpNum();
	
	// 직원 정보 조회
	public EmployeeVO getEmpInfo(EmployeeVO empVO);

	// 직원 정보 수정
	public int updateEmp(EmployeeVO employeeVO);

	// 직원 정보 삭제
	public int deleteEmp(EmployeeVO employeeVO);
	
	// 직급 리스트
	public List<JbgdVO> getJbgd();
	
	// 부서 리스트
	public List<DepartmentVO> getDept();
	
	// 부서 추가
	public int createDept(DepartmentVO departmentVO);

	// 부서 삭제
	public int deleteDept(DepartmentVO departmentVO);
	
	// 부서 수정
	public int updateDept(DepartmentVO departmentVO);

	// 직급 추가
	public int createJbgd(JbgdVO jbgdVO);
	
	// 직급 수정
	public int updateJbgd(JbgdVO jbgdVO);
	
	// 직급 삭제
	public int deleteJbgd(JbgdVO jbgdVO);
	
	// 공통코드
	public List<CommonCodeVO> getCommon(String commGrCd);
	
	// 검색키워드와 페이징처리 결과 직원목록 가져오기
	public List<EmployeeVO> getList(Map<String, String> param);
	
	// 직원 사진 삭제
	public int deleteFile(EmployeeVO employeeVO);

	// 검색값에 따른 전체 행의 수
	public int getTotal(Map<String, String> param);

	// 비밀번호 변경
	public int changePassword(EmployeeVO vo);
	
	/**
	 * 직원 아이디 중복 검사
	 * 
	 * @param employeeVo 검사하고자 하는 아이디가 담긴 VO 
	 * @return 사용가능 : "SUCCESS", 중복 : "FAILED"
	 */
	public String checkId(EmployeeVO employeeVo);
	

}
