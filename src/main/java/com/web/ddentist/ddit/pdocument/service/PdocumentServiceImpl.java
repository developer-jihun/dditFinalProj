package com.web.ddentist.ddit.pdocument.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.PdocumentMapper;
import com.web.ddentist.vo.DocumentVO;
import com.web.ddentist.vo.RcvmtVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PdocumentServiceImpl implements IPdocument {

	@Autowired
	PdocumentMapper pdocumentMapper;
	
	@Override
	public List<DocumentVO> getDList(String ptNum) {
		return pdocumentMapper.getDList(ptNum);
	}

	@Override
	public List<DocumentVO> checkBox(DocumentVO documentVO) {
		return pdocumentMapper.checkBox(documentVO);
	}

	@Override
	public DocumentVO getReissuance(DocumentVO documentVO) {
		return pdocumentMapper.getReissuance(documentVO);
	}

	@Override
	public String getLockerUpdate(Map<String, String> docData, Map<String, String> docunpaidMap, Map<String, String> unpaidMap, Map<String, String> paydata) {
		
		log.info("서비스로 왔다");
		log.info("Service docunpaidMap>>>>>>>>>>"+docunpaidMap);
		
		int result = 0;
		
		result = this.pdocumentMapper.docUpdate(docData); //서류 발급 정보 수정
		
		if(result <= 0) {
			return "false";
		}
		
		log.info("서류 발급 정보 result>>>>>>>>>>"+result);
		
		result = this.pdocumentMapper.unpaid(unpaidMap); //수납, id="docunpaid"의 keyproperty 리턴받음
		
		if(result <= 0) {
			return "false";
		}
		
		String rcvmtNum = unpaidMap.get("rcvmtNum"); //selectkey를 쓰면 리턴값이 parameter값에 저장된다
		
		log.info(">>>>>>>>>>>>>>unpaidMap"+unpaidMap);
		log.info(">>>>>>>>>>>>>>rcvmtNum"+rcvmtNum);
		
		docunpaidMap.put("rcvmtNum", rcvmtNum);
		
		result = this.pdocumentMapper.docunpaid(docunpaidMap); //서류 수납
		
		log.info(">>>>>>>>>docunpaidMap"+docunpaidMap);
		log.info("서류 수납 result>>>"+result);
		
		if(result <= 0) {
			return "false";
		}
		
		paydata.put("rcvmtNum", rcvmtNum);
		
		result = this.pdocumentMapper.docPay(paydata); //결제
		
		log.info(">>>>>>>>>>rctNum"+paydata.get("rctNum"));
		
		if(result <= 0) {
			return "false";
		}

		log.info("서비스 끝!!!!!!!!!!!");
		
		return paydata.get("rctNum");
	}

	@Override
	public List<DocumentVO> getLockerList(String ptNum) {
		return pdocumentMapper.getLockerList(ptNum);
	}

	@Override
	public int getMinusUpdate(DocumentVO documentVO) {
		return pdocumentMapper.getMinusUpdate(documentVO);
	}

	@Override
	public List<DocumentVO> getList(DocumentVO documentVO) {
		return pdocumentMapper.getList(documentVO);
	}



}
