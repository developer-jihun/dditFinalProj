package com.web.ddentist.hospital.media.service;

import java.util.List;
import java.util.Map;

import com.web.ddentist.vo.CheckupVO;
import com.web.ddentist.vo.MediaVO;
import com.web.ddentist.vo.PatientVO;

public interface MediaService {

	public List<CheckupVO> checkUpList(Map<String, String> ptMap);

	public int createMedia(MediaVO mediaVO);

	public List<MediaVO> mediaInfo(Map<String, String> map);

	/**
	 * 삭제할 이미지 파일 경로들을 가져옴
	 *
	 * @param medNumList 삭제할 이미지들의 이미지 번호
	 * @return 삭제할 원본 이미지, 썸네일 이미지 경로가 담긴 VO List
	 */
	public List<MediaVO> getMediaList(List<String> medNumList);

	public int imgDelete(List<String> medNumList);

}
