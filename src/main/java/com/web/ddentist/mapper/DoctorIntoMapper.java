package com.web.ddentist.mapper;

import java.util.List;

import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.vo.DiseaseVO;
import com.web.ddentist.vo.IntroduceVO;

public interface DoctorIntoMapper {

	
	//의사 전체 조회
	public List<IntroduceVO> doctorIntroMain();

	//의사 선택 조회
	public IntroduceVO doctorSelect(IntroduceVO intVO);
	
	//정보 저장
	public int doctorSave(IntroduceVO intVO);

	//의사 검색
	public List<DiseaseVO> doctorSearch(String keyword);



}
