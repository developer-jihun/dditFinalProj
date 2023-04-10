package com.web.ddentist.hospital.manage.statistics.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.hospital.manage.empInfo.util.ArticlePage;
import com.web.ddentist.hospital.manage.statistics.service.IStatisticsService;
import com.web.ddentist.vo.EmployeeVO;

@Controller
@RequestMapping("/hospital/manage/statistics")
public class StatisticsController {


	@Autowired
	private IStatisticsService statisticsService;

	@GetMapping("")
	public String home(Model model) {
		model.addAttribute("hdofYnList", statisticsService.listHdofYn());
		model.addAttribute("jbgdList", statisticsService.listJbgd());
		model.addAttribute("deptList", statisticsService.listDept());
		return "hospital/statistics";
	}

	@ResponseBody
	@GetMapping("/listEmp")
	public ArticlePage<EmployeeVO> listEmp(@RequestParam Map<String, String> paramMap){
		return statisticsService.listEmp(paramMap);
	}

	@ResponseBody
	@GetMapping("/selectMonthlyStatistics")
	public Map<String, List<String>> selectMonthlyStatistics(@RequestParam(required = false) String empNum){
		return statisticsService.selectMonthlyStatistics(empNum);
	}

	@ResponseBody
	@GetMapping("/selectQuarterlyStatistics")
	public Map<String, List<String>> selectQuarterlyStatistics(@RequestParam(required = false) String empNum){
		return statisticsService.selectQuarterlyStatistics(empNum);
	}

	@ResponseBody
	@GetMapping("/selectYearlyStatistics")
	public Map<String, Object> selectYearlyStatistics(@RequestParam(required = false) String empNum){
		return statisticsService.selectYearlyStatistics(empNum);
	}

	@ResponseBody
	@GetMapping("/selectHosMonthlyDrugOrderStatistics")
	public List<String> selectHosMonthlyDrugOrderStatistics(){
		return statisticsService.selectHosMonthlyDrugOrderStatistics();
	}

	@ResponseBody
	@GetMapping("/selectHosQuarterlyDrugOrderStatistics")
	public List<String> selectHosQuarterlyDrugOrderStatistics(){
		return statisticsService.selectHosQuarterlyDrugOrderStatistics();
	}

	@ResponseBody
	@GetMapping("/selectHosYearlyDrugOrderStatistics")
	public List<Map<String, Object>> selectHosYearlyDrugOrderStatistics(){
		return statisticsService.selectHosYearlyDrugOrderStatistics();
	}




}
