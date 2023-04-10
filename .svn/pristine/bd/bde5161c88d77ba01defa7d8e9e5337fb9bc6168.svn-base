package com.web.ddentist.hospital.manage.empInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.TxManagementMapper;
import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.TxCodeVO;
import com.web.ddentist.vo.TxDrugVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TxManagementServiceImpl implements ITxManagementService {
	
	@Autowired
	TxManagementMapper txManagementMapper;
	
	/**
	 * 
	 * 초기 처치 리스트 가져오기
	 * 
	 * @return List<TxCodeVO>
	 */
	@Override
	public List<TxCodeVO> list(){
		List<TxCodeVO> list = this.txManagementMapper.list();
		
		return list;
	};
	
//	<!-- 처치 등록하기 -->
//	<insert id="insert" parameterType="TxCodeVO">
	@Override
	public int insert(TxCodeVO txCodeVO) {
		
		//상세정보 등록
		int result = this.txManagementMapper.insert(txCodeVO);
		
		log.info("txCodeVO : " + txCodeVO);
		
		if(null != txCodeVO.getDataDrugNum() && !"".equals(txCodeVO.getDataDrugNum())) {
			String[] drugNumArray = txCodeVO.getDataDrugNum().split(",");
			//약품 등록
			for(String drugNum : drugNumArray) {
				TxCodeVO insertVo = new TxCodeVO();
				insertVo.setTxcCd(txCodeVO.getTxcCd());
				insertVo.setDrugNum(drugNum);
				
				log.info("insertVo : " + insertVo);
				
				result += txManagementMapper.insert2(insertVo);
			}
		}
		return result;
	};
	
//	<!-- 처치 삭제하기 -->
//	<delete id="deletePost" parameterType="txcVO">
	@Override
	public int deletePost(TxCodeVO txCodeVO) {
		log.info("deletePost before txCodeVO : " + txCodeVO);
		//상세정보 삭제
		int result = this.txManagementMapper.deletePost(txCodeVO);
		
		log.info("deletePost txCodeVO : " + txCodeVO);
		
		//약품정보 삭제
		result = result + this.txManagementMapper.deleteTxDrug(txCodeVO);
		  
		return result;
//		List<TxCodeVO> list = this.txManagementMapper.list();
//		
//		return list;
		
	};
	
//	<!-- 처치 수정하기 -->
//	<delete id="updatePost" parameterType="txcVO">
	@Override
	public int updatePost(TxCodeVO txCodeVO) {
		log.info("updatePost => txCodeVO : " + txCodeVO);
		
		int result = this.txManagementMapper.updatePost(txCodeVO);
		
		//(/hospital/txCode) 1. 처치약품 삭제 
		result = result + this.txManagementMapper.deleteTxDrug(txCodeVO);
		
		if(txCodeVO.getDataDrugNum()==null||txCodeVO.getDataDrugNum().equals("")) {
			return result;
		}
		
		//(/hospital/txCode) 2. INSERT ALL
		//dataDrugNum=197500185,197500272,197900574,
		String[] dataDrugNumArr = txCodeVO.getDataDrugNum().split(",");
		log.info("dataDrugNumArr.length : " + dataDrugNumArr.length);
		
		List<TxDrugVO> TxDrugList = new ArrayList<TxDrugVO>();
		
		//dataDrugNum=, 이런 때는 실행하지 않음
		if(dataDrugNumArr.length>1) {
			for(int i = 0;i<dataDrugNumArr.length;i++) {
				TxDrugVO vo = new TxDrugVO();
				vo.setTxcCd(txCodeVO.getTxcCd());			
				vo.setDrugNum(Integer.parseInt(dataDrugNumArr[i]));
				
				TxDrugList.add(vo);
			}
			log.info("txDrugList : " + TxDrugList);
			
			//(/hospital/txCode) 2. INSERT ALL 
//			result = result + this.txManagementMapper.insertAllTxDrug(TxDrugList);
		}else {
			TxDrugVO vo = new TxDrugVO();
			vo.setTxcCd(txCodeVO.getTxcCd());			
			vo.setDrugNum(Integer.parseInt(txCodeVO.getDataDrugNum()));
			
			TxDrugList.add(vo);
		}
		result = result + this.txManagementMapper.insertAllTxDrug(TxDrugList);
		
		return result;
		
	};
	
//	<!-- 중복 개수 가져오기 -->
//	
	@Override
	public int detail(String txcCd) {
		log.info(" servide txcCd : " + txcCd);
		return this.txManagementMapper.detail(txcCd);
	};
	
//	<!-- 해당하는 약품 한 줄 가져오기 -->
	@Override
//	<select id="drugDetail" parameterType="String" resultType="drugVO">
	public DrugVO drugDetail(int drugNum) {
		return this.txManagementMapper.drugDetail(drugNum);
	};
	
//	<!-- 약품 상세 조회 -->
//	<select id="selectDrugList" parameterType="String" resultType="java.util.List">
	@Override
	public List<DrugVO> selectDrugList(String txcCd){
		log.info("service txcCd : " + txcCd);
		return this.txManagementMapper.selectDrugList(txcCd);
		
	};
	
//	<!-- 처치 리스트 검색어 -->
//	<select id="txDrugList" parameterType="String" resultType="txcVO">
	@Override
	public List<TxCodeVO> txDrugList(String keyword){
		return this.txManagementMapper.txDrugList(keyword);
	};
	
}
