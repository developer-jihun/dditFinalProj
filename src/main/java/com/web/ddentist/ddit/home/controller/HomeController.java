package com.web.ddentist.ddit.home.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.ddit.home.service.HomeServiceImpl;
import com.web.ddentist.ddit.home.service.IHomeService;
import com.web.ddentist.vo.BannerVO;
import com.web.ddentist.vo.IntroduceVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	IHomeService iHomeService;
	
	@GetMapping(value= {"", "/ddit"})
	public String home(Model model) {
		log.info("----------------------------------------------------------");
		log.info(System.getProperty("user.dir").replace("\\eclipse", ""));
		log.info("----------------------------------------------------------");
		
		//배너 이미지 가져오기
		List<BannerVO> bannerVOList = this.iHomeService.getImgs();
		model.addAttribute("bannerVOList", bannerVOList);
		
		List<IntroduceVO> introVOList=this.iHomeService.introVOList();
		model.addAttribute("introVOList", introVOList);
		
		return "ddit/home";
	}
	
	@ResponseBody
	@GetMapping("/ddit/banner")
	public List<BannerVO> banner() {
		
		//배너 ajax로 이미지 가져오기
		List<BannerVO> bannerVO = this.iHomeService.getImgs();
		log.info("bannerVO : " + bannerVO);
		
		return bannerVO;
	}
	
	@GetMapping("/login")
	public String login() {
		return "login/selectLogin";
	}
	

	
}
