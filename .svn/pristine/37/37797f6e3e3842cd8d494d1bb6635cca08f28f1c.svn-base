package com.web.ddentist.ddit.pdocument.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.ddit.pdocument.service.IPdocument;
import com.web.ddentist.patient.service.PatientDetails;
import com.web.ddentist.vo.DocumentVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ddit/document")
public class PdocumentController {

//	세션 정보 불러오기
	
	@Autowired
	private IPdocument dService;
	
	@PreAuthorize("hasRole('ROLE_PT')")
	@GetMapping("")
	public String getDocument(DocumentVO documentVO, Model model) {
		
		PatientDetails ptInfo = (PatientDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String ptNum = ptInfo.getPtVO().getPtNum();
		
		log.info("!!!!!!!!!!!!!ptNum:"+ptNum);
		
		List<DocumentVO> docList = this.dService.getDList(ptNum);
		
		model.addAttribute("docList",docList);
		
		log.info("docList:"+docList);
		
		return "ddit/pdocument";
	}
	
	@PreAuthorize("hasRole('ROLE_PT')")
	@ResponseBody
	@PostMapping("/checkbox")
	public List<DocumentVO> checkBox(@RequestBody DocumentVO documentVO) {
		
		PatientDetails ptInfo = (PatientDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String ptNum = ptInfo.getPtVO().getPtNum();
		documentVO.setPtNum(ptNum);
		
		log.info("documentVO : " + documentVO);
		
		List<DocumentVO> checkBox = this.dService.checkBox(documentVO);
		
		return checkBox;
		
	}
	
	@PreAuthorize("hasRole('ROLE_PT')")
	@GetMapping("/reissuance")
	public String getReissuance(DocumentVO documentVO, Model model) {
		
		log.info("reissue에 왔다");
		
		documentVO=this.dService.getReissuance(documentVO);
		log.info("documentVO reissuance : "  + documentVO);
		
		model.addAttribute("documentVO",documentVO);
		
		return "ddit/pdocumentReissuance";
	}
	
	@ResponseBody
	@PostMapping("/pdocUpdate")
	public String pdocUpdate(@RequestBody Map<String, String> listMap) {
		
		log.info("listMap>>>>"+listMap);
		
		Map<String,String> docData = new HashMap<>(); //서류 발급
		docData.put("docIssueNum",listMap.get("docIssueNum"));
		docData.put("docIssueNmtm", listMap.get("docIssueNmtm"));

		log.info(">>>>docData"+docData);
		
		Map<String,String> docunpaidMap = new HashMap<>(); //서류 수납
		docunpaidMap.put("docIssueNum",listMap.get("docIssueNum"));
		docunpaidMap.put("docIssueNmtm", listMap.get("docIssueNmtm"));
		
		log.info(">>>>docunpaidMap"+docunpaidMap);
		
		Map<String,String> unpaidMap = new HashMap<>(); //수납
		unpaidMap.put("ptNum",listMap.get("ptNum")); //차트번호
		unpaidMap.put("mix",listMap.get("mix")); //총금액 및 수납금액
		
		log.info(">>>>unpaidMap"+unpaidMap);
		
		Map<String,String> payData = new HashMap<>(); //결제
		payData.put("rctCardNum",listMap.get("rctCardNum")); //카드번호
		payData.put("mix",listMap.get("mix")); //결제금액
		payData.put("rctCardComp",listMap.get("rctCardComp")); //카드사
		payData.put("rctAcceptNum", listMap.get("rctAcceptNum")); //승인번호
		
		log.info(">>>>payData"+payData);

		this.dService.getLockerUpdate(docData, docunpaidMap, unpaidMap ,payData);

		log.info(">>>>서비스까지 지난 payData"+payData);
		
		return payData.get("rctNum");
	}
	
	@PreAuthorize("hasRole('ROLE_PT')")
	@GetMapping("/pdocumentLocker")
	public String pdocumentLocker(DocumentVO documentVO, Model model) {
		
		PatientDetails ptInfo = (PatientDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String ptNum = ptInfo.getPtVO().getPtNum();
		
		log.info("!!!!!!!!ptNum:"+ptNum);
		log.info("!!!!!!!!pdocumentLocker documentVO:"+documentVO);
		
		List<DocumentVO> LockerList = this.dService.getLockerList(ptNum); //서류보관함 리스트
		
		model.addAttribute("LockerList",LockerList);
		
		log.info("---------LockerList:"+LockerList);
		
		return "ddit/pdocumentLocker";
		
	}
	
	@ResponseBody
	@PostMapping("/pdocumentUpdate")
	public List<DocumentVO> pdocumentUpdate(@RequestBody DocumentVO documentVO) {
		
		log.info("---------------DocumentVO:"+documentVO);
		
		int result=this.dService.getMinusUpdate(documentVO); //발급횟수 -1
		
		log.info("-----------------------result:"+result);
		
		List<DocumentVO> getList=this.dService.getList(documentVO); //발급횟수 후 다시 리스트 띄우기
		
		log.info("------------getList:"+getList);
		
		return getList;
		
	}
	
}

