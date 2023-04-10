package com.web.ddentist.mapper;

import java.util.List;

import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.TxCodeVO;
import com.web.ddentist.vo.TxDrugVO;

public interface TxManagementMapper {
	
	
	/**
	 * 
	 * 초기 처치 리스트 가져오기
	 * 
	 * @return List<TxCodeVO>
	 */
	public List<TxCodeVO> list();
	
//	<!-- 처치 등록하기 -->
//	<insert id="insert" parameterType="TxCodeVO">
	public int insert(TxCodeVO txCodeVO);
	
	
//	<!-- 처치 삭제하기 -->
//	<delete id="deletePost" parameterType="txcVO">
	public int deletePost(TxCodeVO txCodeVO);
	
//	<!-- 처치 수정하기 -->
//	<update id="updatePost" parameterType="txcVO">
	public int updatePost(TxCodeVO txCodeVO);
	
	//(/hospital/txCode) 1. 처치약품 삭제 
	public int deleteTxDrug(TxCodeVO txCodeVO);
	
	//(/hospital/txCode) 2. INSERT ALL 
	public int insertAllTxDrug(List<TxDrugVO> TxDrugList);
	
	
//	<!-- 중복 개수 가져오기 -->
	public int detail(String txcCd);
	
//	<!-- 해당하는 약품 한 줄 가져오기 -->
//	<select id="drugDetail" parameterType="String" resultType="drugVO">
	public DrugVO drugDetail(int drugNum);
	
	
//	<!-- 처치약품 넣기 -->
//	<insert id="insert2" parameterType="txcVO">
	public int insert2(TxCodeVO txcVO);
	
//	<!-- 약품 상세 조회 -->
//	<select id="selectDrugList" parameterType="String" resultType="drugVO">
	public List<DrugVO> selectDrugList(String txcCd);
	
//	<!-- 처치 리스트 검색어 -->
//	<select id="txDrugList" parameterType="String" resultType="txcVO">
	public List<TxCodeVO> txDrugList(String keyword);
}
