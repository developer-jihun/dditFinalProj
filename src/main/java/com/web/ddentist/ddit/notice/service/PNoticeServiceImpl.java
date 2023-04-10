package com.web.ddentist.ddit.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.PnoticeMapper;
import com.web.ddentist.vo.NoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PNoticeServiceImpl implements IPNoticeService {
	@Autowired
	PnoticeMapper pnoticeMapper;
	
//	<!-- 전체 행의 수(total) -->
//	<select id="getTotal" resultType="int">
	@Override
	public int getTotal() {
		return this.pnoticeMapper.getTotal();
	};
	
//	<!-- 파라미터로 받은 정보로 페이징처리하기 -->
	@Override
//	<select id="beforePaginglist" parameterType="hashMap" resultType="noticeVO">
	public List<NoticeVO> beforePaginglist(Map<String, String> map){
		return this.pnoticeMapper.beforePaginglist(map);
	}
	
//	<!-- 상세 정보 조회 -->
//	<select id="noticeDetail" parameterType="noVO" resultType="noVO">
	@Override
	public NoticeVO noticeDetail(NoticeVO noticeVO) {
		NoticeVO vo = this.pnoticeMapper.noticeDetail(noticeVO);
		log.info("vo : " + vo);
		return vo;
	}



}
