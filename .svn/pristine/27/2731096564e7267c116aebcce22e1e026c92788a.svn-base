package com.web.ddentist.ddit.mypage.service;

import java.util.Map;

public interface IMypageService {
	
	/**
	 * 사용자 개인정보 수정
	 * 
	 * @param paramMap 사용자 연락처, 사용자 주소, 사용자 비밀번호가 담긴 Map
	 * @return 성공 : 1, 실패 : 0, 비밀번호 불일치 : -1
	 */
	public int updatePtInfo(Map<String, String> paramMap);
	
	/**
	 * 사용자 비밀번호 변경
	 * 
	 * @param paramMap 사용자의 기존 비밀번호("ptPw")와 새로운 비밀번호("newPtPw")가 담긴 Map
	 * @return 성공 ; 1, 실패 : 0, 비밀번호 불일치 : -1
	 */
	public int updatePtPw(Map<String, String> paramMap);
	
}
