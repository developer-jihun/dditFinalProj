package com.web.ddentist.hospital.manage.empInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.web.ddentist.hospital.manage.empInfo.service.IDrugService;
import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.NoticeVO;
import com.web.ddentist.vo.PageVO;
import com.web.ddentist.vo.PurchaseVO;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;
/**
 * 병원 관리 메뉴 - 약품관리 페이지
 * @author 송지훈
 *
 */
@Slf4j
@RequestMapping("hospital/drug")
@Controller
public class DrugInfoController {
	
	@Autowired
	IDrugService drugService;
	
	//요청URI : /hospital/drug
	@GetMapping("")
	public String main() {
		
		return "hospital/drug";
	}
	
	//페이징 적용
	//요청URI : /hospital/drug
//	@GetMapping("")
//	public ModelAndView main(ModelAndView mav,
//			@RequestParam(value="currentPagePurchasing", required=false, defaultValue = "1") int currentPagePurchasing) {
//		
//		//발주 중 페이징==========================================================
//		 //검색 조건
//	    Map<String,String> map = new HashMap<String, String>();
//	    
//	    //1) 발주 중 전체 행의 수 구하기(purchasingTotal)
//	    int total = this.drugService.getTotal();
//
//	    //3) 한 페이지에 보여질 행의 수(size)
//	    int size = 10;
//
//	    //map{"size":"10","currentPage":"1"}
//	    map.put("size", size+"");
//	    map.put("currentPage", currentPage+"");
//	    log.info("map : " + map);
//
//	    List<NoticeVO> noticeVOList = this.pNoticeService.beforePaginglist(map);
//	    log.info("noticeVOList : " + noticeVOList);
//	    
//	    int blockSize = 5;
//	    
//	    PageVO<NoticeVO> pageVONoticeList = new PageVO<NoticeVO>(total, currentPage, size, noticeVOList, blockSize);
//	    log.info("pageVONoticeList.getContent() : " + pageVONoticeList.getContent());
//	    
//	    
//	    //페이징 data
//	    mav.addObject("data",pageVONoticeList);
//	    mav.addObject("map",map);
//	    //발주 중 페이징=============================================================
//	    
//	    
//	    mav.setViewName("ddit/notice");
//		
//		
//		return mav;
//	}
	
	
	
	
	
	//약품 정보 리스트 리턴
	//요청 URI : /hospital/drug/showMd
	//요청파라미터 : "/hospital/drug/showMd?keyword=" + keyword
	//요청방식 : get
	//응답데이터타입 : json
	@ResponseBody
	@GetMapping("/showMd")
	public List<DrugVO> showMd(@RequestParam String keyword){
		log.info("keyword : " + keyword);
		
		//발주 약품 검색
		List<DrugVO> list = this.drugService.showMd(keyword);
		
		return list;
	}
	
	//요청파라미터 : //data : {"purCost":"26","PurchaseDrugList":[{"drugNum":"201103366","purDrugCount":"2"},{"drugNum":"201103628","purDrugCount":"4"}]}
	@ResponseBody
	@PostMapping("/purchase")
	public PurchaseVO purchase(@RequestBody PurchaseVO purchaseVO) {
		//purchaseVO : PurchaseVO [purNum=null, purCost=26, purDt=null, purStatus=null, 
//		purchaseDrugList=[PurchaseDrugVO [purDrugSn=0, purNum=null, drugNum=201100501, drugNm=null, purDrugCount=2], 
//		                  PurchaseDrugVO [purDrugSn=0, purNum=null, drugNum=201103628, drugNm=null, purDrugCount=4]]]
		log.info("purchaseVO : " + purchaseVO);
		
		// 1:N 등록
		int result = this.drugService.purchase(purchaseVO);
		
		log.info("result : " + result);
//		log.info("purchaseVO after : " + purchaseVO);
		
		if(result>0) {//성공
			//PURCHASE 테이블에 PUR_NUM이 P20230306003인 1행을 select해서 
			//mybatis에서는 resultMap으로 처리(1:N)
			purchaseVO = this.drugService.selectPurchase(purchaseVO);
			log.info("purchaseVO select : " + purchaseVO);
		}
		//발주 번호, 발주 예상 비용, 발주 일시, 발주 상태
		//P20230306003	14	2023/03/06	1
		return purchaseVO;
	}
	
