package com.web.ddentist.ddit.pdocument.service;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.DocumentVO;
import com.web.ddentist.vo.RcvmtVO;

public interface IPdocument {

	public List<DocumentVO> getDList(String ptNum);

	public List<DocumentVO> checkBox(DocumentVO documentVO);

	public DocumentVO getReissuance(DocumentVO documentVO);

	public List<DocumentVO> getLockerList(String ptNum);

	public int getMinusUpdate(DocumentVO documentVO);

	public List<DocumentVO> getList(DocumentVO documentVO);

	public String getLockerUpdate(Map<String, String> docData, Map<String, String> docunpaidMap,
			Map<String, String> unpaidMap, Map<String, String> payData);


}
