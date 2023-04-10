package com.web.ddentist.ddit.receipt.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.ddit.receipt.service.IPreceiptService;
import com.web.ddentist.hospital.rcvmt.service.IRcvmtService;
import com.web.ddentist.vo.ReceiptVO;

@Controller()
@RequestMapping("/ddit/receipt")
@PreAuthorize("hasRole('ROLE_PT')")
public class PreceiptController {
	
	@Autowired
	private IPreceiptService receiptService;
	
	@Autowired
	private IRcvmtService rcvmtService;
	
	@GetMapping("")
	public String home(Model model) {
		List<ReceiptVO> rctList = receiptService.listReceipt();
		model.addAttribute("rctList", rctList);
		return "ddit/receipt";
	}
	
	@GetMapping("/patientRcvmtWindow")
	public String patientRcvmtWindow(Model model,
			@ModelAttribute ReceiptVO rctVO) {
		ReceiptVO data = rcvmtService.selectRctHist(rctVO);
		
		model.addAttribute("rctVO", data);
		
		return "/hospital/rcvmtWindow";
	}
	
	@ResponseBody
	@GetMapping("/selectReceipt")
	public ReceiptVO selectReceipt(@RequestParam int rctNum) {
		return receiptService.selectReceipt(rctNum);
	}
	
	@ResponseBody
	@GetMapping("/searchReceipt")
	public List<ReceiptVO> searchReceipt(@RequestParam Map<String, String> paramMap){
		return receiptService.searchReceipt(paramMap);
	}
	
}
