package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.ChatMemberVO;
import com.web.ddentist.vo.ChatVO;
import com.web.ddentist.vo.ChatgroupVO;
import com.web.ddentist.vo.EmployeeVO;

public interface ChatMapper {

	/**
	 * 직원이 속한 채팅그룹 목록을 가져옴
	 *
	 * @param empNum 직원 번호
	 * @return 채팅그룹 VO 목록
	 */
	public List<ChatgroupVO> chatgrpList(String empNum);

	/**
	 * 채팅그룹의 채팅 내용을 가져옴
	 *
	 * @param chatgrpNum 채팅 그룹 번호
	 * @return 채팅내용 VO 목록
	 */
	public List<ChatVO> chatList(String chatgrpNum);

	/**
	 * 채팅 내용을 DB에 저장함
	 *
	 * @param chatVO 직원 번호, 직원 명, 직원 아이디, 채팅그룹 번호, 채팅 내용이 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int chat(ChatVO chatVO);

	/**
	 * 직원이 속한 채팅그룹 번호를 가져옴
	 *
	 * @param empNum 직원 번호
	 * @return 채팅그룹 번호 목록
	 */
	public List<Integer> chatgrpNum(String empNum);

	/**
	 * 채팅 서버에 접속한 직원의 정보를 가져옴
	 *
	 * @param empId 직원 계정 아이디
	 * @return 직원 정보 VO
	 */
	public EmployeeVO empInfo(String empId);

	/**
	 * 직원의 특정 채팅그룹에서의 마지막 확인 시간을 현재로 갱신함
	 *
	 * @param ChatMemberVO 직원 번호와 채팅그룹 번호가 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateLastReadDate(ChatMemberVO chatMemVO);

	/**
	 * 새 채팅그룹을 생성하거나 채팅 멤버를 초대하기 위해 직원 목록을 가져옴
	 *
	 * @param param 직원 번호와 채팅그룹 번호가 담긴 Map
	 * @return 직원 번호, 직원 명의 VO가 담긴 목록
	 */
	public List<EmployeeVO> empList(Map<String, String> param);

	/**
	 * 새 채팅그룹 생성
	 *
	 * @param chatgrpVO 채팅그룹명이 담긴 VO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int createNewChat(ChatgroupVO chatgrpVO);

	/**
	 * 채팅그룹에 새 멤버들을 추가함
	 *
	 * @param chatMemList 추가할 채팅멤버 목록
	 * @return 성공 : 1 이상, 실패 : 0
	 */
	public int insertChatMem(List<ChatMemberVO> chatMemList);

	/**
	 * 새로 초대된 직원들의 이름을 가져옴
	 *
	 * @param chatMemList 새로 추가된 채팅멤버의 직원 번호, 채팅그룹 번호가 담긴 VO 목록
	 * @return 직원 번호, 채팅그룹 번호, 직원 명이 담긴 VO 목록
	 */
	public List<ChatMemberVO> listInsertedChatMem(Map<String, Object> chatMemList);

	/**
	 * 현재 채팅그룹에 속해있는 멤버 목록 조회
	 *
	 * @param chatgrpNum 채팅그룹 번호
	 * @return 채팅그룹에 속해있는 멤버들의 목록
	 */
	public List<EmployeeVO> listChatMem(int chatgrpNum);

	/**
	 * 직원이 채팅그룹에서 퇴장함
	 *
	 * @param chatMemVO 직원 번호와 채팅그룹 번호가 담긴 VO
	 * @return 성공 : 1, 실패 0
	 */
	public int exitChatgrp(ChatMemberVO chatMemVO);
	
	/**
	 * 채팅그룹에서 퇴장한 멤버의 직원 정보 가져옴
	 * 
	 * @param chatMemVO 직원 번호가 담긴 VO
	 * @return 직원 번호, 직원 명이 담긴 VO
	 */
	public ChatMemberVO selectExitedMem(ChatMemberVO chatMemVO);
	
}
