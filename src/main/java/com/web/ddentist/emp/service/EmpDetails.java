package com.web.ddentist.emp.service;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.web.ddentist.vo.EmployeeVO;

public class EmpDetails extends User {
	
	private static final long serialVersionUID = 8163264528533257966L;
	
	private EmployeeVO empVO;

	public EmpDetails(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public EmpDetails(EmployeeVO empVO) {
		super(empVO.getEmpId(), empVO.getEmpPw(), empVO.getAuthList().stream().map((auth) -> new SimpleGrantedAuthority(auth.getEmpAuthrt())).collect(Collectors.toList()));
		this.empVO = empVO;
	}

	public EmployeeVO getEmpVO() {
		return empVO;
	}

	public void setEmpVO(EmployeeVO empVO) {
		this.empVO = empVO;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "EmpDetails [empVO=" + empVO + "]";
	}
	
}
