<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
.deleteBtn {
	text-align: center;
}

.trSelect {
	cursor: pointer;
}

.violetBtn {
	background-color: #904aff !important;
	border: none;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	color: white;
}

.violetBtn:hover {
	background-color: #7c3dde !important;
	color: white;
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
	color:white;
}

.btn-success, .btn-secondary, thead{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight:700;
}

tbody,p{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight:500;
}
.navbar-light .navbar-nav .nav-link {
	color: #f8f9fa;
	margin-left: 0.5rem;
	height: 38px;
	padding: 0.25rem;
	display: flex;
	align-items: center;
}

/* 이미지 등록 */
#empImg{
	max-width: 200px;
    max-height: 230px;
}
/* chatCss */
#chatButton{
	padding-right:1.25rem;
}
.navbar-badge{
	top:5px;
}
</style>
<!--  다음 주소api -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- 메시지창 -->
<script src="/resources/js/alertModule.js"></script>
<script type="text/javascript">

//전역 변수
var mode = "";
var globalAuth = "";
var flag_id = false;

//다음 주소찾기 API
function openHomeSearch() {
    new daum.Postcode({
        // 선택 완료 시 데이터를 폼에 담아준다.
        oncomplete : function(data) {
            document.EmpFrm.empZip.value = data.zonecode; // 우편번호
            document.EmpFrm.empAddr.value = data.address; // 주소
            document.EmpFrm.empDaddr.value = data.buildingName; // 건물주소
        }
    }).open();
}

// 직원 목록
// needSetupForm은 boolean type (true/false)
function searchEmp(needSetupForm){ // 폼에 직원 정보를 셋팅할지 여부

	// 검색 폼
	const empSearchFrm = document.searchFrm;

	//form의 name값을 사용해서 value 가져오기
	const hdofYn = empSearchFrm.hdofYn.value;
	const jbgdCd = empSearchFrm.jbgdCd.value;
	const keyword = empSearchFrm.keyword.value;

	let paramObject = {
			'hdofYn' : hdofYn,
			'jbgdCd' : jbgdCd,
			'keyword' : keyword
	};

	//formData자체가 enctype="multipart/form-data"처리를 하기때문에, 쿼리스트링으로 구성이 된다.
	//contentType과 processData를 false처리해주어야한다.
	let str = "";

	$.ajax({
		url : '/hospital/manage/empInfo/empList',
		type : 'get',
		data : paramObject,
		dataType : 'json',
		success : function(data){
			console.log("data :: ", data);
			var list = data.content;

			if(list.length == 0){
				str +="<tr><td colspan='3' style='text-align:center;'>해당하는 직원이 없습니다.</td></tr>";
				$("#trAdd").html(str);
				$('#reset').click();
				return;
			}

			// 직원 폼 값 입력
			if(needSetupForm){

				$("#empNm").val(list[0].empNm);
				$("#empNum").val(list[0].empNum);
				$("#jbgdCd").val(list[0].jbgdCd);
				$("#deptCd").val(list[0].deptCd);
				$("#doctLn").val(list[0].doctLn);
				$("#empStatus").val(list[0].empStatus);
				$("#empPhone").val(list[0].empPhone);

				let empBrdt = list[0].empBrdt;
				empBrdt = empBrdt.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');

				$("#empBrdt").val(empBrdt);
				$("#empZip").val(list[0].empZip);
				$("#empAddr").val(list[0].empAddr);
				$("#empDaddr").val(list[0].empDaddr);

				let empJncmpYmd = list[0].empJncmpYmd;
				empJncmpYmd = empJncmpYmd.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');

				$("#empJncmpYmd").val(empJncmpYmd);

				// 퇴사자
				let empRtrmYmd = list[0].empRtrmYmd;

				// 퇴사자 처리 부분
				if(empRtrmYmd == null){  // 재직자이면 hdofYn=1
					checkRtrmYnTag.checked = false; //퇴사체크 해제
					empRtrmYmdTag.readOnly = true;  //퇴사일자 폼 잠금
				} else {  // 퇴사자이면 hdofYn=0
					checkRtrmYnTag.checked = true; //퇴사체크 설정
					empRtrmYmdTag.readOnly = false;//퇴사일자 폼 해제

					empRtrmYmd = empRtrmYmd.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
					empRtrmYmdTag.value = empRtrmYmd; //퇴사날짜 넣기
				}

				$("#empId").val(list[0].empId);
				let empImg = list[0].empImg;
				if(empImg == null){
					empImg = '/doc_def_image.png';
				}
				$("#empImg").attr("src", "/resources/images/employee" + empImg);

			}


			$.each(list, function(i, empVO){
				if(globalAuth == "admin"){
					str += "<tr class= 'trSelect' style='height:60px; text-align:center;'>";
					str += "<td><button class='justify-content-center align-items-center btn btn-danger deleteBtn mx-auto d-none' type='button' style='width: 26px; height: 26px;'>&times</button></td>";
					str += "<td class= 'empNum'>" + empVO.empNum +  "</td>";
					str += "<td>" + empVO.empNm + "</td>";
					str += "</tr>";
				}else{
					str += "<tr class= 'trSelect' style='height:60px; text-align:center;'>";
					str += "<td><button class='justify-content-center align-items-center btn btn-danger deleteBtn mx-auto d-none' type='button' style='width: 26px; height: 26px;' disabled>&times</button></td>";
					str += "<td class= 'empNum'>" + empVO.empNum +  "</td>";
					str += "<td>" + empVO.empNm + "</td>";
					str += "</tr>";
				}
			});

			$("#trAdd").html(str);

			let paging = "";

			paging +="<ul class='pagination pagination-sm m-0 float-right'>";
			paging +="<li class='paginate_button page-item previous ";
			if(data.startPage <= 1){
				paging +="disabled";
			}
			paging +="' id='dataTable_previous'><a href='/hospital/manage/empInfo?currentPage=" + (data.startPage-5) + "'";
			paging +="aria-controls='dataTable' data-dt-idx='0' tabindex='0' class='page-link'>";
			paging +="«</a></li>";
			for(let i=data.startPage; i<=data.endPage; i++){
				paging +="<li class='paginate_button page-item ";
				if(data.currentPage == i){
					paging += "active";
				}
				paging +="' id='current-page-"+i+"'>"
				paging +="<a href='#' class='page-link' onclick='pageClick(" + i + ", true)' ";
				paging +="aria-controls='dataTable' data-dt-idx='1' tabindex='0'";
				paging +=">" + i + "</a></li>";

			}
			paging +="<li class='paginate_button page-item next ";
			if(data.endPage >= data.totalPages){
				paging +="disabled";
			}
			paging +="' id='dataTable_next'>";
			paging +="<a href='#' onclick='pageClick(" + (data.startPage + 5) + ", true)' ";
			paging +="aria-controls='dataTable' data-dt-idx='7' tabindex='0' class='page-link'>»</a></li>";
			paging +="</li></ul>";

			$("#dataTable_paginate").html(paging);

		}
	});

}



