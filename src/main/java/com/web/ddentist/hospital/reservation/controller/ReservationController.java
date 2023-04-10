package com.web.ddentist.hospital.reservation.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.hospital.reservation.service.ReservationService;
import com.web.ddentist.vo.HospitalInfoVO;
import com.web.ddentist.vo.ReservationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hospital/resv")
@Controller
public class ReservationController {
	
	@Autowired
	ReservationService service;
	
	/**
	 * 예약 메인 페이지
	 * @return
	 */
	@GetMapping("")
	public String cal() {
		return "hospital/reservation";
	}
	
	/**
	 * 전체 예약 리스트 불러오기
	 * @param dateMap 예약을 불러올 기간이 담긴 Map
	 * @return 예약 정보가 담긴 List를 반환
	 */
	@ResponseBody
	@GetMapping("/list")
	public List<Map<String, Object>> getAllList2(
			@RequestParam Map<String, String> dateMap
			) {
		log.info("DateMap : " + dateMap);
		
		List<ReservationVO> resvList = this.service.getAllList(dateMap);
		log.info("resvationlist : " + resvList);
		
		String resv = "#32CD32";		//예약중 색상			// 초록
		String resvCom = "#4169E1";		//예약이행 색상			// 파랑
		String resvInc = "#808080";		//예약미이행 색상		// 회색
		String resvDan = "#DC143C";		//예약미이행 3회 초과 색상 // 빨강

		List<Map<String, Object>> resvMap = new ArrayList<>();
		for(ReservationVO vo : resvList) {
			Map<String, Object> map = new HashMap<>();
			String resvColor = resv;
			
			// 기본
			map.put("title", vo.getPtNm());			// 환자 이름
			map.put("start", vo.getResvSdt() );		// 시작 시간
			map.put("end", vo.getResvEdt() );		// 종료 시간
			// 커스텀
			map.put("resvNum", vo.getResvNum());	// 예약번호	
			map.put("ptPhone", vo.getPtPhone() );	// 환자 번호
			map.put("ptNum", vo.getPtNum());		// 환자 번호
			map.put("ptNm", vo.getPtNm());			// 환자 이름
			map.put("resvCc", vo.getResvCc());		// 호소 증상
			map.put("empNum", vo.getEmpNum());		// 직원 번호
			map.put("empNm", vo.getEmpNm());		// 직원 이름
			map.put("status", vo.getResvStatus());	// 예약 상태
			map.put("statNm", vo.getStatNm());		// 예약 상태 한글명
			
			if(vo.getStatNm().equals("예약이행")) {
				resvColor = resvCom;
			} else if(vo.getStatNm().equals("예약미이행")) {
				resvColor = resvInc;
			} else {
				if(vo.getPtNm().substring(0, 1).equals("!")) {
					resvColor = resvDan;
				}
			}
			map.put("backgroundColor", resvColor);
			map.put("borderColor", resvColor);	

			// 타입 아직 없음
			
			resvMap.add(map);
		}
		log.info("resvMap : " + resvMap);
		
		return resvMap;
	}
	
	/**
	 * 예약 정보가 담긴 vo
	 * @param vo 이름, 전화번호, 호소증상, 시작 날짜, 종료 날짜, 의사, 경과 시간
	 * @return 성공시 1 , 실패시 0 반환
	 */
	@ResponseBody
	@PostMapping("/create")
	public int create(@RequestBody ReservationVO vo) {
		return this.service.create(vo);
	}
	
	/**
	 * 예약 상태 변경
	 * @param param 상태를 변경할 예약 번호
	 * @return 성공시 1, 실패시 0 반환
	 */
	@ResponseBody
	@PostMapping("/changeStat")
	public int changeStat(@RequestBody Map<String, String> param) {
		log.info("changeStat : " + param);
		
		int result = this.service.changeStat(param);
		
		log.info("예약 취소 result : " + result);
		
		return result;
	}
	
	/**
	 * 휴식시간 시작 과 끝 시간을 가져온다
	 * @return 오픈시간과 휴식 시간이 담긴 Map
	 */
	@ResponseBody
	@GetMapping("/openTime")
	public HospitalInfoVO OpenTime(){
		HospitalInfoVO openInfo = null;
		openInfo = this.service.openTime();
		
		if(openInfo.getHiLunchEtime() == null) {
			openInfo = new HospitalInfoVO();
			openInfo.setHiOpenTime("07:00");
			openInfo.setHiCloseTime("22:00");
			openInfo.setHiLunchStime("12:00");
			openInfo.setHiLunchEtime("13:30");
		}
		return openInfo;
	}
	
