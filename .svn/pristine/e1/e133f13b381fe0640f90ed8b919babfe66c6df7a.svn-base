<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
h6 {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 14px;
	margin-left: 50px;
}

.resvBtn {
	background-color: #904aff;
	border: none;
	border-radius: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: auto;
	margin-top: 100px;
	margin-bottom: 50px;
	width: 150px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
}

.userBtn, .nonUserBtn {
	transition: all 0.3s;
	position: relative;
	cursor: pointer;
}

.userBtn:hover, .nonUserBtn:hover {
	transform: scale(1.05);
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
	<!-- 온라인예약 nav 시작 -->
	<div class="row" style="margin-left: 7%; margin-top: 50px; width: 85%; height: 100px; border-top: 1px solid gray; border-bottom: 1px solid gray;">
		<div class="col-12">
			<h4 style="margin-left: 50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">온라인 예약</h4>
		</div>
		<div class="col-6">
			<h6 style="opacity: 0.5;">home > 예약 / 조회 > 온라인예약</h6>
		</div>
	</div>
	<!-- 온라인예약 nav 끝 -->

	<div style="margin-left: 7%; width: 85%;">
		<div class="row" style="margin: auto; margin-top: 50px; margin-left:5%;">
			<div class="col-md-1"></div>
			<div class="col-md-3" style="margin: auto;">
				<img src="/resources/images/layout/ddit/user_resv.png" class="userBtn" />
			</div>
			<div class="col-md-5" style="margin: auto;">
				<img src="/resources/images/layout/ddit/non_user_resv.png" class="nonUserBtn" />
			</div>
		</div>
	</div>
	<a type="button" id="nextBtn" class="btn btn-primary btn-lg resvBtn" href="javascript:alert('회원 여부를 선택해주세요.');">다음으로</a>
</section>
<!-- main section 끝 -->

<script>
	// 회원예약버튼 클릭시 이벤트 시작
	$(".userBtn").on("click", function() {
		$(".nonUserBtn").attr("src", "/resources/images/layout/ddit/non_user_resv.png")
		$(this).attr("src", "/resources/images/layout/ddit/selectUserResv.png");
		$('#nextBtn').attr('href', '/ddit/resv/mOnline');
	}); // 회원예약버튼 클릭시 이벤트 끝..

	// 비회원예약버튼 클릭시 이벤트 시작
	$(".nonUserBtn").on("click", function() {
		$(".userBtn").attr("src", "/resources/images/layout/ddit/user_resv.png")
		$(this).attr("src", "/resources/images/layout/ddit/selectNonUserResv.png");
		$('#nextBtn').attr('href', '/ddit/resv/nmOnline');
	}); // 회원예약버튼 클릭시 이벤트 끝..
</script>


