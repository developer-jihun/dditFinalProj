package com.web.ddentist.ddit.pdoctorIntro.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.PdoctorIntroMapper;
import com.web.ddentist.vo.IntroduceVO;

@Service
public class PdoctorIntroServiceImpl implements PdoctorIntroService {

	@Autowired
	PdoctorIntroMapper pMapper;
	
	@Override
	public List<IntroduceVO> pdoctorIntro(IntroduceVO intVO) {
		return this.pMapper.pdoctorIntro(intVO);
	}

	
	
}
