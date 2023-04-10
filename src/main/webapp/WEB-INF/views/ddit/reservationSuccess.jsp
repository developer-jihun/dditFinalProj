<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
.revBtn {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 100px;
	margin-bottom: 50px;
}

.reservationBtn {
	background-color: #904aff;
	border: none;
	width: 200px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
}
</style>
<!-- Head Image 시작 -->
<div class="boardHeadImage">
	<div class="wrapper">
		<div class="slide">
			<img src="/resources/images/layout/ddit/resvHeadImg.png" />
		</div>
	</div>
</div>
<!-- Head Image 끝 -->
<!-- main section 시작 -->
<section class="container">
	<div style="margin-left: 7%; width: 85%;">
		<img src="/resources/images/layout/ddit/reservationSuccessImg.png" alt="reservationSuccessImg" />
	</div>
	<div class="row revBtn" style="padding-bottom: 21px;">
		<a class="col-sm-2 btn btn-primary btn-lg reservationBtn" type="button" href="/ddit" style="border-radius: 30px;">홈으로</a>
		<a class="col-sm-2 btn btn-primary btn-lg reservationBtn" type="button" style="margin-left: 100px; border-radius: 30px;" href="/ddit/resv/list">내 예약조회하기</a>
	</div>
</section>

<!-- main section 끝 -->