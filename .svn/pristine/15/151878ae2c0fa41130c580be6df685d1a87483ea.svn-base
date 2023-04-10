package com.web.ddentist.ddit.checkupGuide.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.ddentist.ddit.checkupGuide.service.ICheckupGuideService;

@Controller
@RequestMapping("/ddit/process")
public class CheckupGuideController {
	
	@Autowired
	private ICheckupGuideService checkupGuideService;
	
	@GetMapping("")
	public String home(Model model) {
		Map<String, String> resultMap = checkupGuideService.selectHiServiceTime();
		model.addAttribute("hosInfo", resultMap);
		return "ddit/checkupGuide";
	}
	
}
