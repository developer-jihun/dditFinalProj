package com.web.ddentist.hospital.media.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.ddentist.mapper.MediaMapper;
import com.web.ddentist.vo.CheckupVO;
import com.web.ddentist.vo.MediaVO;
import com.web.ddentist.vo.PatientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MediaServiceImpl implements MediaService {

	@Autowired
	MediaMapper mediaMapper;

	@Override
	public List<CheckupVO> checkUpList(Map<String, String> ptMap) {
		return this.mediaMapper.checkUpList(ptMap);
	}

	@Override
	public int createMedia(MediaVO mediaVO) {
		return this.mediaMapper.createMedia(mediaVO);
	}

	@Override
	public List<MediaVO> mediaInfo(Map<String, String> map){
		return this.mediaMapper.mediaInfo(map);
	}

	@Override
	public List<MediaVO> getMediaList(List<String> medNumList) {
		return this.mediaMapper.getMediaList(medNumList);
	}

	@Override
	public int imgDelete(List<String> medNumList) {
		return this.mediaMapper.imgDelete(medNumList);
	}
}


