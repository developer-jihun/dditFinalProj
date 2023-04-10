<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<title>회원가입</title>
<!-- bootstrap 5 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery 3.6.4 -->
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<!-- icon setting = font awesome -->
<script src="https://kit.fontawesome.com/5f4aa574e8.js"></script>
<!-- google font + 500/700 -->
<!-- 사용시 font-weight : 500 or 700으로 줄것 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
<!-- Swiper Demo Css, JS setting -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" /> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script> -->
<!-- favicon -->
<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/layout/ddit/logo/favicon-16x16.png">
<style>
/* Top navbar dropdown css효과 */
.dropdown:hover .dropdown-menu{
    display:block;
    margin-top:0;
    border:none;
    opacity: 0.85;
}

.dropdown{
    margin-left: 3.5rem;
    font-size: 1.05rem;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;

}

h6{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight : 500;
    font-size:14px;
    margin-left:50px;
}
/* 글씨체 css */
label{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
}

textarea, input, select{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 500;
}

.nav-link:hover{
    color:#404b57 !important;
}
/* Button css */
.modifyBtn{
    background-color: #904aff;
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

.duplicationChk{
    background-color: #904aff;
    border:none;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 500;
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
    animation: fadein 1s;
    -webkit-animation: fadein 1s; /* Safari and Chrome */
}

@keyframes fadein {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
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
            <h4 style="font-family: 'Noto Sans KR', sans-serif; font-weight:700;">회원가입</h4>
            <hr style="width:100%; height:2px; background:#FF5252; opacity:1; margin-bottom: 50px;"/>
            <form style="padding-left:7%;" name="signupForm" action="/ddit/insertPtAcc" method="post" onsubmit="return validation();">
            	<input type="hidden" name="ptNum" value="${requestScope.ptNum}" />
                <div class="row mb-3" style="padding-bottom:30px;">
                    <label for="ptId" class="col-sm-2 col-form-label">아이디</label>
                    <div class="col-sm-1"></div>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="ptId" name="ptId" required>
                    </div>
                    <div class="col-sm-1">
                        <input type="button" class="btn btn-primary violetBtn duplicationChk" value="중복확인" onclick="checkId();" />
                    </div>
                </div>
                <div class="row mb-3" style="padding-bottom:30px;">
                    <label for="ptPw" class="col-sm-2 col-form-label">비밀번호</label>
                    <div class="col-sm-1"></div>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="ptPw" name="ptPw" required>
                    </div>
                </div>
                <div class="row mb-3" style="padding-bottom:30px;">
                    <label for="ptPwChk" class="col-sm-3 col-form-label">비밀번호 확인</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="ptPwChk" name="ptPwChk" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-2"></div>
                    <sec:csrfInput />
                    <button type="submit" class="col-3 btn btn-primary violetBtn btn-lg modifyBtn">확인</button>
                    <button type="button" class="col-3 btn btn-danger redBtn btn-lg cancelBtn" onclick="cancelBtn()">취소</button>
                    <div class="col-2"></div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- main section 끝 -->
</body>
<script>
history.pushState(null, null, location.href);
window.onpopstate = function () {
    history.go(1);
    location.href = '/ddit/login';
};

flagId = false;
function checkId(){

	const ptId = document.signupForm.ptId.value;

	if(!ptId.match(/^[a-zA-Z0-9]{5,33}$/)){
		alert('아이디는 영문자, 숫자를 사용해 5~33자리 이내로 입력해주세요.');
		return false;
	}

	fetch('/ddit/checkId?ptId=' + ptId)
		.then(res => {
			if(!res.ok) throw new Error();
			return res.text();
		})
		.then(text => {
			if(text == 'SUCCESS') {
				alert('사용할 수 있는 아이디입니다.');
				flagId = true;
			} else if(text == 'FAILED') {
				alert('이미 사용중인 아이디입니다.');
				flagId = false;
			}
		})
		.catch(() => {
			alert('잠시 후 다시 시도해주세요.');
		});
}

function validation(){

	if(!flagId){
		alert('아이디 중복 검사를 해주세요.');
		return false;
	}

	const signupForm = document.signupForm;
	const ptPw = signupForm.ptPw.value;
	const ptPwChk = signupForm.ptPwChk.value;

	if(ptPw != ptPwChk){
		alert('비밀번호가 서로 일치하지 않습니다.');
		return false;
	}

	if(!ptPw.match(/^[A-Za-z\d!@#$%^&*?]+$/)){
		alert('비밀번호에 사용할 수 없는 문자가 포함되어 있습니다.');
		return false;
	}

	if(!ptPw.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*?]).{8,33}$/)){
		alert('비밀번호는 문자, 숫자, 특수문자를 조합해 8~33자 이내로 입력해주세요.');
		return false;
	}

	return true;
}

function cancelBtn(){
	var cancel = confirm("회원가입을 취소하시겠습니까?")
	if(cancel == true){
		location.href = '/ddit/login';
	}
	return false;
}
</script>
</html>