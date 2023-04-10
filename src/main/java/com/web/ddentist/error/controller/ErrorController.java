package com.web.ddentist.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {
	
	@GetMapping("/403")
	public String forbidden(Model model){
		model.addAttribute("httpStatus", "403");
		model.addAttribute("statusName", "Forbidden");
		model.addAttribute("statusContent", "접근이 거부되었습니다.");
		return "error/error";
	}
	
	@GetMapping("/404")
	public String notFound(Model model){
		model.addAttribute("httpStatus", "404");
		model.addAttribute("statusName", "Not Found");
		model.addAttribute("statusContent", "요청하신 페이지를 찾을 수 없습니다.");
		return "error/error";
	}
	
	@GetMapping("/500")
	public String internalServerError(Model model){
		model.addAttribute("httpStatus", "500");
		model.addAttribute("statusName", "Internal Server Error");
		model.addAttribute("statusContent", "잠시 후 다시 시도해주세요.");
		return "error/error";
	}
	
}
