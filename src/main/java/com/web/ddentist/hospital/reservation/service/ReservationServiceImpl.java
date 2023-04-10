package com.web.ddentist.hospital.reservation.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.ReservationMapper;
import com.web.ddentist.vo.HospitalInfoVO;
import com.web.ddentist.vo.ReservationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	ReservationMapper calendarMapper;
	
	@Override
	public int create(ReservationVO vo) {
		return this.calendarMapper.create(vo);
	};
	
	@Override
	public List<ReservationVO> getAllList(Map<String, String> map){
		return this.calendarMapper.getAllList(map);
	};

	@Override
	public int changeStat(Map<String, String> map) {
		return this.calendarMapper.changeStat(map);
	};
	
	@Override
	public List<Map<String, String>> empInfo(){
		return this.calendarMapper.empInfo();
	}
	
	@Override
	public List<Map<String, String>> resvState(){
		return this.calendarMapper.resvState();
	}
	
	@Override
	public List<String> selectOption(Map<String, Date> map){
		return this.calendarMapper.selectOption(map);
	};
	
	@Override
	public int previousRes() {
		return this.calendarMapper.previousRes();
	}

	@Override
	public HospitalInfoVO openTime() {
		return this.calendarMapper.openTime();
	}

}	


