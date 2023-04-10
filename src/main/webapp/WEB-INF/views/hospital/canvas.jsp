<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap 4 -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<!-- AdminLTE 3 -->
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.1/dist/js/adminlte.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.1/dist/css/adminlte.min.css" />

<!-- icon setting - font awesome -->
<script src="https://kit.fontawesome.com/5f4aa574e8.js"></script>

<!-- font setting google font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" />

<!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
	body {
		user-select: none;
		font-family: 'Noto Sans KR', sans-serif;
		font-size : 1rem;
	}

	button{
		width: 90px;
	}
	
	body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .content-wrapper, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-footer, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-header{
		margin-left: 150px; 
	}
	
	.main-sidebar, .main-sidebar::before{
		width : 150px;
	}
	
	.circleColor{
		border-radius:50%;
		width:20px;
		height:20px;
		display:flex;
		justify-content: center;
	}
	
	.imgSelectDiv{
		border: 2px solid red;
	}
</style>

<script>
	var  img, canvas, ctx; 
	let startX, startY, endX, endY;

	let lineColor = 'red';

	window.onload = function(){
		img = document.getElementById('mediaImage'); 
		canvas = document.getElementById('canvas');

		init(); 
		setMouse();
		setLineColor();
	}
	
	function init(){
		canvas.width = img.offsetWidth;
		canvas.height = img.offsetHeight;

		canvas.style.position = 'absolute';
		canvas.style.top = getPosY(img) + 'px';
		canvas.style.left = getPosX(img) + 'px';
		canvas.style.zIndex = 1;

		ctx = canvas.getContext("2d");
		ctx.lineJoin = 'round';
		ctx.strokeStyle = lineColor;
		setLineWidth();

		document.body.appendChild(canvas);
	}

	function getPosX(element){
	    let posX = element.offsetLeft;
	    if(element.offsetParent){
	        posX += element.offsetParent.offsetLeft;
	    }
	    return posX;
	}

	function getPosY(element){
	    let posY = element.offsetTop;
	    if(element.offsetParent){
	        posY += element.offsetParent.offsetTop;
	    }
	    return posY;
	}

	function setMouse(){

		canvas.addEventListener("mousedown", function(e) {
			startX = e.clientX - canvas.offsetLeft;
			startY = e.clientY - canvas.offsetTop;
		});

		canvas.addEventListener("mousemove", function(e) {

			if (e.buttons === 1) {
				endX = e.clientX - canvas.offsetLeft;
				endY = e.clientY - canvas.offsetTop;

				ctx.beginPath();
				ctx.moveTo(startX, startY);
				ctx.lineTo(endX, endY);
				ctx.stroke();

				startX = endX;
				startY = endY;
			}

		});

		canvas.addEventListener("mouseup", function(e) {
			endX = e.clientX - canvas.offsetLeft;
			endY = e.clientY - canvas.offsetTop;
		});

	}
	
	function save(){

		Swal.fire({
			title: '이미지를 다운로드 하시겠습니까?',
			showDenyButton: true,
			confirmButtonText: '확인',
			denyButtonText: '취소',
		}).then(result => {
			if(result.isConfirmed){
				const imgOrigin = document.getElementById("mediaImage");

				const combinedCanvas = document.createElement("canvas");
				combinedCanvas.width = imgOrigin.offsetWidth;
				combinedCanvas.height = imgOrigin.offsetHeight;

				const combinedCtx = combinedCanvas.getContext("2d");

				combinedCtx.drawImage(imgOrigin, 0, 0, imgOrigin.width, imgOrigin.height);
				combinedCtx.drawImage(canvas, 0, 0);

				const dataUrl = combinedCanvas.toDataURL("image/png");

				const link = document.createElement("a");
				link.download = "image.png";
				link.href = dataUrl;

				link.click();
			}
		});
	}

	function setLineWidth(){
		ctx.lineWidth = document.querySelector('#lineWidth').value;
	}

	function setLineColor(){
		
		const colors = document.querySelector('#colors');
		colors.addEventListener('change', function(e){
			lineColor = e.target.value;
			ctx.strokeStyle = e.target.value;
		});
		
		const circleColors = document.querySelectorAll('.circleColor'); 
		circleColors.forEach(function(v){
			v.addEventListener('click', function(e){
				lineColor = e.target.dataset.value;
				ctx.strokeStyle = e.target.dataset.value;
			});
		});
		
	};
	
	$(document).on("click", ".circleColor", function(e){
		$("input[name='color']").val(e.target.dataset.value);
	});
	
