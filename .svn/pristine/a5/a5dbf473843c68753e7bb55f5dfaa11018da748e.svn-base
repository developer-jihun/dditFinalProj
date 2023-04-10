package com.web.ddentist.hospital.manage.empInfo.service;

import java.util.List;

import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.TxCodeVO;

public interface ITxManagementService {

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
//	<delete id="updatePost" parameterType="txcVO">
	public int updatePost(TxCodeVO txCodeVO);

//	<!-- 해당하는 한 줄 가져오기 -->
	public int detail(String txcCd);

//	<!-- 해당하는 약품 한 줄 가져오기 -->
	public DrugVO drugDetail(int drugNum);

//	<!-- 약품 상세 조회 -->
//	<select id="selectDrugList" parameterType="String" resultType="java.util.List">
	public List<DrugVO> selectDrugList(String txcCd);

//	<!-- 처치 리스트 검색어 -->
//	<select id="txDrugList" parameterType="String" resultType="txcVO">
	public List<TxCodeVO> txDrugList(String keyword);

}
