package com.web.ddentist.hospital.document.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.ddentist.hospital.document.service.IDocument;
import com.web.ddentist.vo.DiseaseVO;
import com.web.ddentist.vo.DocumentVO;
import com.web.ddentist.vo.DrugVO;
import com.web.ddentist.vo.HospitalInfoVO;
import com.web.ddentist.vo.PatientVO;
import com.web.ddentist.vo.RcvmtVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hospital/document")
public class DocumentController {


	@Autowired
	IDocument dService;

	@GetMapping("")
	public String allDocument() {
		return "hospital/document";
	}

	//향후 치료비 계획서
	@ResponseBody
	@PostMapping("/treatmentPlan")
	public String treatmentPlanPost(@RequestBody Map<String, String> map) throws IOException  {
		return this.dService.treatmentPlanPost(map);
	}

	//진단서
	@ResponseBody
	@PostMapping("/diagnosis")
	public String diagnosisPost(@RequestBody Map<String, String> map, Model model) throws IOException {
		log.info("map : " + map);
		return this.dService.diagnosisPost(map);
	}

	//치료확인서
	@ResponseBody
	@PostMapping("/treatconfirm")
	public String treatconfirmPost(@RequestBody Map<String, String> map) throws IOException {
		log.info("map : " + map);
		return this.dService.treatconfirmPost(map);
	}

	//CT판독서
	@ResponseBody
	@PostMapping("/CT")
	public String CTPost(@RequestBody Map<String, String> map) throws IOException {
		log.info("map : " + map);
		return this.dService.CTPost(map);
	}

	//소견서
	@ResponseBody
	@PostMapping("/opinion")
	public String opinionPost(@RequestBody Map<String, String> map) throws IOException {
		log.info("map : " + map);
		return this.dService.opinionPost(map);
	}

	//원외처방전
	@ResponseBody
	@PostMapping("/outside")
	public String outsidePost(@RequestBody Map<String, String> map) throws IOException {
		//map : {year=2023-03-10, ptNm=이상혁, ptRrno=9604011234567, ptAddr=대전 대덕구 대덕대로1585번길 44, 금강센트럴파크 서희스타힐스 112동 302호, disease=질병명, doctorName=개똥이, licenseNum=132-12345, deliver=7, date=8, docIssueReason=용도, ptNum=230228003, hiBrno=306-82-05291, hiNm=대덕치과, hiAddr=대전광역시 중구 계룡로 846, 3-4층, hiPhone=042-222-8202, hiEml=gmail@naver, chkNum=null
		//, drugVOList=[{"drugNm":"미그펜400연질캡슐(이부프로펜)","dosage":"1","doses":"2","dosesdate":"3"},{"drugNm":"이부로엔연질캡슐(이부프로펜)","dosage":"4","doses":"5","dosesdate":"6"}]}
		log.info("map : " + map);
		return this.dService.outsidePost(map);
	}

	//서류 리스트
	@ResponseBody
	@GetMapping("/doclist")
	public List<DocumentVO> docList(DocumentVO documentVO) {

		List<DocumentVO> doclist = this.dService.docList(documentVO);

		log.info("doclist:" + doclist);

		return doclist;
	}

	//환자 정보
	@ResponseBody
	@GetMapping("/patientInfo")
	public PatientVO patientInfo(@RequestParam String ptNum) {

		PatientVO ptVO = this.dService.patientInfo(ptNum);

		log.info("patientInfo:"+ ptVO);

		return ptVO;
	}

	//병원 정보
	@ResponseBody
	@GetMapping("/hospitalInfo")
	public HospitalInfoVO hospitalInfo() {

		HospitalInfoVO hosVO = this.dService.hospitalInfo();

		log.info("hospitalInfo:"+hosVO);

		return hosVO;
	}