	/**
	 * 병원 오픈 시간부터 마감시간까지 30분 단위로 나눠 가져온다
	 * 휴식시간 시작 과 끝 시간을 가져온다
	 * @return 오픈시간이 담긴 리스트, 휴식시간이 담긴  List
	 */
	@ResponseBody
	@GetMapping("/resvPossible")
	public List<String> resvPossible(@RequestParam String resvDay){
		log.info("resvDate : " + resvDay);
		
		HospitalInfoVO openInfo = this.service.openTime();
		List<String> openTime = new ArrayList<>();
		if(openInfo == null) {
			openInfo = new HospitalInfoVO();
			openInfo.setHiOpenTime("07:00");
			openInfo.setHiCloseTime("22:00");
			openInfo.setHiLunchStime("12:00");
			openInfo.setHiLunchEtime("13:30");
		}
		
		String[] hiOpenTime = openInfo.getHiOpenTime().split(":");
		log.info("HI_OPEN_TIME1 : " + hiOpenTime[0]);
		log.info("HI_OPEN_TIME2 : " + hiOpenTime[1]);
		String[] hiLunchStime = openInfo.getHiLunchStime().split(":");
		String[] hiLunchEtime = openInfo.getHiLunchEtime().split(":");
		String[] hiCloseTime = openInfo.getHiCloseTime().split(":");
		
		int start = Integer.parseInt(hiOpenTime[0] + hiOpenTime[1]);
		int smiddle = Integer.parseInt(hiLunchStime[0] + hiLunchStime[1]);
		int emiddle = Integer.parseInt(hiLunchEtime[0] + hiLunchEtime[1]);
		int end = Integer.parseInt(hiCloseTime[0] + hiCloseTime[1]);
		log.info("start : " + start);
		
		// 오늘 날짜라면 현재 시간 이후부터 시작
		LocalDate today = LocalDate.now();
		if(resvDay.equals(today.toString())) {
			LocalTime time = LocalTime.now();
					
			start = time.getHour() * 100;
			start += (time.getMinute() >= 30) ? 100 : 30; 
		}
		
		int[] resvSplit = Stream.of(resvDay.split("-")).mapToInt(Integer::parseInt).toArray();
		// 1. LocalDate 생성
        LocalDate date = LocalDate.of(resvSplit[0], resvSplit[1], resvSplit[2]);
 
        // 2. DayOfWeek 객체 구하기
        DayOfWeek dayOfWeek = date.getDayOfWeek();
 
        // 3. 숫자 요일 구하기
        // 날짜가 토요일이라면 점심시간 전 까지만 운영
        int dayOfWeekNumber = dayOfWeek.getValue();
        if(dayOfWeekNumber == 6) {
        	end = smiddle;
        }
        
		int idx = 0;
		// 루프 내부에서 루프 흐름을 제어하는 코딩은 좋은 방향이 아니다.
		for(int i = start; i <= end; i += 30) {
			String min = i % 100 + "";
			min = min.equals("0") ? "00" : min; 
			if(i % 100 >= 60) {
				i += 100;
				i /= 100;
				i *= 100;
				min = "00";
			}
			int hour = i / 100;
			
			if(i > smiddle && i < emiddle) {
				continue;
			}
			if(i < 1000) {
				openTime.add(idx++,"0" + hour + ":" + min);
			} else {
				openTime.add(idx++,hour + ":" + min);
			}
		}
		log.info("openTime : " + openTime);
		
		return openTime;
	}
	
	/**
	 * 현재 날짜보다 이전 날짜의 데이터들중 
	 * 상태가 예약 이행, 예약 취소가 아닌 항목은 예약 미이행으로 상태 변경
	 * @return 예약 미이행으로 변환 된 예약 건수
	 */
	@ResponseBody
	@GetMapping("/previousRes")
	public int previousRes() {
		return this.service.previousRes();
	}
	
	/**
	 * 전체 의사 목록 가져오기, 예약 상태 가져오기
	 * @return 의사 목록이 담긴 리스트, 예약 상태 리스트
	 */
	@ResponseBody
	@GetMapping("/empInfo")
	public Map<String ,List<Map<String, String>>> empInfo(){
		List<Map<String, String>> empList = this.service.empInfo();
		List<Map<String, String>> resvStatList = this.service.resvState();
		Map<String ,List<Map<String, String>>> empRev = new HashMap<>();
		empRev.put("empList",empList);
		empRev.put("resvStatList",resvStatList);
		
		return empRev;
	}
	
	/**
	 * 예약이 있는 의사 목록 가져오기
	 * @param param 시작 시간, 종료시간
	 * @return 의사 목록이 담긴 리스트
	 */
	@ResponseBody
	@GetMapping("/selectOption")
	public List<String> selectOption(@RequestParam Map<String, Date> param) {
		log.info("예약 시간 : " + param);
		List<String> list = new ArrayList<>();
		
		if(param == null || param.size() == 0) {
			return list;
		}
		
		list = this.service.selectOption(param);
		
		log.info("예약이 있는 의사 목록 : " + list);
		
		return list;
	}
	
}
