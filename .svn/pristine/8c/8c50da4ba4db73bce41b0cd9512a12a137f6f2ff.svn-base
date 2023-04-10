<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<!-- bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery 3.6.0 -->
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<!-- icon setting = font awesome -->
<script src="https://kit.fontawesome.com/5f4aa574e8.js"></script>
<!-- google font + 500/700 -->
<!-- 사용시 font-weight : 500 or 700으로 줄것 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
<!-- Swiper Demo Css, JS setting -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<!-- favicon -->
<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/layout/ddit/logo/favicon-16x16.png">
<title>비밀번호 찾기</title>
<style>
/* 글씨체 css */
label{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
}

input{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 500;
}

/* Button css */
.chkBtn{
    background-color: #9d59f0;
    border-radius:30px;
    border:none;
    display: flex;
    justify-content: center;
    align-items: center;
    margin:auto;
    margin-top:50px;
    margin-bottom:50px;
    width:150px;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
}

.chkBtn[disabled]{
    background-color: #9d59f0;
    border:none;
}

.cancelBtn{
    background-color: #ff786e;
    border-radius:30px;
    border:none;
    color:white;
    display: flex;
    justify-content: center;
    align-items: center;
    margin:auto;
    margin-top:50px;
    margin-bottom:50px;
    width:150px;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
}

.certificationBtn, .certChkBtn {
    background-color: #904aff;
    border:none;
    border-radius: 50px;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
}
/* body */
body{
    background-color:#e6e6e6;
}

.cardbody{
    width: 700px;
    margin: auto;
    box-shadow: 5px 5px 8px rgba(113, 113, 113, 0.25);
    padding:45px;
    border-radius: 20px;
    background-color: white;
    -webkit-animation: slide-in-top 0.5s cubic-bezier(0.250, 0.460, 0.450, 0.940) both;
     animation: slide-in-top 0.5s cubic-bezier(0.250, 0.460, 0.450, 0.940) both;
}

@-webkit-keyframes slide-in-top {
    0% {
        -webkit-transform: translateY(-1000px);
                transform: translateY(-1000px);
        opacity: 0;
    }
    100% {
        -webkit-transform: translateY(0);
                transform: translateY(0);
        opacity: 1;
    }
}
    @keyframes slide-in-top {
    0% {
        -webkit-transform: translateY(-1000px);
                transform: translateY(-1000px);
        opacity: 0;
    }
    100% {
        -webkit-transform: translateY(0);
                transform: translateY(0);
        opacity: 1;
    }
}

a{
    margin-left:33%;
    text-decoration: none;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 500;
    color: gray;
}

a:hover{
    color: #404b57;
}
.violetBtn:hover{
	background-color:#7c3dde !important;
}

.redBtn:hover{
	background-color:#e13636 !important;
}
</style>
</head>
<body>

	<!-- main section 시작 -->
	<section class="container">
	    <div style="margin-left:7%; margin-top:13%; width:85%; margin-bottom: 100px;">
	        <div class="cardbody">
	            <h4 style="font-family: 'Noto Sans KR', sans-serif; font-weight:700;">비밀번호 찾기</h4>
	            <hr style="width:100%; height:2px; background:#FF5252; opacity:1; margin-bottom: 50px;"/>
	            <form style="padding-left:7%;" name="findPwForm" action="/ddit/findPw" method="post">
	                <div class="row mb-3" style="padding-bottom:30px;">
	                    <label for="ptNm" class="col-sm-2 col-form-label"><span style="color:red;">*</span>아이디</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control" id="ptId" name="ptId" required />
	                    </div>
	                </div>
	                <div class="row mb-3" style="padding-bottom:30px;">
	                    <label for="ptPhone1" class="col-sm-2 col-form-label"><span style="color:red;">*</span> 연락처</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control" id="ptPhone1" name="ptPhone1" maxlength="3" required />
	                    </div>
	                    <span style="width:10px; text-align: center;">-</span>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control" id="ptPhone2" name="ptPhone2" maxlength="4" required />
	                    </div>
	                    <span style="width:10px; text-align: center;">-</span>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control" id="ptPhone3" name="ptPhone3" maxlength="4" required />
	                    </div>
	                    <div class="col-sm-3">
	                        <input type="button" value="인증번호 받기" id="sendAuthNum" class="btn btn-primary certificationBtn" />
	                    </div>
	                </div>
	                <!-- 인증번호 확인 -->
	                <div id="authNumInputGroup" class="row mb-3 certificationText" style="display:none; padding-bottom:30px;">
	                    <label for="authNum" class="col-sm-2 col-form-label"><span style="color:red;">*</span> 인증번호</label>
	                    <div class="col-sm-4">
	                        <input type="text" class="form-control" id="authNum" name="authNum" required />
	                    </div>
	                    <div class="col-sm-2">
	                        <input type="button" value="인증번호 확인" id="checkAuthNum" class="btn btn-primary violetBtn certChkBtn" />
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-2"></div>
	                    <sec:csrfInput />
	                    <button type="submit" id="findPwBtn" class="col-3 btn btn-primary violetBtn btn-lg chkBtn" disabled>확인</button>
	                    <button type="button" class="col-3 btn btn-danger redBtn btn-lg cancelBtn" onclick="javascript:location.href='/ddit/login';">취소</button>
	                    <div class="col-2"></div>
	                </div>
	                <div>
	                    <a href="/ddit/findId" >아이디도 잊어버리셨나요?</a>
	                </div>
	            </form>
	        </div>
	    </div>
	</section>
	<!-- main section 끝 -->
</body>
<script>
//인증번호 받기 버튼 클릭시
$("#sendAuthNum").on("click",function(){

	const findPwForm = document.findPwForm;
	const ptPhone = findPwForm.ptPhone1.value + findPwForm.ptPhone2.value + findPwForm.ptPhone3.value;

	if(!ptPhone.match(/^[\d]{9,11}$/)){
		alert('연락처를 다시 한번 확인해주세요.');
		return false;
	}

	fetch('/ddit/sendFindIdPwAuthNum', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : '${_csrf.token}',
			'Content-Type' : 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			ptPhone : ptPhone
		})
	})
		.then(res => {
			if(!res.ok) throw new Error();
			return res.text();
		})
		.then(text => {
			if(text == 'FAILED') throw new Error();

			alert('인증번호가 발송되었습니다.');
			$('#authNum').val('');
			$('#authNum').prop('disabled', false);
		    $('#checkAuthNum').prop('disabled', false);
		    $("#findPwBtn").prop('disabled', true);
		    $("#authNumInputGroup").show();
		})
		.catch(() => {
			alert('잠시 후 다시 시도해주세요.');
		});

});

// 인증번호 확인 버튼 클릭 후 일치하면..
$("#checkAuthNum").on("click",function(){

	const findPwForm = document.findPwForm;
	const authNum = findPwForm.authNum.value;

	fetch('/ddit/checkAuthNum', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : '${_csrf.token}',
			'Content-Type' : 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			authNum : authNum
		})
	})
		.then(res => {
			if(!res.ok) throw new Error();
			return res.text();
		})
		.then(text => {
			if(text == 'FAILED') {
				alert('인증번호가 틀립니다.');
				return false;
			}
			alert('인증되었습니다.');
			$('#authNum').prop('disabled', true);
			$('#checkAuthNum').prop('disabled', true);
			$("#findPwBtn").prop('disabled', false);
		})
		.catch(() => {
			alert('잠시 후 다시 시도해주세요.');
		});

});
</script>
</html>