	@ResponseBody
	@PostMapping("/cancelPurchase")
	public String cancelPurchase (@RequestBody PurchaseVO purchaseVO) {
		return this.drugService.cancelPurchase(purchaseVO);
	}
	
	//발주 상태 변경
	//요청 URI : /hospital/drug/updateStatus
	//요청 파라미터 : /hospital/drug/updateStatus?purchaseNum=P20230307074
	//요청방식 : get
	//응답데이터타입 : json
	@ResponseBody
	@GetMapping("/updateStatus")
	public Map<String, String> updateStatus(@RequestParam String purchaseNum) {
		
//		int result = this.drugService.
		
		log.info("purchaseNum : " + purchaseNum);
		
		Map<String, String> resultMap = new HashMap<String, String>();
		
		
		return resultMap;
	}
	
	//발주 중 목록 초기 데이터 넣어주기
	//요청URI : /hospital/drug/showPurchasing
	//요청방식 : get
	@ResponseBody
	@GetMapping("/showPurchasing")
	public List<PurchaseVO> showPurchasing(){
		
		List<PurchaseVO> purchaseVOList = this.drugService.showPurchasing();
		log.info("purchaseVOList : " + purchaseVOList);
		
		return purchaseVOList;
	}
	
	//발주 중 목록 초기 데이터 넣어주기
	//요청URI : /hospital/drug/showPurchased
	//요청방식 : get
	@ResponseBody
	@GetMapping("/showPurchased")
	public List<PurchaseVO> showPurchased(){
		
		List<PurchaseVO> purchaseVOList = this.drugService.showPurchased();
		log.info("purchaseVOList : " + purchaseVOList);
		
		return purchaseVOList;
	}
	
	//재고수, 상태 변경 및 발주 완료 목록 가져오기
	//요청 URI : /hospital/drug/updateCount
	//요청 파라미터 : {"purNum" : purchaseNum}
	//요청방식 : post
	//응답데이터타입 : json
	@ResponseBody
	@PostMapping("/updateCount")
	public List<PurchaseVO> updateCount(@RequestBody PurchaseVO purchaseVO) {
		//{"purNum":"P20230307088", ...모두 null}
		log.info("purchaseVO : " + purchaseVO);
		
		//{"purNum":"P20230307088", ...모두 채워짐}
		List<PurchaseVO> purchaseVOList = this.drugService.updateCount(purchaseVO);
		log.info("purchaseVOList : " + purchaseVOList);
		
		return purchaseVOList; 
	}

	//재고수, 상태 변경 및 발주 중 목록 가져오기
	//요청 URI : /hospital/drug/reupdateCount
	//요청 파라미터 : {"purNum" : purchaseNum}
	//요청방식 : post
	//응답데이터타입 : json
	@ResponseBody
	@PostMapping("/reupdateCount")
	public List<PurchaseVO> reupdateCount(@RequestBody PurchaseVO purchaseVO) {
		//PurchaseVO [purNum=P20230308-004, purCost=0, purDt=null, purStatus=null, purchaseDrugList=null]
		log.info("purchaseVO : " + purchaseVO);
		
		//{"purNum":"P20230307088", ...모두 채워짐}
		List<PurchaseVO> purchaseVOList = this.drugService.reupdateCount(purchaseVO);
		log.info("===List<PurchaseVO> : " + purchaseVOList);
		
		return purchaseVOList; 
	}
	
	//요청 URI : /hospital/drug/purchasePeriod
	@ResponseBody
	@PostMapping("/purchasePeriod")
	public List<PurchaseVO> purchasePeriod(@RequestBody PurchaseVO purchaseVO){
		log.info("들어옴 ");
		log.info("purchaseVO : "+ purchaseVO);
		log.info("시작 : "+ purchaseVO.getStartDate());
		log.info("끝  : "+ purchaseVO.getEndDate());
//		log.info("map : ", map);
//		log.info("startDate,endDate : ", startDate,endDate);
		
		
		List<PurchaseVO> list = this.drugService.purchasePeriod(purchaseVO);
//		list.add(purchaseVO);
		log.info("list : "+ list);
		return list;
	}




}









