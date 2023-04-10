package com.web.ddentist.hospital.site.faqInfo.controller;

import java.util.List;

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

import com.web.ddentist.hospital.site.faqInfo.service.IFaqService;
import com.web.ddentist.vo.FaqVO;
import com.web.ddentist.vo.PageVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hospital/site/faqInfo")
public class faqInfoController {
	
	@Autowired
	IFaqService iFaqService;
	
	//요청URL : /hospital/site/faqInfo
	@GetMapping("")
//	public String main(Model model, @RequestParam(value = "faqNum", defaultValue = "0", required = false) int faqNum) {
	public String main() {
		return "hospital/faq";
	}
	
	//요청URL : /hospital/site/faqList
	@GetMapping(value = {"/faqList"})
	@ResponseBody
	public List<FaqVO> faqList() {
		
		List<FaqVO> list = this.iFaqService.getFaqList();
		
		log.info("list : " + list);
		
		return list;
	}
	
	//요청URL : /hospital/site/faqInfo/getSearchList
	@ResponseBody
	@PostMapping("/getSearchList")
	public PageVO<FaqVO> getSearchList(
//			@RequestParam( name = "currentPage", required=false, defaultValue="1") int currentPage
			@RequestBody FaqVO faqVO) {
		
		log.info("페이징 목록 가져오기 왓따.");
//		log.info("currentPage :"+currentPage);
		log.info("faqVO :"+faqVO);
		
		int currentPage = 0;
		// currentPage Filter
		if(faqVO.getCurrentPage() < 1) {
			currentPage = 1;
		}else {
			currentPage = faqVO.getCurrentPage();
		}
		
		System.out.println(currentPage);
		
		
		//관련 검색어 및 분류에 대한 개수
		int total = this.iFaqService.faqGetTotal(faqVO);
		log.info("total :" + total);
		
		int size = 10;
		int blockSize = 5;
		
		//페이징 처리 시 필요함
		faqVO.setSize(size);
		faqVO.setCurrentPage(currentPage);

//		FaqVO(faqNum=0, faqType=, faqTitle=null, faqContent=null, faqDt=null
		//, keyword=, currentPage=1, size=10)
		log.info("faqVO :" + faqVO);
		//관련 검색어 및 분류에 대한 list
		List<FaqVO> content = this.iFaqService.faqPageGetList(faqVO);
		log.info("content : " + content);
		
		//페이지 적용시키기
		PageVO<FaqVO> vo = new PageVO<FaqVO>(total, currentPage, size, content, blockSize);
		
		vo.setKeyword(faqVO.getKeyword());
		vo.setFaqType(faqVO.getFaqType());
		log.info("vo :" + vo);
		
		return vo;
	};
	
	
	//요청URL : /hospital/site/faqInfo/insertFaq
	@ResponseBody
	@PostMapping("/insertFaq")
	public FaqVO insertFaq(@RequestBody FaqVO faqVO) {
		log.info("등록하기 왔다.");
		log.info("faqVO : " + faqVO);
		
		FaqVO vo = this.iFaqService.insertFaq(faqVO);
		
//		model.addAttribute("faqVO", vo);
		
		return vo;
	}
	
	//요청URL : /hospital/site/faqInfo/updateFaq
	@ResponseBody
	@PostMapping("/updateFaq")
	public FaqVO updateFaq(@RequestBody FaqVO faqVO) {
		log.info("faqVO : " + faqVO);
		
		faqVO = this.iFaqService.updateFaq(faqVO);
		
		log.info("faqVO : " + faqVO);
		
		return faqVO;
	}
	
	//요청URL : /hospital/site/faqInfo/getInfo
	@ResponseBody
	@PostMapping("/getInfo")
	public FaqVO getInfo(@RequestBody FaqVO faqVO) {
		log.info("faqVO : " + faqVO);
		
		faqVO = this.iFaqService.getInfo(faqVO);
		
		log.info("faqVO : " + faqVO);
		
		return faqVO;
	}
	
	//요청URL : /hospital/site/faqInfo/deleteFaq
	@ResponseBody
	@PostMapping("/deleteFaq")
	public int deleteFaq(@RequestBody FaqVO faqVO) {
		log.info("faqVO : " + faqVO);
		
		int result = this.iFaqService.deleteFaq(faqVO);
		
		log.info("result : " + result);
		
		return result;
	}
	
////	<!-- 페이징처리를 위한 총 게시글 수 조회 -->
////	<select id="faqGetTotal" parameterType="faqVO"  resultType="int">
//	public int faqGetTotal(FaqVO faqVO) {
//		log.info("faqVO : " + faqVO);
//		int result = this.iFaqService.faq
//	};
	
	
}
