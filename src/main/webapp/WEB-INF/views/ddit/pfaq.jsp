<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
.btn-group {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 50%;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 50px;
}

.categoryBtn {
	width: 200px;
	height: 60px;
	background-color: white;
	color: gray;
	border: 1px solid gray;
	font-family: 'Noto Sans KR', sans-serif;
	padding-top: 14px;
}

.categoryBtn:hover {
	background-color: #ccadff;
	border: 1px solid #ccadff;
}

.paginationBtn {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: auto;
}

span {
	font-family: 'Noto Sans KR', sans-serif;
}

th {
	font-family: 'Noto Sans KR', sans-serif;
	text-align: center;
}

td {
	font-family: 'Gothic A1', sans-serif;
	text-align: center;
}

.table-hover {
cursor : pointer;
}

.violetBtn{
	background-color:#904aff;
	border:none;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight:500;
	color:white;
}

.violetBtn:hover{
	background-color:#7c3dde !important;
}

.redBtn:hover{
	background-color:#e13636 !important;
}


</style>


<!-- Head Image 시작 -->
<div class="boardHeadImage">
	<div class="wrapper">
		<div class="slide">
			<img src="/resources/images/layout/ddit/faq.png" />
		</div>
	</div>
</div>
<!-- Head Image 끝 -->
<!-- button group 공지사항,문의게시판,이용안내 -->
<div class="btn-group" role="group" aria-label="Basic example">
	<a type="button" id="categoryBtn1" class="btn btn-primary btn-lg categoryBtn" href="/ddit/notice">공지사항</a>
	<a type="button" id="categoryBtn2" class="btn btn-primary btn-lg categoryBtn" href="/ddit/faq" style="background-color: #904aff; color: white;">자주 묻는 질문</a>
	<a type="button" id="categoryBtn2" class="btn btn-primary btn-lg categoryBtn" href="/ddit/inquiry">문의게시판</a>
	<a type="button" id="categoryBtn3" class="btn btn-primary btn-lg categoryBtn" href="/ddit/community">커뮤니티</a>