// 페이지 블록에서 숫자를 클릭했을 때
function pageClick(currentPage, needSetupForm){

	 // 이전에 활성화되어 있는 페이지 버튼의 active 클래스 제거
	 const previousPageItem = document.getElementsByClassName("page-item active");
	 if (previousPageItem.length > 0) {
		 previousPageItem[0].classList.remove("active");
	 }
	 // 현재 페이지 버튼에 active 클래스 추가
	  const pageItem  = document.getElementById("current-page-"+currentPage);
      if (!pageItem.classList.contains('active')) {
         pageItem.classList.add('active');
      }

	const empSearchFrm = document.searchFrm;

	//form의 name값을 사용해서 value 가져오기
	const hdofYn = empSearchFrm.hdofYn.value;
	const jbgdCd = empSearchFrm.jbgdCd.value;
	const keyword = empSearchFrm.keyword.value;


	//formData자체가 enctype="multipart/form-data"처리를 하기때문에, 쿼리스트링으로 구성이 된다.
	//contentType과 processData를 false처리해주어야한다.
	let str = "";

	$.ajax({
		url : '/hospital/manage/empInfo/empList',
		type : 'get',
		data : {
			'hdofYn' : hdofYn,
			'jbgdCd' : jbgdCd,
			'keyword' : keyword,
			'currentPage' : currentPage
		},
		dataType : 'json',
		success : function(data){

			var list = data.content;

			if(needSetupForm){

				$("#empNm").val(list[0].empNm);
				$("#empNum").val(list[0].empNum);
				$("#jbgdCd").val(list[0].jbgdCd);
				$("#deptCd").val(list[0].deptCd);
				$("#doctLn").val(list[0].doctLn);
				$("#empStatus").val(list[0].empStatus);
				$("#empPhone").val(list[0].empPhone);

				let empBrdt = list[0].empBrdt;
				empBrdt = empBrdt.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');

				$("#empBrdt").val(empBrdt);
				$("#empZip").val(list[0].empZip);
				$("#empAddr").val(list[0].empAddr);
				$("#empDaddr").val(list[0].empDaddr);

				// 입사일자
				let empJncmpYmd = list[0].empJncmpYmd;
				empJncmpYmd = empJncmpYmd.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
				$("#empJncmpYmd").val(empJncmpYmd);

				// 퇴사일자
				let empRtrmYmd = list[0].empRtrmYmd;

				// 퇴사자 처리 부분
				if(empRtrmYmd == null){  // 재직자이면 hdofYn=1
					checkRtrmYnTag.checked = false; //퇴사체크 해제
					empRtrmYmdTag.readOnly = true;  //퇴사일자 폼 잠금
				} else {  // 퇴사자이면 hdofYn=0
					checkRtrmYnTag.checked = true; //퇴사체크 설정
					empRtrmYmdTag.readOnly = false;//퇴사일자 폼 해제

					empRtrmYmd = empRtrmYmd.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
					empRtrmYmdTag.value = empRtrmYmd; //퇴사날짜 넣기
				}

				$("#empId").val(list[0].empId);

				let empImg = list[0].empImg;
				if(empImg == null){
					empImg = '/doc_def_image.png';
				}
				$("#empImg").attr("src", "/resources/images/employee" + empImg);

			}


			let str = "";
			$.each(list, function(i, empVO){
				if(globalAuth == "admin"){
					str += "<tr class= 'trSelect' style='height:60px; text-align:center;'>";
					str += "<td><button class='justify-content-center align-items-center btn btn-danger deleteBtn mx-auto d-none' type='button' style='width: 26px; height: 26px;'>&times</button></td>";
					str += "<td class= 'empNum'>" + empVO.empNum +  "</td>";
					str += "<td>" + empVO.empNm + "</td>";
					str += "</tr>";
				} else {
					str += "<tr class= 'trSelect' style='height:60px; text-align:center;'>";
					str += "<td><button class='justify-content-center align-items-center btn btn-danger deleteBtn mx-auto d-none' type='button' style='width: 26px; height: 26px;' disabled>&times</button></td>";
					str += "<td class= 'empNum'>" + empVO.empNum +  "</td>";
					str += "<td>" + empVO.empNm + "</td>";
					str += "</tr>";
				}
			});

			$("#trAdd").html(str);

		}
	});
}


