package com.web.ddentist.hospital.site.faqInfo.service;

import java.util.List;

import com.web.ddentist.vo.FaqVO;

public interface IFaqService {

//	<!-- 자주 묻는 질문 전체 목록 -->
//	<select id="faqList" resultType="faqVO">
	public List<FaqVO> getFaqList();

//	<!-- 자주 묻는 질문 등록하기 -->
//	<insert id="insertFaq" parameterType="faqVO">
	public FaqVO insertFaq(FaqVO faqVO);

//	<!-- 문의글 수정하기 -->
//	<update id="updateFaq" parameterType="faqVO">
	public FaqVO updateFaq(FaqVO faqVO);

//	<!-- 문의 번호에 따른 행 한 줄 가져오기 -->
//	<select id="getInfo" parameterType="faqNum" resultType="faqVO">
	public FaqVO getInfo(FaqVO faqVO);

//	<!-- 문의글 삭제하기 -->
//	<delete id="deleteFaq" parameterType="faqVO">
	public int deleteFaq(FaqVO faqVO);

//	<!-- 페이징처리를 위한 총 게시글 수 조회 -->
//	<select id="faqGetTotal" parameterType="faqVO"  resultType="int">
	public int faqGetTotal(FaqVO faqVO);
	
//	<!-- 페이징처리를 위한 총 게시글 목록 조회 -->
//	   <select id="faqPageGetList" parameterType="faqVO" resultType="faqVO">
	public List<FaqVO> faqPageGetList(FaqVO faqVO);
	
	

}
