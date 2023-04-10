package com.web.ddentist.hospital.manage.statistics.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.hospital.manage.empInfo.util.ArticlePage;
import com.web.ddentist.mapper.StatisticsMapper;
import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.DepartmentVO;
import com.web.ddentist.vo.EmployeeVO;
import com.web.ddentist.vo.JbgdVO;

@Service
public class StatisticsServiceImpl implements IStatisticsService {

	@Autowired
	private StatisticsMapper statisticsMapper;


	@Override
	public List<CommonCodeVO> listHdofYn() {
		return statisticsMapper.listHdofYn();
	}

	@Override
	public List<JbgdVO> listJbgd() {
		return statisticsMapper.listJbgd();
	}

	@Override
	public List<DepartmentVO> listDept() {
		return statisticsMapper.listDept();
	}

	@Override
	public ArticlePage<EmployeeVO> listEmp(Map<String, String> paramMap) {
		int totalRow = statisticsMapper.totalRow(paramMap);
		List<EmployeeVO> empList = statisticsMapper.listEmp(paramMap);
		int page = Integer.parseInt(paramMap.get("page"));
		ArticlePage<EmployeeVO> articlePage = new ArticlePage<>(totalRow, page, 5, empList);
		return articlePage;
	}

	@Override
	public Map<String, List<String>> selectMonthlyStatistics(String empNum) {
		Map<String, List<String>> statMap = new HashMap<>();
		List<String> ptCountList = statisticsMapper.selectMonthlyPtCount(empNum);
		List<String> gramtList = statisticsMapper.selectMonthlyGramt(empNum);
		statMap.put("ptCountList", ptCountList);
		statMap.put("gramtList", gramtList);
		return statMap;
	}

	@Override
	public Map<String, List<String>> selectQuarterlyStatistics(String empNum) {
		Map<String, List<String>> statMap = new HashMap<>();
		List<String> ptCountList = statisticsMapper.selectQuarterlyPtCount(empNum);
		List<String> gramtList = statisticsMapper.selectQuarterlyGramt(empNum);
		statMap.put("ptCountList", ptCountList);
		statMap.put("gramtList", gramtList);
		return statMap;
	}

	@Override
	public Map<String, Object> selectYearlyStatistics(String empNum) {
		Map<String, Object> statMap = new HashMap<>();
		List<Map<String, String>> ptCountList = statisticsMapper.selectYearlyPtCount(empNum);
		List<Map<String, String>> gramtList = statisticsMapper.selectYearlyGramt(empNum);
		statMap.put("ptCountList", ptCountList);
		statMap.put("gramtList", gramtList);
		return statMap;
	}

	@Override
	public List<String> selectHosMonthlyDrugOrderStatistics() {
		return statisticsMapper.selectHosMonthlyDrugOrderStatistics();
	}

	@Override
	public List<String> selectHosQuarterlyDrugOrderStatistics() {
		return statisticsMapper.selectHosQuarterlyDrugOrderStatistics();
	}

	@Override
	public List<Map<String, Object>> selectHosYearlyDrugOrderStatistics() {
		return statisticsMapper.selectHosYearlyDrugOrderStatistics();
	}
}