// 화면띄웠을 때
$(function(){

	// CSRF 토큰
	csrfToken = $('#_csrfToken').val();

	// 퇴사 여부 체크박스
	checkRtrmYnTag = document.querySelector('#checkRtrmYn');
	// 퇴사 일자 입력란
	empRtrmYmdTag = document.querySelector('#empRtrmYmd');
	// 사번 입력란
	empNumTag = document.querySelector('#empNum');
	// 사원 명 입력란
	empNmTag = document.querySelector('#empNm');

	// 사원 검색 결과 목록의 tbody
	trAdd = document.querySelector('#trAdd');



	// 사원 목록 불러오기
	searchEmp(true);

	//검색키워드를 이용하여 직원 검색
	$(".btnSearch").on("click", function(){
		searchEmp(true);
	});


	//저장버튼을 누를때
	$("#save").on("click", function(){

		//폼데이터 가져오기(파일까지 포함하여 가져올 수 있음.)
		let empFrm = document.querySelector("#Empfrm");
		let formData = new FormData(empFrm);  //enctype : multipart일때 FormData객체를 생성

		//---------------------------------------------------
		let url = '/hospital/manage/empInfo/updateEmp';
		if(mode == "create"){
			if(!flag_id) {
				simpleErrorAlert('아이디 중복 검사를 해주세요.');
				return false;
			}
			url = '/hospital/manage/empInfo/createEmp';
		}
		//----------------------------------------------------

		//enctype : multipart를쓸때 쿼리스트링으로 formData를 보내기때문에,
		//contentType과 processData를 false처리해주어야한다.
		$.ajax({
			url : url,
			type: 'post',
			contentType: false,
			processData: false,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			data : formData,
			dataType : 'json',
			success : function(result){
				if(result == 1){

					// 직원 추가일 경우
					if(mode == "create"){

						searchEmp(false);
						simpleSuccessAlert("직원정보가 등록되었습니다.");

					} else if(mode =="update") { // 직원 수정일 경우

						// 직원 목록에서 직원 이름을 변경해줌
						const updatedEmpNum = empNumTag.value;
						const updatedEmpNm = empNmTag.value;
						const empRow = document.querySelectorAll('.trSelect');

						empRow.forEach(function(row){
							if(row.childNodes[1].textContent == updatedEmpNum){
								row.childNodes[2].textContent = updatedEmpNm;
							}
						});

						simpleSuccessAlert("직원정보가 수정되었습니다.");
					}

				} else if (result == 0){
					simpleErrorAlert("시스템 오류가 발생하였습니다. 다시 시도하여주시기 바랍니다.")
				}
			}
		});
	});

	// 퇴사 체크박스 및 퇴사일자 이벤트 연결
	checkRtrmYnTag.addEventListener("change", (event) => {

		if (event.target.checked) {
			empRtrmYmdTag.disabled = false;
			empRtrmYmdTag.readOnly = false;
			checkRtrmYnTag.checked = true;
		} else {
			empRtrmYmdTag.disabled = true;
			empRtrmYmdTag.value = '';
			checkRtrmYnTag.checked = false;
		}

	});

	// 직원 목록에서 직원을 선택할 경우 우측 폼에 직원 정보가 출력
	//동적으로 생성된 요소의 이벤트 처리
	$(document).on("click", ".trSelect", function(e){

		//td가 여러개 인데 그 중 클릭한 바로 그 td
		//클릭하면 그 직원의 사번을 가져와, 그 사번을 넘겨서 그직원의 정보를 가져온다.

		mode = "update";

		let empNum = $('.empNum', this).text();
		empNum = empNum.trim();

		$.ajax({
			url : "/hospital/manage/empInfo/getEmpInfo?empNum=" + empNum,
			type : "get",
			dataType : 'json',
			success: function(data){

				$("#empNm").val(data.empNm);
				$("#empNum").val(data.empNum);
				$("#jbgdCd").val(data.jbgdCd);
				$("#deptCd").val(data.deptCd);
				$("#doctLn").val(data.doctLn);
				$("#empStatus").val(data.empStatus);
				$("#empPhone").val(data.empPhone);

				let empBrdt = data.empBrdt;
				empBrdt = empBrdt.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');

				$("#empBrdt").val(empBrdt);
				$("#empZip").val(data.empZip);
				$("#empAddr").val(data.empAddr);
				$("#empDaddr").val(data.empDaddr);

				let empJncmpYmd = data.empJncmpYmd;
				empJncmpYmd = empJncmpYmd.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');

				$("#empJncmpYmd").val(empJncmpYmd);

				$('#empId').prop('readonly', true);
				$('#empPw').prop('readonly', true);
				$('#checkIdBtn').prop('disabled', true);

				// 퇴사자 처리 부분
				if(data.hdofYn){  // 재직자이면 hdofYn=1
					document.querySelector('#checkRtrmYn').checked = false; //퇴사체크 해제
					document.querySelector('#empRtrmYmd').readOnly = true;  //퇴사일자 폼 잠금
				} else {  // 퇴사자이면 hdofYn=0
					document.querySelector('#checkRtrmYn').checked = true; //퇴사체크 설정
					document.querySelector('#empRtrmYmd').readOnly = false;//퇴사일자 폼 해제
				}

				let empRtrmYmd = data.empRtrmYmd;

				if(empRtrmYmd != null){
					empRtrmYmd = empRtrmYmd.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
					$("#empRtrmYmd").val(empRtrmYmd);
				} else {
					$("#empRtrmYmd").val('');
				}

				$("#empId").val(data.empId);

				let empImg = data.empImg;
				if(empImg == null){
					empImg = '/doc_def_image.png';
				}

				$("#empImg").attr("src", "/resources/images/employee" + empImg)
				$('#file').val('');

			}
		});
	});


	//직원목록에서 직원을 갖다대면 삭제버튼이 나온다.
	$(document).on("mouseenter", ".trSelect", function(){

		let deleteBtn = $('.deleteBtn', this);
		deleteBtn.addClass("d-none");
		deleteBtn.addClass("d-flex");

	});

	//직원 목록에서 마우스를 떼면 삭제버튼이 사라진다
	$(document).on("mouseleave", ".trSelect", function(){
		let deleteBtn = $('.deleteBtn', this);
		deleteBtn.removeClass("d-flex");
		deleteBtn.addClass("d-none");

	});


	// 직원 삭제 버튼 클릭 시 삭제 알림창 출력
	$(document).on("click", '.deleteBtn', function(e){
		e.stopPropagation();

		Swal.fire({
			title: '해당직원을 삭제하시겠습니까?',
			showDenyButton: true,
			confirmButtonText: '삭제',
			denyButtonText: '취소',
		}).then((result1) => {
			if (result1.isConfirmed) {
				Swal.fire({
					title: '해당직원과 관련된 내용이 삭제됩니다.',
					text: '그래도 삭제하시겠습니까?',
					showDenyButton: true,
					confirmButtonText: '확인',
					denyButtonText: '취소',
				}).then(result2 => {
					if(result2.isDenied){
						return;
					} else if(result2.isConfirmed){

						const empNum = $(this).parents('.trSelect').children().eq(1).text().trim();
						deleteEmpInfo($(this), empNum);

					}
				});
			}
		});

	});

	// 직원정보 삭제
	function deleteEmpInfo(target, empNum){

		const csrfToken = $('#_csrfToken').val();
		$.ajax({
			url : '/hospital/manage/empInfo/deleteEmp',
			dataType : 'json',
			type : 'post',
			data : JSON.stringify({
				empNum : empNum
			}),
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
				xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			},
			success : function(res){

				searchEmp(false); // 우측 폼을 채우지 않는 직원 목록 재호출
				$('#reset').click(); // 직원정보 비우기
				simpleSuccessAlert("직원정보가 삭제되었습니다.");
			}
		});

	}



	//사진 삭제
	$("#deleteFile").on("click", function(){

		let empImg = document.getElementById("empImg");
		if(empImg.src.indexOf('/doc_def_image.png') != -1){
			simpleErrorAlert('업로드된 이미지가 없습니다.');
			return false;
		}

		let empNum = document.getElementById("empNum").value;

		Swal.fire({
			title: '이미지를 삭제하시겠습니까?',
			showDenyButton: true,
			confirmButtonText: '확인',
			denyButtonText: '취소',
		}).then(result => {
			if(result.isConfirmed){

				$.ajax({
					url : '/hospital/manage/empInfo/deleteFile',
					type : 'post',
					dataType : 'text',
					data : JSON.stringify({
						'empNum' : empNum
					}),
					beforeSend: function(xhr){
						xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
						xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
					},
					success: function(res){
						if(res == 0){
							simpleJustErrorAlert();
							return false;
						}
						empImg.src = "/resources/images/employee/doc_def_image.png";
						simpleSuccessAlert('이미지가 삭제되었습니다.');

					},
					error: function(err){
						simpleJustErrorAlert();
					}
				});
			} else if(result.isDenied){

			}
		});
	});


	//직원등록버튼을 누르면 모든 입력버튼이 초기화
	$("#reset").on("click", function(){

		mode = "create";

		$("#Empfrm").attr("action", "/hospital/manage/empInfo/createEmp?${_csrf.parameterName}=${_csrf.token}");
		$("#empImg").attr("src", "/resources/images/employee/s_cb8450a3-35e9-44e1-9598-730c60f5cb54_user.png");
		$("#empRtrmYmd").attr("disabled", true);
		$("#empId").prop("readonly", false);
		$("#empPw").prop("readonly", false);

		$('#checkIdBtn').prop('disabled', false);
	});


	//이미지 미리보기 시작
	$("#file").on("change", handleImgFileSelect);

	function handleImgFileSelect(event){  //change된 event가 따라온다.
		let files = event.target.files; //파일이 1개든 여러개든 파일을 가져온다.
		let fileArr = Array.prototype.slice.call(files); //배열형태로 저장한다.
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지만 가능합니다.");
				return;
			}

			let reader = new FileReader();
			reader.onload = function(event){
				//읽은 결과
				//<img src = "SFHEHFDG.jpg>"
// 				let img_html = "<img src=\"" + event.target.result + "\" style='width:140px;' />";
// 				$(".bg-register-image").html(img_html);

				$('#empImg').attr('src', event.target.result);
			}

			reader.readAsDataURL(f);
		});
	}
	//이미지 미리보기 끝


