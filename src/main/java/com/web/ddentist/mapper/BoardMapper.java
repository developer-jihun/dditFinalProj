package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.AnswerVO;
import com.web.ddentist.vo.InquiryVO;
import com.web.ddentist.vo.NoticeVO;

public interface BoardMapper {
	
	/**
	 * 공지사항 목록 조회
	 * 
	 * @param searchMap 키워드, 시작 날짜, 종료 날짜가 담긴 Map
	 * @return 공지사항 목록
	 */
	public List<NoticeVO> listNotice(Map<String, String> searchMap);
	
	/**
	 * 공지사항 내용 조회
	 * 
	 * @param noNum 공지사항 번호
	 * @return 공지사항
	 */
	public NoticeVO selectNotice(String noNum);
	
	/**
	 * 공지사항 추가
	 * 
	 * @param noVO 공지사항 제목, 공지사항 내용
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertNotice(NoticeVO noVO);
	
	/**
	 * 공지사항 수정
	 * 
	 * @param noVO 수정할 공지사항 번호, 공지사항 제목, 공지사항 내용
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateNotice(NoticeVO noVO);
	
	/**
	 * 공지사항 삭제
	 * 
	 * @param noVO 삭제할 공지사항 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteNotice(NoticeVO noVO);
	
	/**
	 * 문의게시판 조회
	 * 
	 * @param searchMap 키워드, 시작 날짜, 종료 날짜
	 * @return 문의글 목록
	 */
	public List<InquiryVO> listInquiry(Map<String, String> searchMap);
	
	/**
	 * 문의글 내용 조회
	 * 
	 * @param inqNum 문의글 번호
	 * @return 문의글
	 */
	public InquiryVO selectInquiry(String inqNum);
	
	/**
	 * 답변 추가
	 * 
	 * @param ansVO 답변을 추가할 문의글 번호, 답변 제목, 답변 내용
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertAnswer(AnswerVO ansVO);
	
	/**
	 * 답변 수정
	 * 
	 * @param ansVO 답변을 수정할 문의글 번호, 답변 제목, 답변 내용
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateAnswer(AnswerVO ansVO);
	
	/**
	 * 문의글 및 답변 삭제
	 * 
	 * @param inqVO 삭제할 문의글과 답변의 문의글 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteInquiryAnswer(InquiryVO inqVO);
	
}