</div>
<!-- main section 시작 -->
<section class="container">
	<!-- 공지사항 nav 시작 -->
	<div class="row" style="margin-left: 7%; width: 85%; height: 100px; border-top: 1px solid gray; border-bottom: 1px solid gray;">
		<div class="col-12">
			<h4 style="margin-left: 50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">자주 묻는 질문</h4>
		</div>
		<div class="col-6">
			<h6 style="margin-left: 50px; font-family: 'Noto Sans KR', sans-serif; opacity: 0.5; font-size: 14px;">home > 고객의 소리 > 자주 묻는 질문</h6>
		</div>
	</div>
	<!-- 분류 선택 -->
	<form id="searchFrm" method="get" action="/ddit/faq">
		<div class="row" style="margin-top:10px;">
			<div class="col-1"></div>
			<div class="col-10" style="text-align:center; margin-top:20px;">
				<!-- Tab 시작 -->


					<ul class="nav nav-tabs" style="font-family: 'Noto Sans KR', sans-serif;">
					  <li class="nav-item">
					    <a href="/ddit/faq" class="nav-link
					    	<c:if test="${param.faqType==null||param.faqType==''}">active</c:if>
					    " data-toggle="tab" href="#qwe">전체</a>
					  </li>
					  <li class="nav-item">

					  <input type="hidden" name="faqType" value="${param.faqType}" />

					    <a href="/ddit/faq?faqType=제증명" class="nav-link
					    	<c:if test="${param.faqType=='제증명'}">active</c:if>
					    " data-toggle="tab"
					     href="#qwe">제증명</a>
					  </li>
					  <li class="nav-item">
					    <a href="/ddit/faq?faqType=외래" class="nav-link
					    	<c:if test="${param.faqType=='외래'}">active</c:if>
					    " data-toggle="tab" href="#asd">외래</a>
					  </li>
					  <li class="nav-item">
					    <a href="/ddit/faq?faqType=기타" class="nav-link
					    	<c:if test="${param.faqType=='기타'}">active</c:if>
					    " data-toggle="tab" href="#zxc">기타</a>
					  </li>
					</ul>


					<div class="tab-content" >
						<!-- 게시판 및 페이징 시작 -->
						<div class="table-responsive">
							<div class="table-wrapper" style="width: 100%;" style="font-family: 'Noto Sans KR', sans-serif;">
								<div class="row" style="margin: 20px;">
								  	<c:if test="${pageVO.content==null}">
								  		<h3 style="text-align:center;">해당 자주 묻는 질문은 없습니다.</h3>
								  	</c:if>
								</div>
								<!-- 내용 시작 -->
								<div class="accordion accordion-flush" id="accordionFlushExample">
									<c:forEach var="faqVO" items="${pageVO.content}" varStatus="stat" >
										 <div class="accordion-item">
										    <h2 class="accordion-header" id="flush-heading${faqVO.faqNum}">
										      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										      data-bs-target="#flush-collapse${faqVO.faqNum}" aria-expanded="false" aria-controls="flush-collapse${faqVO.faqNum}"
										      style="font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">
										        ${faqVO.faqTitle}
										      </button>
										    </h2>
										    <div id="flush-collapse${faqVO.faqNum}" class="accordion-collapse collapse" aria-labelledby="flush-heading${faqVO.faqNum}" data-bs-parent="#accordionFlushExample">
										      <div class="accordion-body">
										      	 ${faqVO.faqContent}
										      </div>
										    </div>
										 </div>
									 </c:forEach>
								</div>



								<!-- 내용 끝 -->
							</div>
						</div>
						<!-- 페이징 시작 -->
						<nav class="paginationBtn" aria-label="Page navigation example" style="margin-top:20px;">
							<ul class="pagination">
								<!-- back -->
								<li class="page-item <c:if test='${pageVO.startPage lt 6}'>disabled</c:if>">
									<a style="border-radius:20px; margin:0px 5px;" class="page-link" href="/ddit/faq?faqType=${param.faqType}&currentPage=${pageVO.startPage-1}">Prev</a>
								</li>

								<c:forEach var="pNo" begin="${pageVO.startPage}" end="${pageVO.endPage}">
									<li class="page-item
										<c:if test='${pageVO.currentPage==pNo}'>active</c:if>
										<c:if test='${currentPage==pNo}'>active</c:if>
										">
										<a style="border-radius:50%; margin:0px 5px;" class="page-link" href="/ddit/faq?faqType=${param.faqType}&currentPage=${pNo}">${pNo}</a>
									</li>
								</c:forEach>

								<!-- pre -->
								<li class="page-item <c:if test='${pageVO.endPage ge pageVO.totalPages}'>disabled</c:if>">
									<a style="border-radius:20px; margin:0px 5px;" class="page-link" href="/ddit/faq?faqType=${param.faqType}&currentPage=${pageVO.startPage+5}">Next</a>
								</li>
							</ul>
						</nav>
						<!-- 페이징 끝 -->


						<!-- 게시판 및 페이징 끝 -->
					</div>
					<footer style="width:500px; margin-left:230px;" >
						<input type="submit" class="col-sm-3 btn btn-primary violetBtn" id="searchBtn" value="검색" style="font-family: 'Noto Sans KR', sans-serif; float: right; margin-left: 10px;">
						<input type="text" class="col-sm-6 form-control" name="keyword" value="${keyword}" placeholder="검색어를 입력해주세요" style="font-family: 'Noto Sans KR', sans-serif; width: 50%; float: right; opacity: 0.8;">
					</footer>
				<!-- Tab 끝 -->
			</div>
			<div class="col-1"></div>
		</div>
	</form>
	<!-- 분류 선택 -->
	<!-- 공지사항 nav 끝 -->

</section>
<!-- main section 끝 -->