// -------------------------- 부서관리 시작 --------------------------

	//부서관리 클릭 시 모달창에 부서관리 List띄우기
	$("#deptButton").on("click", function(){

		$.ajax({
			url : '/hospital/manage/empInfo/getDeptList',
			type: 'get',
			success : function(result){
				getDeptList(result);
			}
		});
	});

	//부서관리 모달창에서 추가버튼 클릭 시
	$("#addButton1").on("click",function(){

		let jsonData = {deptNm : $(".addDept").val()};

		$.ajax({
			url : '/hospital/manage/empInfo/createDept',
			type: 'post',
			data: jsonData,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success: function(result){
				getDeptList(result);
				$(".addDept").val('');

			}
		});
	});

	$(document).on("click", "#deleteDept", function(){

		//부모를 뒤에두고, 앞에 자식을 둔다.
		let deptCd = $(".deptCd",$(this).parent().parent()).text().trim();
		let jsonData = {"deptCd" : deptCd};


		$.ajax({
			url : '/hospital/manage/empInfo/deleteDept',
			type:'post',
			data : jsonData,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success: function(result){
				getDeptList(result);
			}

		});
	});

	// 부서 수정
	$(document).on("click", ".updateDept", function(){

		$(".updateDept").hide();
		$(".deleteDept").hide();

		$(".saveDept").show();
		$(".back").show();

		//부모를 뒤에두고, 앞에 자식을 둔다.
		let deptNm = $(".deptNm", $(this).parent().parent()).children().val().trim(); //부서명 값
		let deptCd = $(".deptCd",$(this).parent().parent()).text().trim(); //순번 값

		$(".deptNm", $(this).parent().parent()).children().prop("readonly", false);
		$(".deptNm", $(this).parent().parent()).children().css("border", "1px solid black");

		$(document).on("click", ".back", function(){
			$(".saveDept").hide();
			$(".back").hide();

			$(".updateDept").show();
			$(".deleteDept").show();

			$(".deptNm", $(this).parent().parent()).children().val(deptNm);


			$(".deptNm", $(this).parent().parent()).children().prop("readonly", true);
			$(".deptNm", $(this).parent().parent()).children().css("border", "none");
		});
	});

	// 부서 저장
	$(document).on("click", ".saveDept", function(){

		//부모를 뒤에두고, 앞에 자식을 둔다.
		let deptNm = $(".deptNm", $(this).parent().parent()).children().val().trim(); //부서명 값
		let deptCd = $(".deptCd",$(this).parent().parent()).text().trim(); //순번 값

		let jsonData = {
			"deptCd" : deptCd,
			"deptNm" : deptNm
		};

		$.ajax({
			url : '/hospital/manage/empInfo/updateDept',
			type:'post',
			data : jsonData,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success: function(result){
				getDeptList(result);
			}
		}); //ajax 끝
	});


// -------------------------- 부서관리 끝 --------------------------

// -------------------------- 직급관리 시작 --------------------------

	//직급관리 클릭 시 모달창에 부서관리 List띄우기
	$("#jbgdButton").on("click", function(){

		$.ajax({
			url : '/hospital/manage/empInfo/getJbgdList',
			type: 'get',
			success : function(result){
				getJbgdList(result);
			}
		}); //ajax 끝
	});


	//직급관리 모달창에서 추가버튼 클릭 시
	$("#addButton2").on("click",function(){

		let jsonData = {jbgdNm : $(".addJbgd").val()};

		$.ajax({
			url : '/hospital/manage/empInfo/createJbgd',
			type: 'post',
			data: jsonData,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success: function(result){

				getJbgdList(result);
				$(".addJbgd").val('');
			}
		});
	});

	// 직급 수정버튼 클릭 시 css
	$(document).on("click", ".updateJbgd", function(){
		//alert("수정버튼클릭!")

		$(".updateJbgd").hide();
		$(".deleteJbgd").hide();

		$(".saveJbgd").show();
		$(".back2").show();

		//부모를 뒤에두고, 앞에 자식을 둔다.
		let jbgdNm = $(".jbgdNm", $(this).parent().parent()).children().val().trim(); //직급명 값
		let jbgdCd = $(".jbgdCd",$(this).parent().parent()).text().trim(); //순번 값


		$(".jbgdNm", $(this).parent().parent()).children().prop("readonly", false);
		$(".jbgdNm", $(this).parent().parent()).children().css("border", "1px solid black");

		$(document).on("click", ".back2", function(){
			$(".saveJbgd").hide();
			$(".back2").hide();

			$(".updateJbgd").show();
			$(".deleteJbgd").show();

			$(".jbgdNm", $(this).parent().parent()).children().val(jbgdNm);


			$(".jbgdNm", $(this).parent().parent()).children().prop("readonly", true);
			$(".jbgdNm", $(this).parent().parent()).children().css("border", "none");
		});
	});

	// 직급 버튼 수정 후 저장 클릭 시
	$(document).on("click", ".saveJbgd", function(){

		//부모를 뒤에두고, 앞에 자식을 둔다.
		let jbgdNm = $(".jbgdNm", $(this).parent().parent()).children().val().trim(); //직급명 값
		let jbgdCd = $(".jbgdCd",$(this).parent().parent()).text().trim(); //순번 값

		let jsonData = {
				"jbgdCd" : jbgdCd,
				"jbgdNm" : jbgdNm
				};

		$.ajax({
			url : '/hospital/manage/empInfo/updateJbgd',
			type:'post',
			data : jsonData,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success: function(result){
				getJbgdList(result);
			}
		}); //ajax 끝
	});

	// 직급 버튼 삭제 클릭 시
	$(document).on("click", "#deleteJbgd", function(){
		//alert("삭제버튼클릭!")

		//부모를 뒤에두고, 앞에 자식을 둔다.
		let jbgdCd = $(".jbgdCd",$(this).parent().parent()).text().trim(); //순번 값
		let jsonData = {"jbgdCd" : jbgdCd};


		$.ajax({
			url : '/hospital/manage/empInfo/deleteJbgd',
			type:'post',
			data : jsonData,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success: function(result){
				getJbgdList(result);
			}

		});
	});

