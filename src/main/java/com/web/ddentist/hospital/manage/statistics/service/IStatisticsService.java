package com.web.ddentist.hospital.manage.statistics.service;

import java.util.List;
import java.util.Map;

import com.web.ddentist.hospital.manage.empInfo.util.ArticlePage;
import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.DepartmentVO;
import com.web.ddentist.vo.EmployeeVO;
import com.web.ddentist.vo.JbgdVO;

public interface IStatisticsService {

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
	 * 직원을 검색
	 *
	 * @param paramMap 재직여부("hdofYn"), 직급("jbgdCd"), 부서("deptCd"), 키워드("keyword")가 담긴 Map
	 * @return 검색 내용과 일치하는 직원 정보와 페이지 정보가 담긴 ArticlePage 객체
	 */
	public ArticlePage<EmployeeVO> listEmp(Map<String, String> paramMap);

	/**
	 * 특정 의사의 월별 진료 환자 수와 월별 수납 금액을 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return "ptCountList" : 월별 진료 환자 수가 담긴 목록.<br>
	 * 		   "gramtList" : 월별 수납 금액이 담긴 목록.<br>
	 * 		   올해의 1월부터 12월까지.
	 */
	public Map<String, List<String>> selectMonthlyStatistics(String empNum);

	/**
	 * 특정 의사의 분기별 진료 환자 수와 분기별 수납 금액을 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return "ptCountList" : 분기별 진료 환자 수가 담긴 목록.<br>
	 * 		   "gramtList" : 분기별 수납 금액이 담긴 목록.
	 */
	public Map<String, List<String>> selectQuarterlyStatistics(String empNum);

	/**
	 * 특정 의사의 연도별 진료 환자 수와 연도별 수납 금액을 조회한다.
	 *
	 * @param empNum 직원 번호
	 * @return "ptCountList" : 연도별 진료 환자 수가 담긴 목록.<br>
	 * 		   "gramtList" : 연도별 수납 금액이 담긴 목록.
	 */
	public Map<String, Object> selectYearlyStatistics(String empNum);

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
