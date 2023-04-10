package com.web.ddentist.hospital.site.doctorIntro.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.web.ddentist.hospital.site.doctorIntro.service.DoctorIntroService;
import com.web.ddentist.vo.DiseaseVO;
import com.web.ddentist.vo.IntroduceVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Controller
@RequestMapping("/hospital/site/doctorIntro")
public class DoctorIntroController {

	@Autowired
	DoctorIntroService dService;

	//의사 전체 조회
	@GetMapping("")
	public String doctorIntroMain(Model model) {

		List<IntroduceVO> doctorList=this.dService.doctorIntroMain();

		model.addAttribute("doctorList",doctorList);

		log.info("doctorList:"+doctorList);

		return "hospital/doctorIntro";
	}

	//의사 선택 조회
	@ResponseBody
	@PostMapping("/doctorSelect")
	public IntroduceVO doctorSelect(@RequestBody IntroduceVO intVO) {
		log.info("doctorSelect에 도착했다.");
		log.info("doctorSelect : "+intVO);

		intVO=this.dService.doctorSelect(intVO);

		log.info(">>>>doctorSelect : "+intVO);

		IntroduceVO noDataVO = new IntroduceVO();
		if(intVO == null) {
			noDataVO.setNodata("noData");
			return noDataVO;
		}else {
			return intVO;
		}

	}

	//정보 저장
	@ResponseBody
	@PostMapping("/doctorSave")
//	public int doctorSave(@RequestBody IntroduceVO intVO, MultipartFile uploadFile) {
	public IntroduceVO doctorSave(IntroduceVO intVO) {
		log.info("doctorSave:"+intVO);
		MultipartFile uploadFile = intVO.getUploadFile();

		String uploadFilename="";

		if(uploadFile != null && !uploadFile.isEmpty()) {
			uploadFilename = fileUpload(uploadFile);

			log.info("uploadFilename 확인용 : " + uploadFilename);

			String filename = "/resources/images/doctorIntro/" + getFolder().replace("\\", "/") + "/" + "s_" + uploadFilename;
//			String contents = ((String)intVO.getIntroEducation()).replace("\r\n","<br />");
//			String introContent = ((String)intVO.getIntroContent()).replace("\r\n","<br />");

//			System.out.println("contents : " + contents);
//			System.out.println("filename : " + filename);

//			intVO.setIntroContent(introContent);
//			intVO.setIntroEducation(contents);
			intVO.setThumbnail(filename);
			}

		int result = this.dService.doctorSave(intVO);
		log.info(">>>>insert result:"+result);

		IntroduceVO doctor=this.dService.doctorSelect(intVO);
		log.info(">>>>doctorSelect intVO:"+doctor);

		return doctor;
	}

	//검색 버튼 누르면 의사 정보 불러옴
	@ResponseBody
	@GetMapping("/doctorSearch")
	public List<DiseaseVO> doctorSearch(@RequestParam String keyword) {
		log.info("doctorSearch"+keyword);

		List<DiseaseVO> doctorSearch=this.dService.doctorSearch(keyword);

		log.info("-----------doctorSearch:"+doctorSearch);

		return doctorSearch;
	}

	//파일 업로드 시작
	public String fileUpload(@RequestBody MultipartFile uploadFile) {

		String uploadFolder = System.getProperty("user.dir").replace("\\eclipse", "") + "\\workspace\\DDentistProj\\src\\main\\webapp\\resources\\images\\doctorIntro";

		File uploadPath = new File(uploadFolder, getFolder());
	    log.info("upload Path : " +  uploadPath);

	    if(!uploadPath.exists()) {
	        uploadPath.mkdirs();
	    }
	    String uploadFileName= uploadFile.getOriginalFilename();
	    log.info("오리지날 파일이름 : " + uploadFileName);

	    UUID uuid = UUID.randomUUID();
	    uploadFileName = uuid.toString() + "_" + uploadFileName;

	    File saveFile = new File(uploadPath, uploadFileName);

	    FileOutputStream thumbnail = null;
	    try {
	    	//uploadFile.transferTo(saveFile); 원본 파일 저장
			if(checkImageType(saveFile)) {
				thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 600, 750);
				thumbnail.close();
			}
	    } catch (IllegalStateException e) {
	        log.error(e.getMessage());
	    } catch (IOException e) {
	        log.error(e.getMessage());
	    } finally {
	    	try { if(thumbnail != null) thumbnail.close(); } catch(Exception e) {}
	    }

	    return uploadFileName;
	}

	public static boolean checkImageType(File uploadFile) {

		try {
			String contentType = Files.probeContentType(uploadFile.toPath());
			log.info("contentType : " + contentType);

			return contentType.startsWith("image");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	public static String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}
	//파일 업로드 끝

}


