package com.web.ddentist.ddit.home.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.HomeInfoMapper;
import com.web.ddentist.vo.BannerVO;
import com.web.ddentist.vo.IntroduceVO;

@Service
public class HomeServiceImpl implements IHomeService{
	
	@Autowired
	HomeInfoMapper homeInfoMapper;
	
//	<!-- 상태가 1인 이미지 가져오기 -->
//	<select id="getImgs" resultType="bannerVO">
	@Override
	public List<BannerVO> getImgs(){
		return this.homeInfoMapper.getImgs();
	}

	@Override
	public List<IntroduceVO> introVOList() {
		return this.homeInfoMapper.introVOList();
	};
}
