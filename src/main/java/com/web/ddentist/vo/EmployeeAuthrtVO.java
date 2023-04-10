package com.web.ddentist.vo;

public class EmployeeAuthrtVO {
	
	private String empAuthrt;
	private String empNum;
	
	
	public String getEmpAuthrt() {
		return empAuthrt;
	}
	public void setEmpAuthrt(String empAuthrt) {
		this.empAuthrt = empAuthrt;
	}
	public String getEmpNum() {
		return empNum;
	}
	public void setEmpNum(String empNum) {
		this.empNum = empNum;
	}
	
	
	@Override
	public String toString() {
		return "EmployeeAuthrtVO [empAuthrt=" + empAuthrt + ", empNum=" + empNum + "]";
	}
}
