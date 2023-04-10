<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- summernote -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>


<style>
/* 뒤로가기, 게시물등록 버튼 */
    .listBtn, .insertBtn{
        border-radius:20px;
        border:none;
        background-color: #904aff;
        color:white;
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 500;
    }

/* 글씨체 css */
    label{
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 700;
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

.redBtn{
	background-color:#FF5252;
	border:none;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight:500;
	color:white;
}

.redBtn:hover{
	background-color:#e13636 !important;
	border:none;
	color:white;
}
</style>

<!-- 글쓰기 실패하면 안내창 뜸 -->
<c:if test='${error == "writeError"}'>
	<script>
		$(function() {
			alert("실패");
		});
	</script>
</c:if>

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
        <div class="row" style="margin-left:7%; margin-top:50px; width:85%; height: 100px; border-bottom:1px solid gray;">
            <div class="col-12">
                <h4 style="margin-left:50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight:700;">문의게시판</h4>
            </div>
            <div class="col-6">
                <h6 style="margin-left:50px;  font-family: 'Noto Sans KR', sans-serif; opacity: 0.5; font-size:14px;">home   >   고객의 소리   >   문의게시판</h6>
            </div>
        </div>
        <!-- 문의게시판 nav 끝 -->
        <form action="/ddit/inquiry/create" method="post" id="inqForm">
            <div style="margin-left:7%; margin-top:50px; margin-bottom:30px; width:85%; height:auto;" >
                <div class="mb-3 row">
                    <div class="col-sm-1"></div>
                    <label for="inqTitle" class="col-sm-1 col-form-label">제목</label>
                    <div class="col-sm-9">
                    <input type="text" class="form-control" id="inqTitle" name="inqTitle" value="${inqVO.inqTitle}" placeholder="제목을 입력해주세요" required>
                    <!-- 작성자의 정보  -->
                    <!-- inqNum 데이터 -->
                    <c:if test="${inqVO.inqNum!=null}">
                    	<input type="hidden" id="inqNum" name="inqNum" value="${inqVO.inqNum}" />
                    </c:if>
                     <c:if test="${inqVO.inqNum==null}">
                    	<input type="hidden" id="inqNum" name="inqNum" value="0" />
                    </c:if>
                    <!-- 차트번호 -->
                    <c:choose>
                    	<c:when test="${ptVO.ptNum == null}">
                    		<input type="hidden" id="ptNum" name="ptNum" value="${inqVO.ptNum}" />
                    	</c:when>
                    	<c:otherwise>
                    		<input type="hidden" id="ptNum" name="ptNum" value="${ptVO.ptNum}" />
                    	</c:otherwise>
                    </c:choose>
                    <!-- 작성자명 = 현재 로그인한 사람의 이름 -->
                    <c:choose>
                    	<c:when test="${ptVO.ptNm == null}">
                    		<input type="hidden" id="inqWrtrNm" name="inqWrtrNm" value="비회원" />
                    	</c:when>
                    	<c:otherwise>
                    		<input type="hidden" id="inqWrtrNm" name="inqWrtrNm" value="${ptVO.ptNm}" />
                    	</c:otherwise>
                    </c:choose>
                    </div>
                    <div class="col-sm-2"></div>
                </div>

                <div class="mb-3 row">
                    <div class="col-sm-1"></div>
                    <label for="inqContent" class="col-sm-1 col-form-label">내용</label>
                    <div class="col-sm-9">
                        <textarea class="form-control" id="inqContent" name="inqContent" required>${inqVO.inqContent}</textarea>
                    </div>
                    <div class="col-sm-2"></div>
                </div>
            </div>

            <div style=" margin-left:7%; width:85%; margin-bottom: 20px; height: auto;">
                <div class="row mb-3" style="padding-bottom:30px;">
                    <label for="inqPw" class="offset-sm-1 col-sm-1 col-form-label">비밀번호</label>
                    <div class="col-sm-3">
                        <input type="password" class="form-control" id="inqPw" name="inqPw" value="${inqVO.inqPw}" disabled="disabled">
                    </div>
                    <div class="offset-sm-1 col-sm-3">
                        <label class="form-check-label" for="flexCheckDefault" style="margin-right:10px;">
                            비밀글
                        </label>
                        <input class="form-check-input checkBox" type="checkbox" value="secretChk" id="flexCheckDefault" name="secretChk"
                        	<c:if test="${ptVO.ptNm == null }">required</c:if>>
                    </div>
                    <div class="col-sm-2 text-end">
                    	<button type="button" class="btn btn-success"
                    			style="border: none; font-family:'Noto Sans KR', sans-serif; font-weight: 500;"
                    			onclick="inputTestInqData();">시연용</button>
                    </div>
                </div>
            </div>

            <hr style="margin-left:7%; width:85%; opacity: 0.3;"/>

            <div style="margin-left:10%; margin-right:10%;">
                <input type="button" class="btn btn-danger redBtn listBtn" value="뒤로가기" style="margin-left:50px;" onclick="backToDetail()"/>
                <input type="submit" class="btn btn-primary violetBtn insertBtn" value="게시물 등록" style="float:right; margin-right:7%;" />
            </div>
            <sec:csrfInput/>
        </form>
    </section>
<!-- main section 끝 -->
<script>

// 시연용 테스트 데이터 삽입
function inputTestInqData(){

	$('#inqTitle').val('질문이 있습니다.');
	$('#inqContent').summernote('code', '<p>질문이 있습니다.</p>');
	$('#flexCheckDefault')[0].checked = true;
	$('#inqPw')[0].disabled = false;
	$('#inqPw').val('1234');


}

    $(document).ready(function() {

        //여기 아래 부분
        $('#inqContent').summernote({
              height: 300,                 // 에디터 높이
              minHeight: null,             // 최소 높이
              maxHeight: null,             // 최대 높이
              focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
              lang: "ko-KR",					// 한글 설정
              placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
        });

    });

    // 뒤로가기 버튼을 눌렀을 때
    function backToDetail(){
    	window.location.href="/ddit/inquiry";
    }

    // 비밀글 checkbox에 check가 되어있다면, 비밀번호 입력란이 활성화 된다.
    $(document).ready(function() {
    	$("#flexCheckDefault").change(function() {
            if ($(this).is(':checked')) {
            	$("#inqPw").removeAttr("disabled");
            	$("#inqPw").attr("required","true");
            }else{
            	$("#inqPw").attr("disabled","true");
            }

        });

    	// 수정할 땐 비밀번호가 입력되있던 게시물일 경우 비밀글에 check되어있고 비밀번호의 disabled를 해제한다.
    	var inqPw = $("#inqPw").val();

        if(inqPw != 0){
    		$(".checkBox").prop("checked", true);
    		$("#inqPw").removeAttr("disabled");
    	}
    });


    // 내용을 입력하지않았을때
    $(".insertBtn").on("click",function(event){
    	if($('#inqContent').summernote('isEmpty')|| $('#inqContent').summernote('')) {
    		event.preventDefault();

	        alert("내용을 입력해주세요");
	        return false;
    	}
    });

    // 공백만 입력했을때
    $(".insertBtn").on("click",function(event){
    	var inqCon = $('#inqContent').summernote('code');
    	console.log("inqCon : " + inqCon);
    	inqCon = inqCon.replace(/<[^>]+>/g, "");
    	inqCon = inqCon.replace(/&nbsp;/ig, '');
		inqCon = inqCon.trim();

		if(inqCon == '' || inqCon == null){
	    	event.preventDefault();
			alert("내용을 입력해주세요")
			return false;
		}
    });

</script>
