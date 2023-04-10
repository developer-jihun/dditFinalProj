package com.web.ddentist.ddit.checkupGuide.service;

import java.util.Map;

public interface ICheckupGuideService {
	
	/**
	 * 영업 시작 ~ 영업 종료 시간과 접수 마감 시간을 가져옴
	 * 
	 * @return 영업 시간표가 담긴 Map<br>
	 * 		   평일/주말 영업 시작 시간 : "hiOpenTime"<br>
	 * 		   평일 휴식 시작 시간 : "hiLunchStime"<br>
	 * 		   평일 휴식 종료 시간 : "hiLunchEtime"<br>
	 * 		   평일 접수 마감 시간 : "hiDayRcvmtEtime"<br>
	 * 		   평일 진료 마감 시간 : "hiCloseTime"<br>
	 * 		   주말 접수 마감 시간 : "hiWeekEndRcvmtEtime"<br>
	 * 		   주말 진료 마감 시간 : "hiLunchEtime"
	 */
	public Map<String, String> selectHiServiceTime();
	
}
