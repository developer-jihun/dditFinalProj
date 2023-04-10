package com.web.ddentist.vo;

//발주 약품
public class PurchaseDrugVO {
	private int purDrugSn;
	private String purNum;
	private int drugNum;
	private String drugNm;
	private int purDrugCount;
	
	public PurchaseDrugVO() {}

	public int getPurDrugSn() {
		return purDrugSn;
	}

	public void setPurDrugSn(int purDrugSn) {
		this.purDrugSn = purDrugSn;
	}

	public String getPurNum() {
		return purNum;
	}

	public void setPurNum(String purNum) {
		this.purNum = purNum;
	}

	public int getDrugNum() {
		return drugNum;
	}

	public void setDrugNum(int drugNum) {
		this.drugNum = drugNum;
	}

	public String getDrugNm() {
		return drugNm;
	}

	public void setDrugNm(String drugNm) {
		this.drugNm = drugNm;
	}

	public int getPurDrugCount() {
		return purDrugCount;
	}

	public void setPurDrugCount(int purDrugCount) {
		this.purDrugCount = purDrugCount;
	}

	@Override
	public String toString() {
		return "PurchaseDrugVO [purDrugSn=" + purDrugSn + ", purNum=" + purNum + ", drugNum=" + drugNum + ", drugNm="
				+ drugNm + ", purDrugCount=" + purDrugCount + "]";
	}
	
	
	
	
}
