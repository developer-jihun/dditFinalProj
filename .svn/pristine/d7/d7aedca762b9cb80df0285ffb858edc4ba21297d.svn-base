package com.web.ddentist.mapper;

import java.util.List;

import com.sun.javafx.collections.MappingChange.Map;
import com.web.ddentist.ddit.inquiry.util.InqPaginationVO;
import com.web.ddentist.vo.InquiryVO;

public interface InquiryMapper {
	
	/**
	 * 문의게시판의 목록을 불러오는 메서드
	 * @param pagingInqVO 
	 * @return inqVO를 객체로 하는 List
	 */
	public List<InquiryVO> getAllList(InqPaginationVO<InquiryVO> inqPageVO);
	
	/**
	 * 선택한 게시물의 상세보기 페이지데이터를 가져오는 메서드
	 * @param inqVO 
	 * @return (AnswerVO를 포함한)InquiryVO
	 */
	public InquiryVO selectInq(InquiryVO inqVO);
	
	/**
	 * 선택한 게시물의 순번데이터를 받아 해당게시물을 삭제하는 메서드
	 * @param inqVO
	 * @return 삭제성공 = 1, 삭제실패 = 0
	 */
	public int deleteInq(InquiryVO inqVO);
	
	/**
	 * 작성자의 데이터, 제목, 내용을 받아 게시글 데이터를 집어넣는 메서드(삽입,수정)
	 * @param inqVO
	 * @return 처리성공 = 1, 처리실패 = 0
	 */
	public int createInq(InquiryVO inqVO);
	
	/**
	 * 게시물 수정버튼 클릭시 게시물의 원본데이터를 가져온다.
	 * @param inqVO
	 * @return 게시물의 데이터가 담긴 InquiryVO
	 */
	public InquiryVO modifyInq(InquiryVO inqVO);
	
	/**
	 * inqNum가 일치하는 게시물의 비밀번호(inqPw)가 parameter값의 password와 일치하는지 확인하는 메서드
	 * @param inqVO
	 * @return 일치 : 1, 불일치 : 0
	 */
	public int getPassword(InquiryVO param);

	/**
	 * 페이징을 위해 전체 게시물의 수를 가져온다.
	 * @param searchWord 
	 * @return 전체 게시물 수
	 */
	public int getTotal(String searchWord);
	
}
