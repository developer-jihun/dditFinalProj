package com.web.ddentist.vo;

import java.util.List;

public class PageVO<T> {
	//전체글 수
	private int total;
	//현재 페이지 번호
	private int currentPage;
	//전체 페이지 수
	private int totalPages;
	//시작 페이지 번호
	private int startPage;
	//종료 페이지 번호
	private int endPage;
	//블록 크기
	private int blockSize;
	//글 데이터
	private List<T> content;
	//생성자(Constructor) : 페이징 정보를 생성 및 초기화
	//size : 한 화면에 보여질 행의 수
	
	//검색 단어
	private String keyword;
	//분류 단어
	private String faqType;
	
	
	
	public PageVO(int total, int currentPage, int size, List<T> content, int blockSize) {
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		this.blockSize = blockSize;
		
		if(total==0) {//전체 글 수가 0일 때
			totalPages = 0;
			startPage = 0;
			endPage = 0;
		}else{//전체 글 수가 1 이상일 때
			//1) 전체 페이지 구하기 시작---------------
			//전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
			totalPages = total / size;
		    // 2 =  10/5
			
			//전체글 수 % 한 화면에 보여질 목록의 행 수
			//	=> 0이 아니면(나머지가 있다면)? 페이지를 1 증가
			if(total % size > 0) {
				totalPages++;
			}
			//1) 전체 페이지 구하기 끝---------------
			
			//2) 시작 페이지 구하기 시작---------------
			//시작 페이지 = 현재페이지 / 페이지크기*페이지크기 + 1
			//1set :    [1][2][3][4][5] 다음
			//2set : 이전[6][7][8][9][10]다음
			//3set : 이전[11][12]
			startPage = currentPage / blockSize * blockSize + 1;
			
			//현재페이지 % 페이지크기 => 0일 때 보정
			if(currentPage % blockSize == 0) {
				//페이지크기를 빼줌
				startPage -= blockSize;
			}
			//2) 시작 페이지 구하기 끝---------------
			
			//3) 종료 페이지 구하기 시작---------------
			//종료페이지번호 = 시작페이지번호 + (페이지크기 - 1)
			endPage = startPage + (blockSize - 1);
			
			//종료페이지번호 > 전체페이지수보다 클 때 보정
			if(endPage > totalPages) {
				endPage = totalPages;
			}
			//3) 종료 페이지 구하기 끝---------------
		}
	}//end PageVO생성자
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public List<T> getContent() {
		return content;
	}
	public void setContent(List<T> content) {
		this.content = content;
	}
	
	
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getFaqType() {
		return faqType;
	}
	public void setFaqType(String faqType) {
		this.faqType = faqType;
	}
	//데이터가 없나유? 전체 글의 수는 0이유
	public boolean hasNoPagesVO() {
		return total == 0;
	}
	
	//데이터가 있습니까?
	public boolean hasPagesVO() {
		return total > 0;
	}
	@Override
	public String toString() {
		return "PageVO [total=" + total + ", currentPage=" + currentPage + ", totalPages=" + totalPages + ", startPage="
				+ startPage + ", endPage=" + endPage + ", blockSize=" + blockSize + ", content=" + content
				+ ", keyword=" + keyword + ", faqType=" + faqType + "]";
	}
	
	
	
}