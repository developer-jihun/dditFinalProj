package com.web.ddentist.hospital.manage.hospitalInfo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.HospitalInfoMapper;
import com.web.ddentist.vo.ChairVO;
import com.web.ddentist.vo.CommonCodeVO;
import com.web.ddentist.vo.DepartmentVO;
import com.web.ddentist.vo.HospitalInfoVO;

@Service
public class HospitalInfoServiceImpl implements IHospitalInfoService {
	
	@Autowired
	HospitalInfoMapper hospitalInfoMapper;
	
	
	// 병원기초 정보
	@Override
	public HospitalInfoVO getHospitalInfo() {
		return this.hospitalInfoMapper.getHospitalInfo();
	}
	
	// 병원구분 select option 값
	@Override
	public List<CommonCodeVO> getCommon(String commGrCd){
		return this.hospitalInfoMapper.getCommon(commGrCd);
	}
	
	// 부서리스트
		@Override
		public List<DepartmentVO> deptList() {
			return this.hospitalInfoMapper.deptList();
		}
		
		// 체어리스트
		@Override
		public List<ChairVO> chairList() {
			return this.hospitalInfoMapper.chairList();
		}
		
		// 체어 수정
		@Override
		public int updateChair(List<ChairVO> param) {
			
			System.out.println("update ServiceImpl!!!!!!!!!!!!!!");
			int result = 0;
			//반복문
			for(int i=0; i<param.size(); i++) {
				System.out.println(param.get(i));
				ChairVO vo = param.get(i);
				
				result = this.hospitalInfoMapper.updateChair(vo);
				System.out.println("수정 결과 :  {} " + result);
				if(result == 0) return result;
			}
			
			return result;
		}
		
		// 체어 등록
		@Override
		public int createChair(List<ChairVO> param) {
			
			int result = 0;
			
			//반복문
			for(int i=0; i<param.size(); i++) {
				System.out.println(param.get(i));
				ChairVO vo = param.get(i);
				
				result = this.hospitalInfoMapper.createChair(vo);
				System.out.println("등록 결과 :  {} " + result);
				if(result == 0) return result;
			}
			
			return result;
		}
		
		// 체어 삭제
		@Override
		public int deleteChair(List<ChairVO> param) {
			
			int result = 0;
			
			//반복문
			for(int i=0; i<param.size(); i++) {
				System.out.println(param.get(i));
				ChairVO vo = param.get(i);
				
				result = this.hospitalInfoMapper.deleteChair(vo);
				System.out.println("삭제 결과 :  {} " + result);
				if(result == 0) return result;
			}
			return result;
		}
	
		// 병원정보 수정
		@Override
		public int updatePost(HospitalInfoVO hosVO) {
			return this.hospitalInfoMapper.updatePost(hosVO);
		}
}
