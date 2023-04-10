package com.web.ddentist.ddit.pcheckup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.PcheckupMapper;
import com.web.ddentist.vo.CheckupVO;

@Service
public class PcheckupServiceImpl implements PcheckupService{
	
	@Autowired
	PcheckupMapper PcheckupMapper;
	
	@Override
	public List<CheckupVO> pCheckupList(Map<String, String> ptInfo) {
		return this.PcheckupMapper.pCheckupList(ptInfo);
	}

	@Override
	public CheckupVO detailCheckup(CheckupVO checkupVO) {
		return this.PcheckupMapper.detailCheckup(checkupVO);
	}
	
	
}
