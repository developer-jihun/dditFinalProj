package com.web.ddentist.hospital.chart.controller;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.hospital.chart.service.IChartService;
import com.web.ddentist.vo.CheckupVO;
import com.web.ddentist.vo.PiVO;
import com.web.ddentist.vo.QuestionnaireVO;
import com.web.ddentist.vo.RegistVO;
import com.web.ddentist.vo.ReservationVO;
import com.web.ddentist.vo.TxNextVO;
import com.web.ddentist.vo.TxPlanVO;
import com.web.ddentist.vo.TxVO;

@Controller
@RequestMapping("/hospital/chart")
public class ChartController {

	@Autowired
	private IChartService chartService;

	@GetMapping("")
	public String home(Model model) {
		model.addAttribute("dataMap", chartService.initChartData());
		return "hospital/chart";
	}

	@ResponseBody
	@PostMapping("/insertPi")
	public String insertPi(@ModelAttribute PiVO piVO) {
		return chartService.insertPi(piVO);
	}

	@ResponseBody
	@PostMapping("/insertTxPlan")
	public String insertTxPlan(@ModelAttribute TxPlanVO txpVO) {
		return chartService.insertTxPlan(txpVO);
	}

	@ResponseBody
	@PostMapping("/insertTx")
	public String insertTx(@ModelAttribute TxVO txVO) {
		return chartService.insertTx(txVO);
	}

	@ResponseBody
	@PostMapping("/insertTxNext")
	public String insertTxNext(@ModelAttribute TxNextVO txnVO) {
		return chartService.insertTxNext(txnVO);
	}

	@ResponseBody
	@GetMapping("/listRegist")
	public List<RegistVO> listReg(){
		return chartService.listRegist();
	}

	@ResponseBody
	@GetMapping("/listResv")
	public List<ReservationVO> listResv(){
		return chartService.listResv();
	}

	@ResponseBody
	@PostMapping("/insertCheckup")
	public String insertCheckup(@ModelAttribute CheckupVO chkVO) {
		return chartService.insertCheckup(chkVO);
	}

	@ResponseBody
	@PostMapping("/stopCheckup")
	public String stopCheckup(@RequestBody CheckupVO chkVO) {
		return chartService.stopCheckup(chkVO);
	}

	@ResponseBody
	@PostMapping("/completeCheckup")
	public String completeCheckup(@RequestBody CheckupVO chkVO) {
		return chartService.completeCheckup(chkVO);
	}

//	@ResponseBody
//	@GetMapping("/listChart")
//	public Map<String, Object> listChart(@RequestParam String ptNum) {
//		return chartService.listChart(ptNum);
//	}
	@ResponseBody
	@GetMapping("/listChart")
	public List<CheckupVO> listChart(@RequestParam String ptNum) {
		return chartService.listChart(ptNum);
	}

	@ResponseBody
	@GetMapping("/listMedicalAlerts")
	public QuestionnaireVO listMedicalAlerts(@RequestParam String ptNum) {
		return chartService.listMedicalAlerts(ptNum);
	}

	@ResponseBody
	@PostMapping("/deletePi")
	public String deletePi(@RequestBody PiVO piVO) {
		return chartService.deletePi(piVO);
	}

	@ResponseBody
	@PostMapping("/deleteTxPlan")
	public String deleteTxPlan(@RequestBody TxPlanVO txpVO) {
		return chartService.deleteTxPlan(txpVO);
	}

	@ResponseBody
	@PostMapping("/deleteTx")
	public String deleteTxPlan(@RequestBody TxVO txVO) {
		return chartService.deleteTx(txVO);
	}

	@ResponseBody
	@PostMapping("/deleteTxNext")
	public String deleteTxPlan(@RequestBody TxNextVO txnVO) {
		return chartService.deleteTxNext(txnVO);
	}

	@ResponseBody
	@GetMapping("/listCheckupCost")
	public List<TxVO> listCheckupCost(@RequestParam String chkNum) {
		return chartService.listCheckupCost(chkNum);
	}


	@ResponseBody
	@GetMapping("/selectToothHist")
	public List<TxVO> selectToothHist(@RequestParam Map<String, String> searchMap){
		return chartService.selectToothHist(searchMap);
	}

}
