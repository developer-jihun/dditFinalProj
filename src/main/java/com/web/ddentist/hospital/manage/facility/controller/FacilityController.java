package com.web.ddentist.hospital.manage.facility.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.hospital.manage.facility.service.IFacilityService;
import com.web.ddentist.vo.ChairVO;
import com.web.ddentist.vo.DepartmentVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hospital/manage/facility")
public class FacilityController {
	
	@Autowired
	IFacilityService facilityService;
	
	@GetMapping("")
	public String detail(Model model) {
		log.info("병원 시설관리 페이지에 왔다!!!");
		
	
		
		return "hospital/facility";
	}
	
	
	
}
