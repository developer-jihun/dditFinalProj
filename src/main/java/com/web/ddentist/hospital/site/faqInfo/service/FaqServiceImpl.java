package com.web.ddentist.hospital.site.faqInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.FaqMapper;
import com.web.ddentist.vo.FaqVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FaqServiceImpl implements IFaqService {
	
	@Autowired
	FaqMapper faqMapper;
	
//	<!-- 자주 묻는 질문 전체 목록 -->
//	<select id="faqList" resultType="faqVO">
	@Override
	public List<FaqVO> getFaqList(){
		List<FaqVO> list = this.faqMapper.getFaqList();
		log.info("list : " + list);
		return list;
	};
	
//	<!-- 자주 묻는 질문 등록하기 -->
//	<insert id="insertFaq" parameterType="faqVO">
	@Override
	public FaqVO insertFaq(FaqVO faqVO) {
		log.info("faqVO : " + faqVO);
		//등록하기
		int result = this.faqMapper.insertFaq(faqVO);
		log.info("result : " + result);
		log.info("after faqVO : " + faqVO);
		//등록한 한 행 가져오기
		FaqVO vo = null;
		if(result>0) {
			vo = this.faqMapper.getInfo(faqVO);
		}
		return vo;
		
	};
	
//	<!-- 문의글 수정하기 -->
//	<update id="updateFaq" parameterType="faqVO">
	@Override
	public FaqVO updateFaq(FaqVO faqVO) {
		log.info("faqVO : " + faqVO);
		//수정하기
		int result = this.faqMapper.updateFaq(faqVO);
		log.info("after faqVO : " + faqVO);
		//수정한 한 행 가져오기
		faqVO = this.faqMapper.getInfo(faqVO);
		log.info("get faqVO : " + faqVO);
		return faqVO;
	};

	
//	<!-- 문의 번호에 따른 행 한 줄 가져오기 -->
//	<select id="getInfo" parameterType="faqNum" resultType="faqVO">
	@Override
	public FaqVO getInfo(FaqVO faqVO) {
		return this.faqMapper.getInfo(faqVO);
	};
	
//	<!-- 문의글 삭제하기 -->
//	<delete id="deleteFaq" parameterType="faqVO">
	@Override
	public int deleteFaq(FaqVO faqVO) {
		return this.faqMapper.deleteFaq(faqVO);
	};
	
//	<!-- 페이징처리를 위한 총 게시글 수 조회 -->
//	<select id="faqGetTotal" parameterType="faqVO"  resultType="int">
	@Override
	public int faqGetTotal(FaqVO faqVO) {
		return this.faqMapper.faqGetTotal(faqVO);
	};
	

	@Override
	public List<FaqVO> faqPageGetList(FaqVO faqVO) {
		// TODO Auto-generated method stub		
		return this.faqMapper.faqPageGetList(faqVO);
	};
	
}
