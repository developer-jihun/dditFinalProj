package com.web.ddentist.ddit.checkupGuide.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.CheckupGuideMapper;
import com.web.ddentist.vo.HospitalInfoVO;

@Service
public class CheckupGuideServiceImpl implements ICheckupGuideService {
	
	@Autowired
	private CheckupGuideMapper checkupGuideMapper;
	
	@Override
	public Map<String, String> selectHiServiceTime() {
		HospitalInfoVO hospitalInfoVO = checkupGuideMapper.selectHiServiceTime();
		Map<String, String> resultMap = new HashMap<>();
		
		resultMap.put("hiOpenTime", hospitalInfoVO.getHiOpenTime());
		String hiCloseTime = hospitalInfoVO.getHiCloseTime();
		resultMap.put("hiCloseTime", hiCloseTime);
		String hiLunchStime = hospitalInfoVO.getHiLunchStime();
		resultMap.put("hiLunchStime", hiLunchStime);
		resultMap.put("hiLunchEtime", hospitalInfoVO.getHiLunchEtime());
		
		// 접수 마감 시간은 영업 종료 30분 전이다.
		String hiDayRcvmtEtime = "";
		String[] timeSplit = hiCloseTime.split(":");
		if(timeSplit[1].equals("00")) {
			String eHour = String.valueOf(Integer.parseInt(timeSplit[0]) - 1);
			String eMinuite = "30";
			hiDayRcvmtEtime = eHour + ":" + eMinuite;
		} else {
			String eHour = timeSplit[0];
			String eMinuite = "00";
			hiDayRcvmtEtime = eHour + ":" + eMinuite;
		}
		resultMap.put("hiDayRcvmtEtime", hiDayRcvmtEtime);
		
		// 주말 접수 마감 시간은 평일 휴식 시작 시간의 30분 전이다.
		String hiWeekEndRcvmtEtime = "";
		String[] weekendTimeSplit = hiLunchStime.split(":");
		if(weekendTimeSplit[1].equals("00")) {
			String eHour = String.valueOf(Integer.parseInt(weekendTimeSplit[0]) - 1);
			String eMinuite = "30";
			hiWeekEndRcvmtEtime = eHour + ":" + eMinuite;
		} else {
			String eHour = weekendTimeSplit[0];
			String eMinuite = "00";
			hiWeekEndRcvmtEtime = eHour + ":" + eMinuite;
		}
		resultMap.put("hiWeekEndRcvmtEtime", hiWeekEndRcvmtEtime);
		
		
		return resultMap; 
	}

}
