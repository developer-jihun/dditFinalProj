package com.web.ddentist.hospital.manage.empInfo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.annotation.JsonAppend.Attr;
import com.web.ddentist.hospital.manage.empInfo.service.ITxManagementService;
import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.TxCodeVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 병원 관리 메뉴 - 처치 관리 페이지
 * @author 송지훈
 *
 */
@Slf4j
@RequestMapping("hospital/txCode")
@Controller
public class TxManagementController {
	
	@Autowired
	ITxManagementService txManagementService;
	
	@GetMapping("")
	public String main(Model model) {
		log.info("초기 리스트 가져오기 : ");
		
		//초기 리스트 가져오기
		List<TxCodeVO> list = this.txManagementService.list();
		
		model.addAttribute("txCodeList", list);
		
		return "hospital/txManagement";
	}
	
	//진료 처치 상세내용 및 처치 약품 등록하기
	//요청URI : /hospital/txCode/insertPost
	@ResponseBody
	@PostMapping("/insertPost")
	public Map<String, Object> insertPost(@RequestBody TxCodeVO txCodeVO) {
		log.info("추가하기 왔다!");
		//TxCodeVO(txcCd=s1234, txcNm=불면증, txcPrice=230000)
		log.info("txCodeVO : " + txCodeVO);
		
		int result = this.txManagementService.insert(txCodeVO);

		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result>0) {
			
			map.put("message","성공적으로 추가되었습니다.");
			
			map.put("txCodeVO", txCodeVO);
			
			
		}
		return map;
		
	}
	
	//상세조회 삭제하기
	//요청URI : /hospital/txCode/deletePost
	@ResponseBody
	@PostMapping("/deletePost")
	public Map<String, Object> deletePost(@RequestBody TxCodeVO txCodeVO) {
		log.info("삭제하기 왔다!");
		//TxCodeVO(txcCd=s1234, txcNm=불면증, txcPrice=230000)
		log.info("txCodeVO : " + txCodeVO);
		
		int result = this.txManagementService.deletePost(txCodeVO);

		Map<String, Object> map = new HashMap<String, Object>();
		
		log.info("result : " + result);
		
		if(result>0) {
			
			map.put("txCodeVO", txCodeVO);
			
			map.put("message","성공적으로 삭제되었습니다.");
			
		}
		
		return map;
		
	}
	
	//상세조회 수정하기
	//요청URI : /hospital/txCode/updatePost
	//요청 파라미터  : data : txCodeVO : TxCodeVO(txcCd=b1234333, txcNm=기면증333, txcPrice=234555333
		//, dataDrugNum=197500185,197500272,197900574, drugNum=null, TxDrugList=null)
	@ResponseBody		  
	@PostMapping("/updatePost")
	public Map<String, Object> updatePost(@RequestBody TxCodeVO txCodeVO) {
		log.info("수정하기 왔다!");
		//TxCodeVO(txcCd=s1234, txcNm=불면증, txcPrice=230000)
		log.info("txCodeVO : " + txCodeVO);
		
		int result = this.txManagementService.updatePost(txCodeVO);
		log.info("result : " + result);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result>0) {
			
			map.put("message","성공적으로 수정되었습니다.");
			
			log.info("txCodeVO jsp로 보내기 전 : " + txCodeVO);
			
			map.put("txCodeVO", txCodeVO);
		}
		
		return map;
		
	}
	
	//처치 코드 중복 체크
	//요청URI : /hospital/txCode/doubleCheck
	@ResponseBody
	@GetMapping("/doubleCheck")
	public Map<String, String> doubleCheck(@RequestParam String txcCd) {
		log.info("controller txcCd : " + txcCd);
		String message = "";
		//있는지 조회하기
		int result = this.txManagementService.detail(txcCd);
		log.info("result count : " + result);
		
		if(result>0) {
			message ="*코드를 사용할 수 없습니다.";
		}else {
			message ="*코드를 사용할 수 있습니다.";
			
		}
		log.info("message : " + message);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("message", message);
		
		
		return map;
	}
	
	//약품 상세조회 (1건)
	//요청 URI :/hospital/txCode/drugDetail?drugNum="+drugNum
	@ResponseBody
	@GetMapping("/drugDetail")
	public DrugVO drugDetail(@RequestParam int drugNum) {
		log.info("drugNum : " + drugNum);
		
		DrugVO vo = this.txManagementService.drugDetail(drugNum);
		log.info("vo : " + vo);
		
		return vo;
		
		
	}
	
	
	/*
	 1. 즐겨찾기 메뉴판 같은 것

	2. 등록한 처치 방법을 진료할 때 실제로 사용할 수 있음
	
	3. 처치에 등록 된 여러개의 약품은 재료와 같은 거라서
	   실제 처치 시 사용될 약품을 미리 지정해 놓은 것임
	 */
	//진료 처치 관련 처치 약품 조회 (N건)
	//요청URI : /hospital/txCode/selectDrugList"
	//요청파라미터 : let data = {"txcCd":code};
	@ResponseBody
	@PostMapping("/selectDrugList")
	public List<DrugVO> selectDrugList(@RequestBody TxCodeVO txCodeVO){
		//TxCodeVO(txcCd=b1234333, txcNm=null, txcPrice=0, dataDrugNum=null, drugNum=null, TxDrugList=null)
		log.info("txCodeVO : " +txCodeVO );

		List<DrugVO> list = this.txManagementService.selectDrugList(txCodeVO.getTxcCd());
		
		log.info("list : " + list);
//		List<DrugVO> list = null;
		
		return list;
	}
	
	//요청URI : "/hospital/txCode/keywordSearch"
	//요청파라미터 : let data = {"kewyword":keyword};
	@ResponseBody
	@GetMapping("/keywordSearch")
	public List<TxCodeVO> keywordSearch(@RequestParam String keyword){
		log.info("keyword : " + keyword);
		
		List<TxCodeVO> list = this.txManagementService.txDrugList(keyword);
		log.info("list : " + list);
		
		return list;
		
		
	}
	
}
