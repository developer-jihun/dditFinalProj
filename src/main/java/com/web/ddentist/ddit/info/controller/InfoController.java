package com.web.ddentist.ddit.info.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ddit/info")
public class InfoController {
	
	@GetMapping("")
	public String home() {
		return "ddit/info";
	}
	
}
