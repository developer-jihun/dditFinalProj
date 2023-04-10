package com.web.ddentist.ddit.mypage.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.ddentist.ddit.mypage.service.IMypageService;

@Controller
@RequestMapping("/ddit/mypage")
@PreAuthorize("hasRole('ROLE_PT')")
public class MypageController {
	
	@Autowired
	private IMypageService mypageService;
	
	@GetMapping("")
	public String home() {
		return "ddit/mypage";
	}
	
	@PostMapping("/updatePtInfo")
	public String updatePtInfo(@RequestParam Map<String, String> paramMap, Model model) {
		int result = mypageService.updatePtInfo(paramMap);
		if(result == -1) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "ddit/alertBack";
		}
		
		if(result == 0) {
			model.addAttribute("msg", "잠시 후 다시 시도해주세요.");
			return "ddit/alertBack";
		}
		
		model.addAttribute("msg", "내 정보가 수정되었습니다.");
		model.addAttribute("loc", "/ddit/mypage");
		return "ddit/alert";
	}
	
	@PostMapping("/updatePtPw")
	public String updatePtPw(@RequestParam Map<String, String> paramMap, Model model) {
		int result = mypageService.updatePtPw(paramMap);
		if(result == -1) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "ddit/alertBack";
		}
		
		if(result == 0) {
			model.addAttribute("msg", "잠시 후 다시 시도해주세요.");
			return "ddit/alertBack";
		}
		
		model.addAttribute("msg", "비밀번호가 변경되었습니다.");
		model.addAttribute("loc", "/ddit/mypage");
		return "ddit/alert";
	}
	
}
