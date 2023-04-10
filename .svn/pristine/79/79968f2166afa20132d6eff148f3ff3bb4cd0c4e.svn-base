package com.web.ddentist.patient.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.web.ddentist.mapper.PatientMapper;
import com.web.ddentist.vo.PatientVO;

public class PatientDetailsService implements UserDetailsService {
	
	@Autowired
	private PatientMapper patientMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		PatientVO ptVO = new PatientVO();
		ptVO.setPtId(username);
		ptVO = patientMapper.login(ptVO);
		return ptVO == null ? null : new PatientDetails(ptVO);
	}

}
