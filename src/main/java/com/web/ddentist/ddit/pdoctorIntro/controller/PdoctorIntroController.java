package com.web.ddentist.ddit.pdoctorIntro.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.ddentist.ddit.pdoctorIntro.service.PdoctorIntroService;
import com.web.ddentist.hospital.site.doctorIntro.controller.DoctorIntroController;
import com.web.ddentist.hospital.site.doctorIntro.service.DoctorIntroService;
import com.web.ddentist.vo.IntroduceVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/ddit/pdoctorIntro")
public class PdoctorIntroController {

	@Autowired
	PdoctorIntroService pService;

	//의사 전체 조회
	@GetMapping("")
	public String doctorIntroMain(@ModelAttribute IntroduceVO intVO, Model model) {
	
		List<IntroduceVO> doctorList=this.pService.pdoctorIntro(intVO);
		
		model.addAttribute("doctorList",doctorList);
		
		log.info("doctorList:"+doctorList);
		
		return "ddit/pdoctorIntro";
	}
	
}
