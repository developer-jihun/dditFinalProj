package com.web.ddentist.patient.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.web.ddentist.hospital.crm.sms.util.SmsSendUtil;
import com.web.ddentist.mapper.PatientMapper;
import com.web.ddentist.security.AesEncryptionUtil;
import com.web.ddentist.vo.PatientVO;

@Service
public class PatientServiceImpl implements IPatientService {

	@Autowired
	private PatientMapper patientMapper;
	@Autowired
	private SmsSendUtil smsSendUtil;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	private HttpSession getSession() {
		ServletRequestAttributes requestAtt = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		return requestAtt.getRequest().getSession();
	}

	@Override
	public String sendAuthNum(PatientVO ptVO) {
		PatientVO ptInfo = patientMapper.selectPtInfo(ptVO);
		if(ptInfo == null) return "NONE";
		if(ptInfo.getPtId() != null && !ptInfo.getPtId().equals("")) return "ALREADY";

		String ptPhone = ptVO.getPtPhone();
		String authNum = String.valueOf((int) (Math.random() * 899999) + 100000);
		String content = "본인확인 인증번호 [" + authNum + "]를 입력해주세요.";
		try {
			smsSendUtil.sendSms(ptPhone, content);
		} catch (Exception e) {
			return "FAILED";
		}

		HttpSession session = getSession();
		String encryptedAuthNum = AesEncryptionUtil.encrypt(authNum);
		session.setAttribute("authNum", encryptedAuthNum);
//		session.setAttribute("authNum", "123456");
		session.setAttribute("ptNum", ptInfo.getPtNum());
		return "SUCCESS";
	}

	@Override
	public String checkAuthNum(Map<String, String> paramMap) {
		HttpSession session = getSession();
		String authNum = paramMap.get("authNum");
		String sendedAuthNum = (String) session.getAttribute("authNum");
		String decryptedAuthNum = AesEncryptionUtil.decrypt(sendedAuthNum);
		if(authNum.equals(decryptedAuthNum)) {
			session.setAttribute("authYN", "Y");
			return "SUCCESS";
		}
//		if(authNum.equals("123456")) {
//			session.setAttribute("authYN", "Y");
//			return "SUCCESS";
//		}
		session.removeAttribute("ptNum");
		return "FAILED";
	}

	@Override
	public int updatePtMrsaYn(PatientVO ptVO) {
		HttpSession session = getSession();
		String authYN = (String) session.getAttribute("authYN");
		if(authYN == null) return 0;

		// 인증 정보 초기화
		session.removeAttribute("authYN");

		String ptNum = (String) session.getAttribute("ptNum");
		ptVO.setPtNum(ptNum);
		return patientMapper.updatePtMrsaYn(ptVO);
	}

	@Override
	public String checkId(String ptId) {
		int result = patientMapper.checkId(ptId);
		if(result == 0) return "SUCCESS";
		return "FAILED";
	}

	@Override
	public int insertPtAcc(PatientVO ptVO) {
		HttpSession session = getSession();
		session.removeAttribute("ptNum");

		// 비밀번호 암호화
		String ptPw = passwordEncoder.encode(ptVO.getPtPw());
		ptVO.setPtPw(ptPw);

		return patientMapper.insertPtAcc(ptVO);
	}

	@Override
	public String sendFindIdPwAuthNum(PatientVO ptVO) {
		String ptPhone = ptVO.getPtPhone();
		String authNum = String.valueOf((int) (Math.random() * 899999) + 100000);
		String content = "본인확인 인증번호 [" + authNum + "]를 입력해주세요.";
		try {
			smsSendUtil.sendSms(ptPhone, content);
		} catch (Exception e) {
			return "FAILED";
		}

		HttpSession session = getSession();
		String encryptedAuthNum = AesEncryptionUtil.encrypt(authNum);
		session.setAttribute("authNum", encryptedAuthNum);
//		session.setAttribute("authNum", "123456");
		return "SUCCESS";
	}

	// 아이디/비밀번호 찾기를 위해 본인 인증을 했는지 확인
	private boolean isAuthorized() {
		HttpSession session = getSession();
		String authYN = (String) session.getAttribute("authYN");

		// 인증하지 않았을 경우
		if(authYN == null || authYN.equals("")) return false;

		// 인증했을 경우 인증 정보 초기화
		session.removeAttribute("authYN");
		return true;
	}

	@Override
	public String findId(Map<String, String> paramMap) {
		if(!isAuthorized()) return null;

		PatientVO ptVO = new PatientVO();
		String ptNm = paramMap.get("ptNm");
		ptVO.setPtNm(ptNm);
		String ptPhone = paramMap.get("ptPhone1") + paramMap.get("ptPhone2") + paramMap.get("ptPhone3");
		ptVO.setPtPhone(ptPhone);

		HttpSession session = getSession();
		session.removeAttribute("ptNum");
		return patientMapper.findId(ptVO);
	}

	@Override
	public int findPw(Map<String, String> paramMap) {
		if(!isAuthorized()) return 0;

		PatientVO ptVO = new PatientVO();
		String ptId = paramMap.get("ptId");
		ptVO.setPtId(ptId);
		String ptPhone = paramMap.get("ptPhone1") + paramMap.get("ptPhone2") + paramMap.get("ptPhone3");
		ptVO.setPtPhone(ptPhone);
		String ptNum = patientMapper.findPw(ptVO);
		if(ptNum == null) return 0;

		HttpSession session = getSession();
		session.setAttribute("ptNum", ptNum);
		return 1;
	}

	@Override
	public int resetPtPw(PatientVO ptVO) {

		// 비밀번호 암호화
		String newPtPw = ptVO.getPtPw();
		String encryptedPtPw = passwordEncoder.encode(newPtPw);
		ptVO.setPtPw(encryptedPtPw);

		HttpSession session = getSession();
		String ptNum = (String) session.getAttribute("ptNum");
		ptVO.setPtNum(ptNum);
		int result = patientMapper.resetPtPw(ptVO);

		session.removeAttribute("ptNum");
		return result;
	}

}
