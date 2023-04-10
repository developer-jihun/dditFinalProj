package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.ChairVO;
import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.DepartmentVO;
import com.web.ddentist.vo.HospitalInfoVO;

public interface HospitalInfoMapper {

	// 병원기초 정보
	public HospitalInfoVO getHospitalInfo();

	// 병원구분 select option 값
	public List<CommonCodeVO> getCommon(String commGrCd);
	
	// 부서리스트
	public List<DepartmentVO> deptList();

	// 체어리스트
	public List<ChairVO> chairList();
	
	// 체어 수정
	public int updateChair(ChairVO vo);
	
	// 체어 등록
	public int createChair(ChairVO vo);
	
	// 체어 삭제
	public int deleteChair(ChairVO vo);
	
	// 병원정보 수정
	public int updatePost(HospitalInfoVO hosVO);
}
