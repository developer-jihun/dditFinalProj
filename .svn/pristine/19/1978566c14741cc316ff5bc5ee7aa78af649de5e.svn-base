package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.DepartmentVO;
import com.web.ddentist.vo.EmployeeVO;
import com.web.ddentist.vo.JbgdVO;

public interface StatisticsMapper {

	/**
	 * 재직 여부 공통코드 조회
	 *
	 * @return 재직 여부 공통코드 VO 목록
	 */
	public List<CommonCodeVO> listHdofYn();

	/**
	 * 직급 코드 목록 조회
	 *
	 * @return 직급 코드 VO 목록
	 */
	public List<JbgdVO> listJbgd();

	/**
	 * 부서 코드 목록 조회
	 *
	 * @return 부서 코드 VO 목록
	 */
	public List<DepartmentVO> listDept();

	/**
	 * 검색 내용과 일치하는 직원 정보 개수 조회
	 *
	 * @param paramMap 재직여부("hdofYn"), 직급("jbgdCd"), 부서("deptCd"), 키워드("keyword")가 담긴 Map
	 * @return 검색 내용과 일치하는 직원 정보의 개수
	 */
	public int totalRow(Map<String, String> paramMap);

	/**
	 * 직원을 검색
	 *
	 * @param paramMap 재직여부("hdofYn"), 직급("jbgdCd"), 부서("deptCd"), 키워드("keyword")가 담긴 Map
	 * @return 검색 내용과 일치하는 직원 정보가 담긴 VO 목록
	 */
	public List<EmployeeVO> listEmp(Map<String, String> paramMap);

	/**
	 * 특정 의사의 월별 진료 환자 수를 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return 월별 진료 환자 수가 담긴 목록. 올해의 1월부터 12월까지.
	 */
	public List<String> selectMonthlyPtCount(String empNum);

	/**
	 * 특정 의사의 월별 수납 금액을 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return 월별 수납 금액이 담긴 목록. 올해의 1월부터 12월까지.
	 */
	public List<String> selectMonthlyGramt(String empNum);

	/**
	 * 특정 의사의 분기별 진료 환자 수를 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return 분기별 진료 환자 수가 담긴 목록.
	 */
	public List<String> selectQuarterlyPtCount(String empNum);

	/**
	 * 특정 의사의 분기별 수납 금액을 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return 분기별 수납 금액이 담긴 목록.
	 */
	public List<String> selectQuarterlyGramt(String empNum);

	/**
	 * 특정 의사의 연도별 진료 환자 수를 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return 연도별 진료 환자 수가 담긴 목록.<br>
	 * 		   "year" : 년도<br>
	 * 		   "ptCount" : 해당 년도의 사용자 수
	 *
	 */
	public List<Map<String, String>> selectYearlyPtCount(String empNum);

	/**
	 * 특정 의사의 연도별 수납 금액을 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return 연도별 수납 금액이 담긴 목록.<br>
	 * 		   "year" : 년도<br>
	 * 		   "ptCount" : 해당 년도의 수납 금액
	 */
	public List<Map<String, String>> selectYearlyGramt(String empNum);

	/**
	 * 월별 약품 발주 금액을 조회한다.
	 *
	 * @return 월별 약품 발주 금액 목록.
	 */
	public List<String> selectHosMonthlyDrugOrderStatistics();

	/**
	 * 분기별 약품 발주 금액을 조회한다.
	 *
	 * @return 분기별 약품 발주 금액 목록.
	 */
	public List<String> selectHosQuarterlyDrugOrderStatistics();

	/**
	 * 연도별 약품 발주 금액을 조회한다.
	 *
	 * @return 연도별 약품 발주 금액 목록.<br>
	 * 		   "year" : 년도<br>
	 * 		   "purCost" : 해당 년도의 수납 금액
	 */
	public List<Map<String, Object>> selectHosYearlyDrugOrderStatistics();
}
