package com.web.ddentist.hospital.site.bannerInfo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.web.ddentist.hospital.site.bannerInfo.service.BannerService;
import com.web.ddentist.vo.BannerVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@RequestMapping("/hospital/site/bannerInfo")
@Controller
public class BannerInfoController {
	
	@Autowired
	BannerService bannerService;
	
	//요청URI : /hospital/site/bannerInfo
	@GetMapping("")
	public String main() {
		return "hospital/bannerInfo";
	}
	
	
	
	//요청URL : /hospital/site/bannerInfo/uploadFormMultiAction
	//요청방식 : post
	//파라미터 : uploadFile
	
	@ResponseBody
	@RequestMapping(value="/uploadFormMultiAction", produces = "application/json;charset=utf-8")
	public List<BannerVO> uploadFormAction( 
			@RequestParam MultipartFile[] uploadFile,
			HttpServletRequest req) {
		log.info("uploadFile : " + uploadFile );
		
		//--------------파일 저장되는 경로 만들기 시작--------------
		//이클립스
		String uploadFolder = "C:\\eGovFrameDev-3.10.0-64bit\\workspace\\DDentistProj\\src\\main\\webapp\\resources\\upload";
		//배포
//		String uploadFolder = req.getServletContext().getRealPath("/resources/upload");
		
		List<BannerVO> pathList = new ArrayList<BannerVO>();
		//경로 만들기
		File uploadPath = new File(uploadFolder,getFolder());
		log.info("uploadPath : " + uploadPath);
		
		//만약에 경로가 없다면 경로대로 폴더를 만들고 이미지를 넣어줘라
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		//---------------파일 저장되는 경로 만들기 끝--------------
		
		for(MultipartFile multipartfile : uploadFile) {
			//확인하기
			log.info("-------------------------");
			log.info("이미지 명 : " + multipartfile.getOriginalFilename());
			log.info("파일 크기 : " + multipartfile.getSize());
			log.info("컨텐츠(MIME)타입 : " + multipartfile.getContentType());
			
			//----------중복 방지 시작-------------
			//랜덤으로 생성하기
			UUID uuid = UUID.randomUUID();
			//파일명 꺼내기
			String uploadFileName = multipartfile.getOriginalFilename();
			//파일 이름에 붙이기
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("uploadFileName : " + uploadFileName);
			
			//-----------중복 방지 끝-------------
			
			//어디에 무엇을 설정
			File saveFile = new File(uploadPath, uploadFileName);
			
			//DB에 담기 위해 vo에 데이터 담기
			BannerVO bannerVO = new BannerVO();
			//보내기
			try {
				//1)bannerNm 만들고 넣어주기 filename
				String filename = "/"+getFolder().replace("\\", "/")+"/"+uploadFileName;
				log.info("filename : " + filename);
				bannerVO.setBannerNm(filename);
				
				//2)bannerSize 넣어주기
				int l = Math.toIntExact(multipartfile.getSize());
				bannerVO.setBannerSize(l);
				
				//3)bannerPath 넣어주기(bannerNm과 동일)
//				String bannerPath = saveFile.toString();
				bannerVO.setBannerPath("/resources/upload" + filename);
				
				//4)bannerThumbnail 넣어주기 thumbnailname
				String bannerThumbnail = "/"+getFolder().replace("\\", "/")+"/s_"+uploadFileName;
				bannerVO.setBannerThumbnail(bannerThumbnail);
				
				log.info("bannerVO : " + bannerVO);
				
				//1) DB에 insert
				int result = this.bannerService.uploadFormAction(bannerVO);
				
				log.info("result : " + result);
				
				//배열에서 꺼낸 이미지 하나하나 복사하기
				multipartfile.transferTo(saveFile);
					//-------------------썸네일 만들기-------------------
					try {
						//MIME 타입을 가져옴. images/jpeg
						String contentType = Files.probeContentType(saveFile.toPath());
						log.info("contentType : " + contentType);
						//MIME 타입 정보가 images로 시작하는지 여(true)부(false)
						if(contentType.startsWith("image")) {
							FileOutputStream Thumbnail = new FileOutputStream(
								//c:\\upload\\2023\\01\\27\\s_EAREFASEFASEFS_개똥이.jpg
								//파일 경로를 썸네일이라면 s_를 붙여서 만들기
								new File(uploadPath, "s_" + uploadFileName)
							);
							//썸네일 생성(원본 이미지 복사, 썸네일, 크기 설정)
							Thumbnailator.createThumbnail(multipartfile.getInputStream(),Thumbnail,100,100);
							Thumbnail.close();
						}
					} catch (IOException e) {
						e.printStackTrace();
					}	
					//-------------------썸네일 만들기-------------------
					bannerVO.setBannerPath("/resources/upload" + filename);
					log.info("bannerVO : "  + bannerVO);
					pathList.add(bannerVO);
					
			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
		
		//2) responseBody로 돌려보낼것임(3개의 이미지 경로)
		
		return pathList;
	}
	
	//연/월/일 폴더 생성
	public static String getFolder() {
		//2023-01-27형식(format) 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2023-01-27
		String str = sdf.format(date);
		//단순 날짜 문자를 File객체의 폴더 타입으로 바꾸기
		//(=>2023File.separator(\\)01File.separator(\\)27)
		//c:\\upload\\2023\\01\\27
		return str.replace("-", File.separator);
	}
	
	//요청URL : hospital/site/bannerInfo/getImgs
	//요청방식 : get
	@ResponseBody
	@GetMapping("/getImgs")
	public List<BannerVO> getImgs(){
		log.info("ajax 왔다.");
		
		List<BannerVO> list = this.bannerService.getImgs();
		//list : [BannerVO(bannerNum=1
//		, bannerNm=/2023/03/21/084a6176-0dd3-4831-8d54-bbce9b607bb9_a002.jpg, bannerSize=18099
//				, bannerPath=/2023/03/21/084a6176-0dd3-4831-8d54-bbce9b607bb9_a002.jpg
//				, bannerThumbnail=/2023/03/21/s_084a6176-0dd3-4831-8d54-bbce9b607bb9_a002.jpg)
//		, BannerVO(bannerNum=2, bannerNm=/2023/03/21/96c1afc5-fefe-4872-95e2-263aa6155f37_a003.jpg
	//		, bannerSize=9451, bannerPath=/2023/03/21/96c1afc5-fefe-4872-95e2-263aa6155f37_a003.jpg
	//		, bannerThumbnail=/2023/03/21/s_96c1afc5-fefe-4872-95e2-263aa6155f37_a003.jpg)
//		, BannerVO(bannerNum=3, bannerNm=/2023/03/21/e1867c11-734d-4b72-8d83-74550be60836_a004.jpg
	//		, bannerSize=7686, bannerPath=/2023/03/21/e1867c11-734d-4b72-8d83-74550be60836_a004.jpg
	//		, bannerThumbnail=/2023/03/21/s_e1867c11-734d-4b72-8d83-74550be60836_a004.jpg)
//		, BannerVO(bannerNum=4, bannerNm=/2023/03/21/594734d0-ceb0-4198-8535-9c86fc23cdcd_a001.jpg
	//		, bannerSize=7841, bannerPath=/2023/03/21/594734d0-ceb0-4198-8535-9c86fc23cdcd_a001.jpg
	//		, bannerThumbnail=/2023/03/21/s_594734d0-ceb0-4198-8535-9c86fc23cdcd_a001.jpg)
		log.info("list : " + list);
		return list;
	}
	
	//요청URL : /hospital/site/bannerInfo/decision
	//요청 방식 : post
	@PostMapping("/decision")
	public String decision(Model model, String bannerNum) {
		log.info("bannerNum : " + bannerNum);
		
		this.bannerService.updateStatus(bannerNum);
		
		return "hospital/bannerInfo";
			
	}
	
	//요청URL : /hospital/site/bannerInfo/imgDelete?${_csrf.parameterName}=${_csrf.token}
	//요청 방식 : post
	@PostMapping("/imgDelete")
	public String imgDelete(Model model, String bannerNum) {
		log.info("delete bannerNum : " + bannerNum);
		
		this.bannerService.deleteBanner(bannerNum);
		
		return "hospital/bannerInfo";
	}
	
	//요청URL : /hospital/site/bannerInfo/bannerClear
	//요청 방식 : post
	@PostMapping("/bannerClear")
	public String bannerClear(Model model, String bannerNum) {
		log.info("bannerClear bannerNum : " + bannerNum);
		
		this.bannerService.updateStatusCancel(bannerNum);
		
		return "hospital/bannerInfo";
		
	}
}
