package com.web.ddentist.ddit.community.service;

import java.util.List;
import java.util.Map;

import org.bouncycastle.asn1.x509.qualified.TypeOfBiometricData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.web.ddentist.emp.service.EmpDetails;
import com.web.ddentist.mapper.CommunityMapper;
import com.web.ddentist.vo.CommunityReplyVO;
import com.web.ddentist.vo.CommunityVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommunityServiceImpl implements ICommunityService {
	
	@Autowired
	CommunityMapper communityMapper;
	
	/**
	 * 커뮤니티 게시글 조회
	 * 
	 * @return 커뮤니티 게시글 목록
	 */
//	@Override
//	public List<CommunityVO> selectList() {
//		return this.communityMapper.selectList();
//	}
	
	/**
	 * 커뮤니티 게시글 상세보기
	 * 
	 * @return 커뮤니티 게시글
	 */
	@Override
	public CommunityVO detail(CommunityVO commVO) {
		return this.communityMapper.detail(commVO);
	}
	
	/**
	 * 게시글 조회수 증가
	 *
	 * @return 커뮤니티 게시글 조회수
	 */
	@Override
	public int viewCount(CommunityVO commVO) {
		return this.communityMapper.viewCount(commVO);
	}
	
	/**
	 * 게시글 수정
	 *
	 * @param 게시글 번호
	 * @return 커뮤니티 게시글 수정결과 1 또는 0
	 */
	public int updatePost(CommunityVO commVO) {
		log.info("commVO : " + commVO);
		//CommunityVO(comNum=0, ptNum=230302002, comTitle=게시글 등록, comContent=<font color="#000000"><span style="background-color: rgb(255, 255, 0);">a</span></font><p></p>, comDt=null, comInqCnt=0, ptNm=null, ptId=dong)
		int result = this.communityMapper.updatePost(commVO);
		log.info("result : " + result);
		return result;
	}
	
	/**
	 * 검색 키워드를 이용해 게시글 총 개수 구하기
	 *
	 * @param 검색 키워드
	 * @return 게시글 개수
	 */
	@Override
	public int getTotal(String keyword) {
		return this.communityMapper.getTotal(keyword);
	}
	
	/**
	 * 검색 키워드를 이용한 페이징 처리
	 *
	 * @param 검색 키워드, 현재페이지, size
	 * @return 게시글 리스트
	 */
	@Override
	public List<CommunityVO> selectList(Map<String, String> map) {
		log.info("map : " + map);
		List<CommunityVO> list = this.communityMapper.selectList(map);		
		log.info("list : " + list);
		return list;
	}
	
	/**
	 * 게시글 등록
	 *
	 * @param 제목, 내용
	 * @return 게시글 등록 결과 1 또는 0
	 */
	@Override
	public int insertPost(CommunityVO commVO) {
		log.info("commVO : "+ commVO);
		int result = this.communityMapper.insertPost(commVO);
		log.info("result : "+ result);
		return result;
	}
	
	/**
	 * 게시글 삭제
	 *
	 * @param 게시글 번호
	 * @return 게시글 삭제 결과 1 또는 0
	 */
//	@Override
//	public int deletePost(int comNum) {
//		int result = this.communityMapper.deleteProcessYn(comNum);  //삭제여부 0->1
//		//쿼리에서 댓글삭제여부가 1인애들만 select 리스트 
//		//1인애들만 불러주는 메소드
//
//		result += this.communityMapper.AlldeleteReply(comNum);
//
//		return result;
//	}
	
	/**
	 * 게시글 댓글 리스트
	 *
	 * @param  게시글 번호
	 * @return 게시글 댓글 리스트
	 */
	@Override
	public List<CommunityReplyVO> getReplyList(int commVO) {
		return this.communityMapper.getReplyList(commVO);
	}
	
	/**
	 * 게시글 댓글 등록
	 *
	 * @param  게시글 번호, 게시글 정보
	 * @return 게시글 댓글 등록 결과
	 */
	@Override
	public int insertReply(CommunityReplyVO replyVO) {
		log.info("replyVO : " + replyVO);
		int result = this.communityMapper.insertReply(replyVO);
		log.info("result : {댓글등록 결과}" + result);
		return result;
	}
	
	/**
	 * 게시글 대댓글 등록
	 *
	 * @param  게시글 번호, 댓글 정보
	 * @return 게시글 댓글 등록 결과 1 또는 0
	 */
	@Override
	public int insertReReply(CommunityReplyVO replyVO) {
		log.info("replyVO : " + replyVO);
		int result = this.communityMapper.insertReReply(replyVO);
		log.info("result : {댓글등록 결과}" + result);
		return result;
	}
	
	/**
	 * 게시글 댓글 삭제
	 *
	 * @param  게시글 번호
	 * @return 게시글 댓글 등록 결과 1 또는 0
	 */
	@Override
	public int deleteReply(CommunityReplyVO replyVO) {
		return this.communityMapper.deleteReply(replyVO);
	}
	
	/**
	 * 직원관리 게시판 : 커뮤니티(생생후기) 목록 조회
	 * 
	 * @param searchMap 키워드, 시작 날짜, 종료 날짜가 담긴 Map
	 * @return 커뮤니티(생생후기) 목록
	 */
	@Override
	public List<CommunityVO> listReview(Map<String, String> searchMap) {
		return this.communityMapper.listReview(searchMap);
	}
	
	/**
	 * 직원관리 게시판 : 커뮤니티(생생후기) 게시글 상세조회
	 * 
	 * @param comNum 커뮤니티 게시글 번호
	 * @return 커뮤니티(생생후기)
	 */
	@Override
	public CommunityVO selectReview(int comNum) {
		CommunityVO vo = this.communityMapper.selectReview(comNum);
		
	    System.out.println(" 상세조회 vo :::" + vo);
	    return vo;
	}
	

	/**
	 * 직원관리 게시판 : 커뮤니티(생생후기) 게시글 답변 등록
	 *
	 * @param  게시글 번호, 댓글 정보
	 * @return 게시글 댓글 등록 결과 1 또는 0
	 */
	@Override
	public List<CommunityReplyVO> insertAnswer(CommunityReplyVO replyVO, int comNum) {
		System.out.println("replyVO {댓글등록 정보 1 : }"+ replyVO);
		System.out.println("comNum : " + comNum);
		EmpDetails empInfo = (EmpDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empNum = empInfo.getEmpVO().getEmpNum();
		replyVO.setEmpNum(empNum);
		System.out.println("replyVO {댓글등록 정보 2 : }"+ replyVO); // 직원번호가 들어온다
		// CommunityReplyVO(replyNum=0, comNum=192, ptNum=null, replyContent=직원답글 등록,
		// replyDt=null, targetReplyNum=0, lvl=1, ptId=null, ptNm=null, empNum=230320001, 
		// empNm=null, empId=null, patientVO=null, employeeVO=null)

		int result = this.communityMapper.insertAnswer(replyVO);
		log.info("result : {직원 답변 등록 결과 : }" + result);  // 성공하면 1
		
		List<CommunityReplyVO> replyVOList = this.communityMapper.getReplyList(comNum);
		System.out.println("replyVOList : {등록한 댓글 리스트 목록} " + replyVOList);
		return replyVOList;
		
	}
	
	/**
	 * 회원, 직원관리 게시판 : 커뮤니티(생생후기) 게시글 삭제
	 *
	 * @param  게시글 번호
	 * @return 해당게시글의 삭제여부가 1로 바뀐 후, 해당게시글의 댓글리스트가 삭제된다.
	 */
	@Override
	public int deleteProcessYn(int comNum) {
		int result =  this.communityMapper.deleteProcessYn(comNum);
		
		//쿼리에서 댓글삭제여부가 1인애들만 select 리스트 
		//1인애들만 불러주는 메소드

		result += this.communityMapper.AlldeleteReply(comNum); //해당게시글의 댓글리스트가 삭제된다.

		return result;
	} 
	
	/**
	 * 직원 게시판 : 커뮤니티(생생후기) 게시글 댓글 삭제(한개씩)
	 * 
	 * @param replyVO 댓글 번호, 게시글 번호 
	 * @return 게시글 댓글 삭제 후 게시글 상세조회 요청
	 */
	@Override
	public CommunityVO empAuthDeleteReply(Map<String, Object> map) {
		System.out.println("map : {} " + map);
		
		int result = this.communityMapper.empAuthDeleteReply(map); // 댓글 삭제요청
		System.out.println("댓글 삭제 결과 : {} " + result);
		
		int comNum =Integer.parseInt(String.valueOf(map.get("comNum")));
		CommunityVO commVO=  this.communityMapper.selectReview(comNum);
		System.out.println("댓글 삭제 후 게시글 상세정보 : {} "+ commVO);
		
		return commVO;
	}
	
	
}
