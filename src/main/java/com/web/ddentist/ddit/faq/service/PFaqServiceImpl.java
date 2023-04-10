package com.web.ddentist.ddit.faq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.FaqMapper;
import com.web.ddentist.vo.FaqVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PFaqServiceImpl implements IPFaqService {
	
	@Autowired
	FaqMapper faqMapper;
	
//	<!-- 자주 묻는 질문 전체 목록 -->
//	<select id="getFaqList" resultType="faqVO">
	@Override
	public List<FaqVO> getFaqList(){
		return this.faqMapper.getFaqList();
	};
	
//	<!-- 페이징처리를 위한 총 게시글 수 조회 -->
//	<select id="faqGetTotal" parameterType="faqVO"  resultType="int">
	@Override
	public int faqGetTotal(FaqVO faqVO) {
		log.info("service faqGetTotal faqVO:"+faqVO);
		int result = this.faqMapper.faqGetTotal(faqVO);
		log.info("result :"+result);
		return result;
	};
	
//	<!-- 페이징처리를 위한 총 게시글 목록 조회 -->
//	   <select id="faqPageGetList" parameterType="faqVO" resultType="faqVO">
	@Override
	public List<FaqVO> faqPageGetList(FaqVO faqVO){
		log.info("service faqPageGetList faqVO:"+faqVO);
		List<FaqVO> list = this.faqMapper.faqPageGetList(faqVO);
		log.info("list:"+list);
		return list;
	};
}