// -------------------------- 직급관리 끝 --------------------------

	// 비밀번호 변경 문의
	if($("#changePW").is(":disabled")){
		$("#msg").html("비밀번호 변경 관련은 관리자에게 문의바랍니다.")
	}

	// 중복 검사 버튼
	$('#checkIdBtn').on('click', checkId);

});

// 부서목록
function getDeptList(result){
	let str = "";


	$.each(result, function(index, deptVO){
		//scope='row'란? 해당 셀이 행(row)을 위한 헤더 셀임을 명시함
		//scope='col'란? 해당 셀이 열(col)을 위한 헤더 셀임을 명시함
		//str += "<tr class='trSelect'><th scrope='row'>" + (index + 1)+ "</th>";
		str += "<tr class='deptTr' style='height:10%;'>";
		str += "<td class='deptTd'>";
		str += "<button class='btn btn-danger btn-sm icon deleteDept' id='deleteDept' type='button'>&times</button>"+"&nbsp";
		str += "<button class='btn btn-primary btn-sm icon updateDept' id='updateDept' type='button'><i class='fa-solid fa-eraser'></i></button>";
		str += "<button class='btn btn-success btn-sm icon saveDept' id='saveDept' type='button' style='display:none;'><i class='fa-regular fa-floppy-disk'></i></button>"+"&nbsp";
		str += "<button class='btn btn-primary btn-sm icon back' id='back' type='button' onclick='' style='display:none;'><i class='fa-sharp fa-solid fa-rotate-left'></i></button>";
		str += "<td class='deptCd'> " + deptVO.deptCd + "</td><td class='deptNm'>" + "<input type='text' name='deptNm' value='"+ deptVO.deptNm +"'readonly style='border:none;'/></td></tr>";
	});

	//.html() : 새로고침/ .append() : 누적
	$("#deptList").html(str);  //초기화한번 해주기

	var orgSelectedDeptCd = $("#deptCd").val();

	var option = "";
	option = '<option value="">---------</option>';
	$.each(result, function(index, deptVO){
		option += "<option value='"+deptVO.deptCd+"'>"+deptVO.deptNm+"</option>";
	});

	$("#deptCd").html(option);
	$("#deptCd").val(orgSelectedDeptCd);
}


function getJbgdList(result){
	let str = "";

	$.each(result, function(index, jbgdVO){

		str += "<tr class='jbgdTr' style='height:10%;'>";
		str += "<td class='jbgdTd'>";
		str += "<button class='btn btn-danger btn-sm icon deleteJbgd' id='deleteJbgd' type='button'>&times</button>";
		str += "<button class='btn btn-primary btn-sm icon ml-1 updateJbgd' id='updateJbgd' type='button'><i class='fa-solid fa-eraser'></i></button>";
		str += "<button class='btn btn-success btn-sm icon saveJbgd' id='saveJbgd' type='button' style='display:none;'><i class='fa-regular fa-floppy-disk'></i></button>";
		str += "<button class='btn btn-primary btn-sm icon ml-1 back2' id='back2' type='button' onclick='' style='display:none;'><i class='fa-sharp fa-solid fa-rotate-left'></i></button>";
		str += "<td class='jbgdCd'> " + jbgdVO.jbgdCd + "</td>";
		str += "<td class='jbgdNm'><input type='text' name='jbgdNm' value='"+ jbgdVO.jbgdNm +"'readonly style='border:none;' /></td>";
		str += "</tr>";
	});

	$("#jbgdList").html(str);  //초기화한번 해주기

	var orgSelectedJbgdCd = $("#jbgdCd").val();

	var option = "";
	option = '<option value="">---------</option>';
	$.each(result, function(index, jbgdVO){
		option += "<option value='"+jbgdVO.jbgdCd+"'>"+jbgdVO.jbgdNm+"</option>";
	});

	$("#jbgdCd").html(option);
	$("#jbgdCd").val(orgSelectedJbgdCd);
}

function updatePw(){
	var pw1= $('input[name=resetUserPW]').val();  // 변경할 비밀번호
	var pw2 = $('input[name=checkUserPW]').val(); // 변경 비밀번호 확인
	var empNum = $("#empNum").val(); // 사번
	if(pw1 != pw2){
		simpleErrorAlert("비밀번호가 일치하지않습니다.\n 다시 확인하여주십시오.")
		return false;
	}

	let data =  {
					'changedPw' : pw2,  // 변경할 비밀번호
					'empNum' : empNum,  // 사번
				};

	$.ajax({
		url : '/hospital/manage/empInfo/changePassword',
		data :JSON.stringify(data),
		beforeSend: function(xhr){
			xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
		},
		type : 'post',
		contentType: 'application/json;charset=utf-8',
		success: function(res){
			simpleSuccessAlert("비밀번호가 변경되었습니다.");
		}
	});
}

// 아이디 중복 검사
function checkId(){

	const empId = $('#empId').val();

	$.ajax({
		url: '/hospital/manage/empInfo/checkId',
		type: 'post',
		data: JSON.stringify({
			empId : empId
		}),
		dataType: 'text',
		beforeSend: function(xhr){
			xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		},
		success: function(result){

			if(result == 'FAILED'){
				flag_id = false;
				simpleErrorAlert('이미 사용 중인 아이디입니다.');
				return;
			}

			flag_id = true;
			simpleSuccessAlert('사용할 수 있는 아이디입니다.');
		}
	});

}
</script>
<sec:authorize access="hasRole('ROLE_ADMIN')">

	<script>
		$(function(){
			$("#empNm").prop("readonly", false); //직원명
			$("#doctLn").prop("readonly", false);//면허번호
			$("#jbgdCd").attr("readonly", false);//직급
			$("#deptCd").attr("readonly", false);//부서
			$("#empPhone").prop("readonly", false);//연락처
			$("#empBrdt").prop("readonly", false);//생년월일
			$("#empZip").prop("readonly", false);//우편번호
			$("#empAddr").prop("readonly", false);//주소
			$("#empDaddr").prop("readonly", false);//상세주소
			$("#empJncmpYmd").prop("readonly", false);//입사일
			$("#empId").prop("readonly", true);//아이디
			$("#empPw").prop("readonly", true);//비밀번호
			$("#deptButton").prop("disabled", false); //부서관리 버튼
			$("#jbgdButton").prop("disabled", false); //직급관리 버튼
			$(".btnSearchZip").prop("disabled", false); //직급관리 버튼
			$("#file").attr("disabled", false); //사진
			$("#uploadFile").attr("disabled", false); //사진 업로드 버튼
			$("#deleteFile").attr("disabled", false); //사진삭제 버튼
			$("#save").prop("disabled", false); //저장 버튼
			$("#reset").prop("disabled", false); //직원등록 버튼
			$("#changePW").prop("disabled", false); //직원비밀번호 변경 버튼
			$("#msg").remove();

			globalAuth = "admin";


// 			$(".deleteBtn").removeAttr("disabled");
// 			$(".deleteBtn").show();


// 			let attr = $('.deleteBtn').attr('disabled');
// 			console.log("attr: ", attr);
// 			$('.deleteBtn').removeAttribute('disabled');
// 			const mybutton = document.getelementsbyclassname('deletebtn');
// 			// 버튼 태그의 disabled 속성을 false로 설정
// 			myButton[0].disabled = false;
			$("#empRtrmYmdCheckBox").show();
			let empRtrmYmd = $("#empRtrmYmd");
			let empRtrmYmdYn = $("#empRtrmYmd").val();
			if(empRtrmYmdYn != null){
				empRtrmYmdYn = empRtrmYmdYn.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
				$("#empRtrmYmd").val(empRtrmYmdYn);

				document.querySelector('#checkRtrmYn').checked = true;
				empRtrmYmd.prop("readonly", false);

			}else {
				document.querySelector('#checkRtrmYn').checked = false;
			}

		});
	</script>
