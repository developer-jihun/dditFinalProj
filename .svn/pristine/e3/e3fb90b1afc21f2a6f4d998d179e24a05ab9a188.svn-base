package com.web.ddentist.mapper;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.DiseaseVO;
import com.web.ddentist.vo.DocumentVO;
import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.HospitalInfoVO;
import com.web.ddentist.vo.PatientVO;
import com.web.ddentist.vo.PrescriptionVO;
import com.web.ddentist.vo.RcvmtVO;


public interface DocumentMapper {

	//향후 치료비 추정서
	public int treatmentPlanPost(Map<String, String> map);

	//발급번호
	public String getNum();

	//진단서
	public int diagnosisPost(Map<String, String> map);

	//치료확인서
	public int treatconfirmPost(Map<String, String> map);

	//CT소견서
	public int CTPost(Map<String, String> map);

	//소견서
	public int opinionPost(Map<String, String> map);

	//원외처방전
	public int outsidePost(Map<String, String> map);

	//서류 리스트
	public List<DocumentVO> docList(DocumentVO documentVO);

	//클릭하면 환자 정보
	public PatientVO patientInfo(String ptNum);

	//클릭하면 병원 정보
	public HospitalInfoVO hospitalInfo();

	//체크박스 및 달력 체크
	public List<DocumentVO> checkBox(DocumentVO documentVO);

	//달력인데 안 씀
	public List<DocumentVO> getDate(DocumentVO documentVO);

	//병명 모달 리스트
	public List<DiseaseVO> disList(DiseaseVO diseaseVO);

	//병명 모달 검색
	public List<DiseaseVO> disModalSelect(String keyword);

	//병명 모달 하나 선택하면 값이 입력됨
	public DiseaseVO showCdNm(DiseaseVO diseaseVO);

	//약품 모달 리스트
	public List<DrugVO> druList(DrugVO drugVO);

	//약품 모달 검색
	public List<DiseaseVO> druModalSelect(String keyword);

	//약품 모달 하나 선택하면 값이 입력됨
	public DrugVO showDrug(DrugVO drugVO);
	
	
	/**
	 * 처방전 발급내역 추가
	 * 
	 * @param prcpVO 처방전 발급 정보
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPrescription(PrescriptionVO prcpVO);
	
	/**
	 * 처방전 약품내역 추가
	 * 
	 * @param drugVOList 처방된 약품 목록
	 * @return 성공 : 1 이상, 실패 : 0
	 */
	public int insertPrcpDrug(List<DrugVO> drugVOList);
	
	/**
	 * 해당 환자의 미수납 건 조회
	 * @param ptNum 환자 번호
	 * @return
	 */
	public List<RcvmtVO> ptRvmList(String ptNum);
	
	/**
	 * 서류만 결제 할 때 서류 수납 추가
	 * @param unpaidMap 회원번호와 결제 금액 정보
	 * @return 성공 1, 실패 0
	 */
	public void InsertCheckup(Map<String, String> unpaidMap);
	
	/**
	 * 결제 서류 리스트 추가
	 * @param docData 추가 할 서류 정보
	 * @return
	 */
	public int InsertDocList(List<Map<String, String>> docData);

	/**
	 * 결제 정보 추가
	 * @param cardPaydata 카드 정보 
	 * @return 성공 1, 실패  0
	 */
	public int docPay(Map<String, String> cardPaydata);
	
	
}