	//요청URI : /hospital/document/checkbox
	//요청파라미터 : data : {"ptNum":"230228003","docNum":["1","3"]}
	//요청방식 : get
	//상세 정보 조회(체크박스, 날짜)
	@ResponseBody
	@PostMapping("/checkbox")
	public List<DocumentVO> checkBox(@RequestBody DocumentVO documentVO) {
		log.info("documentVO : " + documentVO);

		List<DocumentVO> checkBox = this.dService.checkBox(documentVO);
		//checkBox:DocumentVO(docIssueNum=D20230308-0001, ptNum=230228003, docNum=null
		//, docIssueReason=1, docSavePath=C:\eGovFrameDev-3.10.0-64bit\workspace\DDentistProj\src\main\webapp\resources\document\Completion\a22879f6-b11d-4253-9164-238cf2f9db6a진단서.pdf, docIssueDt=Wed Mar 08 09:20:49 KST 2023, chkNum=C20230307-0004)
		log.info("checkBox:"+checkBox);

		return checkBox;
	}

	//병명 모달창에서 상병코드 병명 가져오기
	@ResponseBody
	@PostMapping("/disList")
	public List<DiseaseVO> disList(@RequestBody DiseaseVO DiseaseVO) {
		log.info("DiseaseVO:" + DiseaseVO);
		return this.dService.disList(DiseaseVO);
	}


	@ResponseBody
	@GetMapping("/disModalSelect")
	public List<DiseaseVO> disModalSelect(@RequestParam String keyword) {
		log.info("diseaseVOSelect" + keyword);
		return this.dService.disModalSelect(keyword);
	}

	@ResponseBody
	@PostMapping("/showCdNm")
	public DiseaseVO showCdNm(@RequestBody DiseaseVO diseaseVO) {

		diseaseVO = this.dService.showCdNm(diseaseVO);
		log.info("show diseaseVO:"+diseaseVO);

		return diseaseVO;
	}

	//약품 모달창에서 리스트 띄우기
	@ResponseBody
	@PostMapping("/druList")
	public List<DrugVO> druList(@RequestBody DrugVO drugVO) {
		log.info("drugVO:"+drugVO);
		return this.dService.druList(drugVO);
	}

	//약품 모달창에 키워드 줘서 검색 후 리스트 띄우기
	@ResponseBody
	@GetMapping("/druModalSelect")
	public List<DiseaseVO> druModalSelect(@RequestParam String keyword) {
		log.info("druModalSelect"+keyword);

		List<DiseaseVO> druModalSelect=this.dService.druModalSelect(keyword);

		log.info("-----------druModalSelect : " + druModalSelect);

		return druModalSelect;
	}

	//약품 모달창에서 약품 선택한거 놓기
	@ResponseBody
	@PostMapping("/showDrug")
	public DrugVO showDrug(@RequestBody DrugVO drugVO) {

		drugVO = this.dService.showDrug(drugVO);
		log.info("show showDrug:"+drugVO);

		return drugVO;
	}

	// 환자의 미수납 건 가져오기
	@ResponseBody
	@GetMapping("/ptRvmList")
	public List<RcvmtVO> ptRvmList(@RequestParam String ptNum) {
		log.info(ptNum);
		List<RcvmtVO> rcvList = this.dService.ptRvmList(ptNum);

		log.info("rcvListrcvList : " + rcvList);

		return rcvList;
	}

	/**
	 * 서류만 결제 시 수납정보 생성 후 서류 정보 등록, 결제 정보 등록
	 * 서류 및 수납 동시 결제 시 수납정보 업데이트 후 서류정보 등록, 결제정보 등록
	 *
	 * @param listMap 서류 정보, 미수납 정보, 결제 정보
	 * @return
	 */
	@ResponseBody
	@PostMapping("/checkUpDocRcvmt")
	public String checkUpDocRcvmt(@RequestBody Map<String, List<Map<String, String>>> listMap) {
		List<Map<String, String>> docData = listMap.get("docData");
		Map<String, String> unpaidMap = listMap.get("unpaid").get(0);
		Map<String, String> payData = listMap.get("unpaid").get(1);

		return this.dService.InsertCheckup(docData, unpaidMap ,payData);
	}

}
