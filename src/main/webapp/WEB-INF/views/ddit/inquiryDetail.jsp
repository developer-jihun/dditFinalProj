<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
/* 삭제,수정, 목록으로 버튼 */
.listBtn, .modifyBtn, .deleteBtn{
    border-radius:20px;
    border:none;
    background-color: #904aff;
    color:white;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 500;
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
	border:none;
	color:white;
}
</style>
<!-- Head Image 시작 -->
<div class="boardHeadImage">
	<div class="wrapper">
		<div class="slide">
			<img src="/resources/images/layout/ddit/inquiryHeadImage.png" />
		</div>
	</div>
</div>
<!-- Head Image 끝 -->
<!-- main section 시작 -->
<section class="container">
	<!-- 문의게시판 nav 시작 -->
	<div class="row" style="margin-left: 7%; margin-top: 50px; width: 85%; height: 100px; border-bottom: 1px solid gray;">
		<div class="col-12">
			<!-- 게시물의 순번 -->
			<input type="hidden" value="${inqVO.inqNum }" id="inqNum" name="inqNum" />
			<h4 style="margin-left: 50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">${inqVO.inqTitle}</h4>
		</div>
		<div class="col-6">
			<div class="row">
				<fmt:formatDate var="sysDate" value="${inqVO.inqDt}" pattern="yyyy-MM-dd HH-mm-ss"/>
				<h6 class="col-6" style="margin-left: 50px; font-family: 'Noto Sans KR', sans-serif; font-size: 14px;">작성일자: ${sysDate}</h6>
				<h6 class="col-3" style="font-family: 'Noto Sans KR', sans-serif; font-size: 14px; display: inline-block;">작성자: ${inqVO.inqWrtrNm}</h6>
			</div>
		</div>
	</div>
	<!-- 문의게시판 nav 끝 -->
	<div style="margin-left: 7%; margin-top: 50px; margin-bottom: 100px; width: 85%; height: auto;">
		<h5 style="margin-left: 50px; margin-right: 50px; font-family: 'Noto Sans KR', sans-serif;">
			${inqVO.inqContent}
		</h5>
	</div>
	<hr style="margin-left: 7%; width: 85%;" />
		<c:choose>
			<c:when test="${inqVO.ansVO.ansContent != null}">
				<div style="border: 1px solid gray; border-radius: 20px; margin-left: 7%; width: 85%; margin-bottom: 20px; height: auto;" style="display:none;" >
					<div class="row" style="margin-left: 7%; width: 85%; height: 100px;">
						<div class="col-12">
							<h5 style="margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">답변</h5>
						</div>
						<div class="col-6">
							<div class="row">
								<fmt:formatDate var="sysdate" value="${inqVO.ansVO.ansDt}" />
								<h6 class="col-6" style="font-family: 'Noto Sans KR', sans-serif; font-size: 14px;">작성일자: ${sysdate}</h6>
								<h6 class="col-4" style="font-family: 'Noto Sans KR', sans-serif; font-size: 14px; display: inline-block;">작성자: <span class="badge rounded-pill bg-info text-white" style="font-size:100%;">관리자</span></h6>
							</div>
						</div>
					</div>
				<hr style="margin-left: 7%; width: 85%;" />
				<div style="margin-left: 7%;">
					<h5 style="margin: 50px 50px 60px 0px; font-family: 'Noto Sans KR', sans-serif;">
						${inqVO.ansVO.ansContent}
					</h5>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${ptVO.ptNum == inqVO.ptNum}">
					<div style="margin-right:10%;">
						<input type="button" class="btn btn-danger deleteBtn" value="게시물 삭제" style="float: right; margin-left: 10px; margin-right: 50px; background-color: #ff3e3e;" onclick="inquiryDelete()" />
						<input type="button" class="btn btn-primary modifyBtn" value="게시물 수정" style="float: right;" onclick="inquiryModify()" />
					</div>
				</c:when>
				<c:when test="${inqVO.inqWrtrNm == '비회원'}">
					<div style="margin-right:10%;">
						<input type="button" class="btn btn-danger deleteBtn" value="게시물 삭제" style="float: right; margin-left: 10px; margin-right: 50px; background-color: #ff3e3e;" onclick="unknownInqDelete()" />
						<input type="button" class="btn btn-primary modifyBtn" value="게시물 수정" style="float: right;" onclick="unknownInqModify()" />
					</div>
				</c:when>
			</c:choose>
		</c:otherwise>
	</c:choose>
	<div style="margin-left: 7%; margin-right: 7%;">
		<input type="button" class="btn btn-primary violetBtn listBtn" value="목록으로" onclick="backToList()" style="margin-left: 50px;"/>
	</div>
</section>
<script>
	// 목록으로 버튼을 누르면 목록으로 돌아간다.
	function backToList(){
		window.location.href="/ddit/inquiry";
	}

	// 게시물 삭제버튼을 누르면 삭제성공시 목록으로, 실패시 그 페이지에 남아있는다.
	function inquiryDelete(){
		console.log("회원글 삭제")
		var deleteChk = confirm("정말 삭제하시겠습니까?");

		if(deleteChk == true){
			window.location.href="/ddit/inquiry/delete?inqNum=" + ${inqVO.inqNum};
			alert("삭제가 완료되었습니다.")
		}else{
			alert("삭제가 취소되었습니다.");
		}
	}

	// 게시물 수정버튼을 누르면 create로 이동
	function inquiryModify(){
		window.location.href="/ddit/inquiry/write?inqNum=" + ${inqVO.inqNum};
	}

	// 게시물 식별용 순번데이터
	var inqNum = $("#inqNum").val();

	// 비회원이 작성한 글은 비밀번호를 입력해야만 삭제가 가능하다.
	function unknownInqDelete(){
		var password = prompt("비회원의글은 비밀번호를 입력해야 삭제가 가능합니다.")
		var data = {"inqPw" : password,
					"inqNum" : inqNum}

		$.ajax({
			url:"/ddit/inquiry/secret" ,
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			type:"POST" ,
			beforeSend:function(xhr) { // 데이터 전송 전 헤더에 csrf값 설정
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				if(result){
					var deleteChk = confirm("정말 삭제하시겠습니까?");

					if(deleteChk == true){
						window.location.href="/ddit/inquiry/delete?inqNum=" + ${inqVO.inqNum};
						alert("삭제가 완료되었습니다.")
					}else{
						alert("삭제가 취소되었습니다.");
					}
				}else{
					alert("비밀번호를 다시 확인해주세요.")
				}

			}
		});	// 비밀번호 보내기용 ajax 끝..
	} // unknownInqDelete 끝..


	// 비회원이 작성한 글은 비밀번호를 입력해야만 수정이 가능하다.
	function unknownInqModify(){
		var password = prompt("비회원의글은 비밀번호를 입력해야 수정이 가능합니다.")
		var data = {"inqPw" : password,
					"inqNum" : inqNum}

		console.log("data : " + JSON.stringify(data));

		$.ajax({
			url:"/ddit/inquiry/secret" ,
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			type:"POST" ,
			beforeSend:function(xhr) { // 데이터 전송 전 헤더에 csrf값 설정
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				if(result){
					window.location.href="/ddit/inquiry/write?inqNum=" + ${inqVO.inqNum};
				}else{
					alert("비밀번호를 다시 확인해주세요.")
				}

			}
		});	// 비밀번호 보내기용 ajax 끝..
	} // unknownInqDelete 끝..
</script>