</script>
<title>Home</title>
</head>
<body style="background-color: #657D96; height: auto;">
<!-- top navbar 시작 -->
<div style="width: 100%;">   
	<nav class="main-header navbar-expand navbar-white d-flex" style="background-color: #2f3338; border: none; width:100%; height:50px;">
		<div class="d-flex justify-content-around align-items-center m-1 p-2" style="display: inline-block; border:2px solid #FF5252;">
			<div class="mr-2" style="color:#ffffff;">굵기조절&nbsp;</div>
			<input class="lineWidth p-2" type="range" id="lineWidth" value="3" min="1" max="8" onchange="setLineWidth();" />
		</div>
		<div class="d-flex justify-content-around align-items-center m-1 p-2" style="display: inline-block; border:2px solid #FF5252;">
			<div class="mr-2" style="color:#ffffff;">색상변경&nbsp;</div>
			<input class="m-2 colors" type="color" id="colors" name="color" value="#ff0000">
			<button type="button" class="circleColor" data-value="#ff0000" style="background-color:red;"></button>
			<button type="button" class="circleColor" data-value="#0000ff" style="background-color:blue;"></button>
			<button type="button" class="circleColor" data-value="#ffffff" style="background-color:white;"></button>
		</div>
		<button type="button" class="m-2 btn btn-info" id="reset" onclick="init();">초기화</button>
		<button onclick="save();" class="m-2 btn btn-success" >다운로드</button>
		<button onclick="closeCanvas();" class="m-2 btn btn-secondary" >닫기</button>
	</nav>
</div>
<!-- top navbar 끝 -->

<aside class="main-sidebar sidebar-dark-primary" style="height: auto;">
	<a href="#" class="brand-link">
		<img src="/resources/images/layout/hospital/hos_logo.png" alt="병원 로고" />
		<img src="/resources/images/layout/hospital/TWO_CLICK.png" alt="병원 로고" class="brand-text" style="" />
	</a>
	<div>
		<nav class="mt-2">
			<div id="imgThumbShow">

			</div>
		</nav>
	</div>
</aside>
<!-- aside bar 끝 -->

	<div class="content-wrapper" style="background-color: rgb(101, 125, 150);height: auto;min-height: 1047px;max-height: 1047px;"> 
		<section class="content" style="margin-top: 1%;">
			<div class="row">
	         	<div class="col-lg-8">
					<canvas id="canvas"></canvas>
					<img id="mediaImage" src="" style="width:700px;" />
				</div>
		  	</div>
		</section>
	</div>
</body>
</html>

<script>
// 사이드 바 썸네일 이미지 넣기 시작
var thumbHtml = '';
thumbHtml += '<ul class="nav nav-pills nav-sidebar flex-column sidebaricon" data-widget="treeview" role="menu" data-accordion="false" >';
var choiceImages = opener.document.getElementsByClassName("imgSelect");
if(choiceImages.length == 0){
	window.close();
}

console.log(choiceImages[0].currentSrc);

var setting = 0;
var cntImage = 0;
for( var i = 0; i < choiceImages.length; i++ ){
	var checkImg = choiceImages[i].currentSrc;

	if(setting == 0){
		mainImage(checkImg);
		setting++;
	}
	
	
	console.log(checkImg);
	
	thumbHtml += '<li class="nav-item">';
	thumbHtml += '	<i style="color:white;">';
	thumbHtml += '		<div style="float:left;">' + (cntImage++ + 1) + "</div>";
// 	thumbHtml += '		<img src="' + checkImg + '" class="thumbImg" style="width:100px;height:auto; float:right;"/>'; 
	thumbHtml += '		<div class="mx-1 my-2 text-center">';
	thumbHtml += ' 			<div class="mt-2 d-flex justify-content-center align-items-center bg-black mediaImgBox" style="width: 100px; height: 100px; float:right;">';
	thumbHtml += ' 				<img src="' + checkImg + '" class="thumbImg" alt="' + checkImg + '" id="' + checkImg + '" style="max-height: 100%; max-width: 100%; " />'; 
	thumbHtml += '			</div>';
	thumbHtml += '		</div>';	 
	thumbHtml += '	</i>';
	thumbHtml += '</li>';
	thumbHtml += '	<i>'
	thumbHtml += '		<br />';
	thumbHtml += '	</i>';
	thumbHtml += '</li>';
}
thumbHtml += '</ul>';
document.getElementById("imgThumbShow").innerHTML = thumbHtml;
//사이드 바 썸네일 이미지 넣기 끝

//썸네일 이미지 클릭 시 메인 이미지 출력
function mainImage(img) {
	var thumbImageSp = img.split("s_");
	var path = thumbImageSp[0];
	var mainImg = thumbImageSp[1];
	$("#mediaImage").attr('src', path + mainImg);
}
 
$("#mediaImage").on('load' ,function(){
	img = document.getElementById('mediaImage');
	init();
});

$(document).on("click", ".thumbImg", function(){
	mainImage(this.src);
	
	const imgTarget = $(this).parent();
	
	if(!imgTarget.hasClass('imgSelectDiv')){
		imgTarget.parents().find(".imgSelectDiv").each(function(){
			$(this).removeClass('imgSelectDiv'); 
		});
		imgTarget.addClass('imgSelectDiv');
	} else { // 두번째 클릭
		imgTarget.removeClass('imgSelectDiv');
	}
});

function closeCanvas(){
	Swal.fire({
		title: '창을 닫으시겠습니까?',
		showDenyButton: true,
		confirmButtonText: '확인',
		denyButtonText: '취소',
	}).then(result => {
		if(result.isConfirmed){
			window.close();
		}
	});
}


</script>
<input type="hidden" id="_csrfParameterName" value="${_csrf.parameterName}" />
<input type="hidden" id="_csrfHeaderName" value="${_csrf.headerName}" />
<input type="hidden" id="_csrfToken" value="${_csrf.token}" />
<input type="hidden" id="_empNum" value="${empInfo.empNum}" />
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