</sec:authorize>


<div class="content-wrapper"
	style="background-color: rgb(101, 125, 150); min-height: 873px;">
	<!-- main 검색창을 포함한 navbar 시작-->
	<nav class="navbar navbar-expand navbar-white navbar-light"
		style="background-color: #404b57;">

		<!-------------------- 검색대 -------------------->
<!-- 		<div class="dropdown"> -->
<!-- 			<input type="text" class="form-control" id="keyword" name="keyword" -->
<!-- 				placeholder="" style="width: 400px;" disabled> -->
<!-- 			<ul id="ptSearchDropdown" class="dropdown-menu"> -->
<!-- 			</ul> -->
<!-- 		</div> -->
		<!-------------------- 검색대 -------------------->
		<!-- 		<img src="/resources/images/layout/hospital/memo_icon.png" alt="메모" id="memo" class="brand-image elevation-1" style="margin-left: 15px;"> -->
		<ul class="navbar-nav ml-auto"></ul>
		<div class="manageMenu">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light active" href="/hospital/manage/empInfo">직원관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/drug">약품관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/txCode">처치 관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/manage/hosInfo">병원 기초정보관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/manage/statistics">병원 통계</a>
				</li>
			</ul>
		</div>
	</nav>

	<!-- main 검색창을 포함한 navbar 끝 -->
	<section class="content" style="margin-top: 1%;">
		<div class="row">
			<div class="col-md-4">
				<div class="card card-info" style="height: 900px;">

					<div class="card-header"
						style="background-color: #404b57; border: none;">
						<div class="d-flex justify-content-between align-items-center">
							<h2 class="card-title">직원 목록</h2>
						</div>
					</div>

					<div class="card-body">
						<div class="card-header">
							<form name="searchFrm" id="searchFrm" onsubmit="return false;">
								<input type="hidden" name="currentPage" value="${param.currentPage}" />
								<input type="hidden" name="size" value="${param.size}" />
								<div class="form-group">
									<label>직원 검색</label>&nbsp;&nbsp;
									<div class="input-group">
										<select id="hdofYn" name="hdofYn" class="form-control">
											<option value="">전체</option>
											<c:forEach var="hdofYn" items="${requestScope.hdpfYnList}">
												<option value="${hdofYn.commCdNm}">${hdofYn.commCdCnt}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="jbgdCd">직급</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div class="input-group">
										<select id="jbgdCdList" name="jbgdCd" class="form-control">
											<option value="">전체</option>
											<c:forEach var="jbgd" items="${requestScope.jbgdList}">
												<option value="${jbgd.jbgdCd}">${jbgd.jbgdNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label style="float: left;">이름/사번</label>&nbsp;&nbsp;
									<div class="input-group">
										<div class="input-group-prepend" style="width: 600px;">
											<input type="text" name="keyword" class="form-control"
												placeholder="이름/사번을 입력해주세요" value="${param.keyword}"
												style="float: left; width: 50%;" />&nbsp;&nbsp;
											<button type="button"
												class="btn btn-success btn-block btnSearch violetBtn"
												style="height: 100%; float: left; width: 100px; border-radius: 5px;">검색</button>
										</div>
									</div>
								</div>

							</form>
						</div>

						<!-- 						<div class="card-body" style="max-height: 317px; overflow-y: auto;"> -->
						<div class="card-body" style="height: 400px; overflow-y: auto;">
							<table class="table table-bordered text-center">
								<thead>
									<tr>
										<th style="width: 20%;"><i
											class="fa-sharp fa-regular fa-pen-to-square"></i></th>
										<th style="width: 40%;">사번</th>
										<th style="width: 40%;">이름</th>
									</tr>
								</thead>
								<tbody id="trAdd">
									<!-- 직원 목록 뿌리는 곳 -->
								</tbody>
							</table>
						</div>

						<!-- 페이지블록 처리	 -->
						<div class="card-footer clearfix" id="dataTable_paginate"
							style="background-color: white;"></div>

					</div>
				</div>
			</div>


			<form id="Empfrm" name="EmpFrm" class="col-md-8 row"
				action="/hospital/manage/empInfo/updatePost?${_csrf.parameterName}=${_csrf.token}"
				method="post" enctype="multipart/form-data">

				<!-- 좌측 상단 -->
				<div class="col-md-6">
					<div class="card card-info" style="height: 900px;">

						<div class="card-header"
							style="background-color: #404b57; border: none;">
							<div class="d-flex justify-content-between align-items-center">
								<h2 class="card-title">직원 정보</h2>
							</div>
						</div>
						<div class="card-body">
							<div class="row" style="height: 280px;">
								<div class="col-sm-5">
									<div class="d-flex justify-content-center align-items-center border w-100" style="height: 260px;">
									<!--  display:table-cell; td태그와 같은 속성으로 만들어주는 속성/  vertical-align:middle; td에서 사용하는 수직정렬 속성
										  mx-auto : 좌우 정렬 -->
										<div class="m-auto p-1" style="border: 1px solid black; display:table-cell; vertical-align:middle;">
											<img id="empImg" class="mx-auto w-100" src="" alt="직원 이미지" />
										</div>
									</div>
									<!-- 									<table border="1" style="margin:auto; height:73%;"> -->
									<!-- 										<tr height="200px;"> -->
									<!-- 											<td width="140px;"> -->
									<!-- 												<div class="col-lg-5 d-none d-lg-block bg-register-image"> -->
									<!-- 													<img id="empImg" src="" alt="직원 이미지" style="width: 140px;" /> -->
									<!-- 												</div> -->
									<!-- 											</td> -->
									<!-- 										</tr> -->
									<!-- 									</table> -->
									<!-- 이미지 미리보기 시작-->
									<!-- 									<div class="imgs_wrap"></div> -->
									<!-- 									<input type="file" class="d-none" id="input_imgs" name="uploadFile" /> -->
								</div>
								<!-- 이미지 미리보기 끝-->
								<div class="col-sm-7" style="height: 205px;">
									<div class="form-group">
										<label for="productId">직원명</label>
										<div class="input-group">
											<input type="text" name="empNm" class="form-control"
												id="empNm" placeholder="직원이름을 입력해주세요" value="" required
												readonly />
										</div>

										<label for=empNum style="margin-top: 10px;">사번</label>
										<div class="input-group">
											<input type="text" name="empNum" class="form-control"
												id="empNum" value="" placeholder="자동생성" title="수정이 불가합니다."
												required readonly />
										</div>
										<label for="unitPrice" style="margin-top: 10px;">면허 번호</label>
										<div class="input-group">
											<input type="text" name="doctLn" class="form-control"
												id="doctLn" placeholder="면허번호를 입력해주세요" value="" readonly />
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-2">
								<!-- 								<div class="d-flex justify-content-center align-items-center col-sm-5"> -->
								<!-- 									<input type="file"  name="uploadFile" id="file" disabled /> -->
								<!-- 								</div> -->
								<div class="col-sm-5 text-center">
									<input type="file" name="uploadFile" id="file" class="invisible" />
									<button type="button" class="btn btn-success btn-block" id="uploadFile"
										    onclick="javascript:document.querySelector('#file').click();"
										    disabled>이미지 업로드</button>
									<button type="button" class="btn btn-danger btn-block redBtn"
											name="deleteFile" id="deleteFile" disabled>삭제</button>
								</div>
								<!-- 								<div class="col-sm-7"> -->
								<!-- 								<div class="btn-upload" id="input_imgs" style="display:none;"></div> -->
								<!-- 								</div> -->
							</div>
						</div>


						<!-- 좌측 하단 -->
						<div class="">
							<div class="card-body">
								<div class="form-group">
									<label for="deptCd">부서</label>
									<div class="row">
										<div class="col">
											<select id="deptCd" name="deptCd" class="form-control" readonly>
												<option value="">---------</option>
												<c:forEach var="dept" items="${requestScope.deptList}">
													<option value="${dept.deptCd}"
														<c:if test='${deptCd == dept.deptCd}'>selected</c:if>>${dept.deptNm}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-sm-4">
											<!-- modal 버튼 -->
											<button type="button" id="deptButton"
													class="btn btn-success violetBtn" data-toggle="modal"
													data-target="#modal-default1" disabled>부서관리</button>
											<!-- 여기 data-target이랑 같아야 함 -->
										</div>
									</div>
								</div>
								<!-- modal -->
								<div class="modal fade" id="modal-default1">
									<!-- 여기 id값이랑 -->
									<div class="modal-dialog modal-dialog modal-lg">
										<div class="modal-content" style="border-radius: 30px;">
											<div class="modal-header" style="border-bottom: 2px solid #FF5252;width: 90%;margin-left: 5%;">
												<h5 class="modal-title">부서 관리</h5>
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">×</span>
												</button>
											</div>
											<div class="modal-body" style="padding: 40px 40px;">

												<div class="form-group" style="overflow: scroll; overflow-x: hidden; height: 600px;">
													<table class="table table-bordered" style="margin-bottom: 0px;">

														<colgroup>
															<col width="20%">
															<col width="30%">
															<col width="50%">
														</colgroup>
														<thead
															style="text-align: center; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">
															<tr>
																<th class="p-3"><i
																	class="fa-sharp fa-regular fa-pen-to-square"></i></th>
																<th class="p-3">순번</th>
																<th class="p-3">부서</th>
															</tr>
														</thead>

														<tbody id="deptList"
															style="font-family: 'Noto Sans KR', sans-serif; font-weight: 500; text-align: center;">
															<!-- 리스트  -->
														</tbody>

													</table>
												</div>

												<div class="form-group2" style="text-align: center;">
													<div class="row">
														<div class="col-md-5">
															<label style="border-left: 3px solid #FF5252; padding-left: 10px;">부서코드</label>
															<input type='text' class='' value='' placeholder="자동생성값" readonly>
														</div>
														<div class="col-md-6">
															<label style="border-left: 3px solid #FF5252; padding-left: 10px;">부서명</label>
															<input type='text' class='addDept'	value='' placeholder="부서명을 입력해주세요">
															<button type="button" class="btn btn-default redBtn" id="addButton1">추가</button>
														</div>
													</div>
												</div>

											</div>
											<!-- modal footer -->
											<div class="modal-footer justify-content-between" style="border-top: none;font-family: 'Noto Sans KR', sans-serif;font-weight: 500;margin: auto;">
												<button type="button" class="btn btn-outline-secondary"
													data-dismiss="modal" style="width:120px; border:none;">닫기</button>
											</div>
										</div>
									</div>
								</div>
								<!-- modal footer 끝 -->

								<div class="form-group">
									<label for="jbgdCd">직급</label>
									<div class="row">
										<div class="col">
											<select id="jbgdCd" name="jbgdCd" class="form-control"
												readonly>
												<option value="">---------</option>
												<c:forEach var="jbgd" items="${requestScope.jbgdList}">
													<option value="${jbgd.jbgdCd}"
														<c:if test='${jbgdCd == jbgd.jbgdCd}'>selected</c:if>>${jbgd.jbgdNm}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-sm-4">
											<!-- modal 버튼 -->
											<button type="button" id="jbgdButton"
												class="btn btn-success violetBtn" data-toggle="modal"
												data-target="#modal-default2" disabled>직급관리</button>
											<!-- 여기 data-target이랑 같아야 함 -->
										</div>
									</div>
								</div>

								<!-- modal -->
								<div class="modal fade" id="modal-default2">
									<!-- 여기 id값이랑 -->
									<div class="modal-dialog modal-dialog modal-lg">
										<div class="modal-content" style="border-radius: 30px;">
											<div class="modal-header" style="border-bottom: 2px solid #FF5252;width: 90%;margin-left: 5%;">
												<h5 class="modal-title">직급 관리</h5>
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">×</span>
												</button>
											</div>
											<div class="modal-body" style="padding: 40px 40px;">

												<div class="form-group"
													style="overflow: scroll; overflow-x: hidden; height: 600px;">
													<table class="table table-bordered"
														style="margin-bottom: 0px;">

														<colgroup>
															<col width="20%">
															<col width="30%">
															<col width="50%">
														</colgroup>
														<thead
															style="text-align: center; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">
															<tr>
																<th class="p-3"><i
																	class="fa-sharp fa-regular fa-pen-to-square"></i></th>
																<th class="p-3">순번</th>
																<th class="p-3">직급</th>
															</tr>
														</thead>

														<tbody id="jbgdList"
															style="font-family: 'Noto Sans KR', sans-serif; font-weight: 500; text-align: center;">
															<!-- 리스트  -->
														</tbody>

													</table>
												</div>

												<div class="form-group2" style="text-align: center;">
													<div class="row">
														<div class="col-md-5">
															<label style="border-left: 3px solid #FF5252; padding-left: 10px;">직급코드</label> <input type='text' class='' value=''
																placeholder="자동생성값" readonly>
														</div>
														<div class="col-md-6">
															<label style="border-left: 3px solid #FF5252; padding-left: 10px;">직급명</label> <input type='text' class='addJbgd'
																value='' placeholder="직급명을 입력해주세요">
															<button type="button" class="btn btn-default redBtn"
																id="addButton2">추가</button>
														</div>
													</div>
												</div>

											</div>
											<!-- modal footer -->
											<div class="modal-footer justify-content-between" style="border-top: none;font-family: 'Noto Sans KR', sans-serif;font-weight: 500;margin: auto;">
												<button type="button" class="btn btn-outline-secondary"
													data-dismiss="modal" style="width:120px; border:none;">닫기</button>
											</div>
										</div>
									</div>
								</div>
								<!-- modal footer 끝 -->

								<div class="form-group">
									<label for="empJncmpYmd">입사일</label>
									<div class="input-group">
										<input type="date" name="empJncmpYmd" class="form-control"
											id="empJncmpYmd" value="" max="9999-12-31" readonly />
									</div>
								</div>
								<div class="form-group">
									<label for="empRtrmYmd">퇴사일</label>
									<div class="input-group">
										<input type="date" name="empRtrmYmd" class="form-control"
											id="empRtrmYmd" value="" max="9999-12-31" readonly />
									</div>
								</div>
								<div class="form-check text-right" id="empRtrmYmdCheckBox">
									<input type="checkbox" class="form-check-input"
										id="checkRtrmYn" value="Y" /> <label for="checkRtrmYn"
										class="form-check-label">퇴사</label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 오른쪽 상단 -->
				<div class="col-md-6">
					<div class="card card-info">

						<div class="card-header"
							style="background-color: #404b57; border: none;">
							<div class="d-flex justify-content-between align-items-center">
								<h2 class="card-title">부가 정보</h2>
							</div>
						</div>


						<div class="card-body" style="height: 400px;">
							<div class="form-group">
								<label for="pname">휴대전화</label>
								<div class="input-group">
									<input type="text" name="empPhone" class="form-control"
										id="empPhone" placeholder="연락처를 입력해주세요" value="" required
										readonly />
								</div>
							</div>
							<div class="form-group">
								<label for="pname">생년월일</label>
								<div class="input-group">
									<input type="date" name="empBrdt" class="form-control" id="empBrdt" value="" required readonly />
								</div>
							</div>
							<!--  우편번호 -->
							<div class="form-group">
								<label for=empAddrDet>주소</label><br />
								<div class="row">
									<div class="col-sm-5">
										<input type="text" name="empZip" class="form-control"
											id="empZip" value="" placeholder="우편번호를 입력해주세요" readonly
											required />
									</div>
									<div class="col-auto">
										<button type="button" class="btn btn-success btnSearchZip violetBtn" onclick="openHomeSearch();" disabled>주소검색</button>
									</div>
								</div>
							</div>
							<div class="form-group">
								<input type="text" name="empAddr" class="form-control"
									id="empAddr" placeholder="주소를 입력해주세요" value="" required
									readonly />
							</div>
							<div class="form-group">
								<input type="text" name="empDaddr" class="form-control"
									id="empDaddr" placeholder="상세 주소를 입력해주세요" value="" required />
							</div>
						</div>
					</div>

					<!-- 우측 하단 -->
					<div class="card card-info" style="height: 440px;">

						<div class="card-header"
							style="background-color: #404b57; border: none;">
							<div class="d-flex justify-content-between align-items-center">
								<h2 class="card-title">직원 정보</h2>
							</div>
						</div>


						<div class="card-body" style="height: auto;">
							<div class="form-group">
								<label for="empId">사용자 ID</label>
								<div class="form-group row">
									<div class="col">
										<input type="text" name="empId" class="form-control"
											id="empId" placeholder="ID를 입력해주세요" value="" required
											readonly />
									</div>
									<div class="col-sm-4">
										<button type="button" id="checkIdBtn" class="btn btn-primary violetBtn"
											disabled>중복 검사</button>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="empPw">사용자 PW</label>
								<div class="form-group row">
									<div class="col">
										<input type="password" name="empPw" class="form-control"
											id="empPw" placeholder="******" required readonly />
									</div>
									<div class="col-sm-4">
										<button type="button" id="changePW" class="btn btn-success violetBtn"
											data-toggle="modal" data-target="#modal-default3" disabled>비밀번호
											변경</button>
									</div>
									<div>
										<p id="msg" style="color: red; font-size: 15px;"></p>
									</div>
								</div>
							</div>

							<div class="d-flex justify-content-between align-items-center" style="margin-top: 10px;">
								<button type="button" class="btn btn-success" onclick="inputTestEmpData();">시연용</button>
								<div>
									<button type="button" class="btn btn-success btnCss violetBtn" id="save"
										style="background-color: #904aff; border: none; width:120px;" disabled>저장</button>
									<button type="reset" style="width:120px;" class="btn btn-success btnCss ml-1" id="reset"
										disabled >직원등록</button>
								</div>
							</div>
							<!-- Cross Site Request Forgery -->
						</div>
					</div>
					<sec:csrfInput />
				</div>
			</form>
			<!-- 비밀번호 변경 모달 시작 -->
			<div class="modal fade" id="modal-default3">
				<div class="modal-dialog modal-lg">
					<div class="modal-content" style="border-radius: 30px;">
						<div class="modal-header" style="width: 80%;margin-left: 11%;border-bottom: 2px solid #FF5252;">
							<h5 class="modal-title" id="queModalLabel">비밀번호 변경</h5>
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body" style="padding: 40px 80px;">
							<form name="changePassword">
								<input type="hidden" name="empNum" />
								<div class="row g-2">
									<div class="form-group col-sm-6">
										<label class="form-label" style="border-left: 3px solid #FF5252; padding-left: 10px;">비밀번호 초기화</label> <input type="text"
											class="form-control" name="resetUserPW" />
									</div>
									<div class="form-group col-sm-6">
										<label class="form-label" style="border-left: 3px solid #FF5252; padding-left: 10px;">비밀번호 확인</label> <input type="text"
											class="form-control" name="checkUserPW" />
									</div>
								</div>

								<div class="modal-footer" style="margin: 0px 28%; border-top:0px;">
									<button type="button" class="btn btn-danger redBtn"
										onclick="updatePw();" style="width:120px; border:none;">저장</button>
									<button type="button" class="btn btn-outline-secondary"
										data-dismiss="modal" style="width:120px; border:none; font-family: 'Noto Sans KR', sans-serif;font-weight: 500;">닫기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 비밀번호 변경 모달 끝 -->
		</div>
	</section>
</div>
<script>
// 시연용 직원 데이터 작성
function inputTestEmpData(){

	$('#empNm').val('이하악');
	$('#jbgdCd').val('3');
	$('#empJncmpYmd').val('2023-04-13');
	$('#empPhone').val('01012341234');
	$('#empBrdt').val('1996-05-05');
	$("#empZip").val('34908');
	$('#empAddr').val('대전 중구 계룡로 846');
	$('#empDaddr').val('3층 교무실');

	$('#empId').val('haak');

}
</script>