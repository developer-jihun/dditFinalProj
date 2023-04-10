<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
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
<style>
h1, h3 {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
}
h5, span {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 300;
}
</style>
<title>${httpStatus} ${statusName}</title>
</head>
<body>
	<div class="container vh-100">
		<div class="d-flex justify-content-center align-items-center" style="height: 100%;">
			<div class="card border-0 shadow-lg" style="width: 80%; height: 80%;">
				<div class="text-center m-auto" style="width: 60%; height: 70%;">
					<div class="row">
						<div >
							<img src="/resources/images/layout/ddit/errorPageImg.png" alt="이미지" style="width: 100%;"/>
						</div>
						<div>
							<h1 class="display-1">${httpStatus}</h1>
							<h3 class="mb-4">${statusName}</h3>
							<h5 class="mb-4">${statusContent}</h5>
							<a href="javascript:history.back();" class="btn btn-primary btn-lg border-0"
							   style="width: 170px; background-color: #9d59f0;">
								<i class="fa-solid fa-arrow-left"></i> <span>이전 페이지</span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>