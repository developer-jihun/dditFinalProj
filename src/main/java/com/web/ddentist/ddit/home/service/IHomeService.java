package com.web.ddentist.ddit.home.service;

import java.util.List;

import com.web.ddentist.vo.BannerVO;
import com.web.ddentist.vo.IntroduceVO;

public interface IHomeService {
	
//	<!-- 상태가 1인 이미지 가져오기 -->
	public List<BannerVO> getImgs();

	//소개 리스트 가져오기
	public List<IntroduceVO> introVOList();

}
