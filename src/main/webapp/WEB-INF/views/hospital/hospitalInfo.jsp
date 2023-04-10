<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
/* chatCss */
#chatButton{
	padding-right:1.25rem;
}
.navbar-badge{
	top:5px;
}
/* **************************** */
.row .hospitalRow {
	margin: 20px;
}

.row .zip {
	margin-top: 10px;
	margin-left: 20px;
	margin-right: 20px;
}

body, input[type="button"] {
	font-family: bookman old style;
	font-size: 12pt;
}

table {
	border-collapse: collapse;
	margin: auto;
}

th, td {
	padding: 6px;
}

input[type="button"] {
	border: 2px solid indianred;
	cursor: pointer;
	margin-top: 20px;
}

input[type="button"]:hover {
	background: indianred;
}

.card-footer{
	background-color: white;
}
.navbar-light .navbar-nav .nav-link {
	color: #f8f9fa;
	margin-left: 0.5rem;
	height: 38px;
	padding: 0.25rem;
	display: flex;
	align-items: center;
}
.fontCss{
	font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
    font-size:1.25rem;
}
.violetBtn{
	background-color:#904aff;
	border:none;
	font-family: 'Noto Sans KR', sans-serif !important;
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
	font-family: 'Noto Sans KR', sans-serif !important;
	font-weight:500;
	color:white;
}

.redBtn:hover{
	background-color:#e13636 !important;
	border:none;
	color:white;
}

.chairBoard::-webkit-scrollbar {
	width: 10px;
	height: 10px;
}

.chairBoard::-webkit-scrollbar-thumb {
	background-color: #404b57;
	border-radius: 5px;
}

.chairBoard::-webkit-scrollbar-track {
	background-color: rgba(0, 0, 0, 0);
}
</style>

<!--  다음 주소api -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- 메시지창 -->
<script src="/resources/js/alertModule.js"></script>
<!-- 권한 -->
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<script>
		$(function(){
			$("#addTr").prop("disabled", false);  //추가버튼 활성화
			$("#updateChair").prop("disabled", false); //저장버튼 활성화
			$("#deleteChair").prop("disabled", false); //삭제버튼 활성화
			$("#updateBtn").show(); //병원정보 수정버튼 활성화

			$("#updateBtn").on("click", function(){
				$("#hiType").attr("disabled", false);
				$("#uploadFile").attr("disabled", false);
				$("#zipSearch").attr("disabled", false);

				$("#hiBrno").prop("readonly", false);
				$("#hiNm").prop("readonly", false);
				$("#hiPhone").prop("readonly", false);
				$("#hiFax").prop("readonly", false);
				$("#hiZip").prop("readonly", false);
				$("#hiAddr").prop("readonly", false);
				$("#hiDaddr").prop("readonly", false);
				$("#hiEml").prop("readonly", false);
				$("#hiHp").prop("readonly", false);
				$("#hiRprsvNm").prop("readonly", false);
				$("#hiRprsvRrno").prop("readonly", false);
				$("#hiOpenTime").prop("readonly", false);
				$("#hiCloseTime").prop("readonly", false);
				$("#hiLunchStime").prop("readonly", false);
				$("#hiLunchEtime").prop("readonly", false);
			});
			
		});
	</script>
</sec:authorize>

<script type="text/javascript">
// 다음 주소찾기 API
function openHomeSearch() {
    new daum.Postcode({
        // 선택 완료 시 데이터를 폼에 담아준다.
        oncomplete : function(data) {
            document.frm.hiZip.value = data.zonecode; // 우편번호
            document.frm.hiAddr.value = data.address; // 주소
            document.frm.hiDaddr.value = data.buildingName; // 건물주소
        }
    }).open();
}

// 체어관리- 체어 추가버튼 클릭했을 때 자바스크립트 실행
function addRow() {

	  // 템플릿 가져오기
	  const template = document.querySelector('#rowTemplate');

	  // 추가할 테이블 가져오기
	  //const tbl = document.querySelector('#myTable');

	  // 왼쪽 숫자 표시 설정
	  const td_slNo = template.content.querySelectorAll("td")[1];
// 	  const tr_count = $("#myTable tbody tr").length;
// 	  td_slNo.textContent = tr_count;

	  // 템플릿의 content 속성과 그의 자식 모든 요소를 복사
	  const clone = template.content.cloneNode(true);

	  // 기존 테이블에 복사한 템플릿을 추가
	  //tbl.appendChild(clone);

	  $("#myTable tbody").append(clone);

	  // 수정버튼 클릭 -> 저장모드 전환
	  // 	//spn1 : 가려짐 / spn2 : 보임
	 $("#spn1").hide();
	 $("#spn2").show();

}


// 체어관리- 체어 추가 후 저장버튼 눌렀을 때 자바스크립트 실행
function createRow(){

	  // 체크된 체크박스 값을 가져온다.
	  var checkbox = $("input[name=user_Check]:checked");
	  console.log(checkbox);


	  var checkYn = $("#checkYn");
	  if(!checkYn.is(":checked")){
		  simpleErrorAlert("추가할 체어를 선택해주세요.")
		  return false;
	  }

// 	  let tr = checkbox.parent().parent();
// 	  let td = tr.children();

	  // 배열 생성
	  var arr = [];

	  let emptyFlag = false;

	  checkbox.each(function(i){
		var a = {};

		var tr = checkbox.parent().parent().eq(i); // tr
		console.log("tr: " , tr);
		var td = tr.children(); // tr의 자식요소들

		// td.eq(0)은 체크박스 이므로 td.eq(1)의 값부터 가져온다.
		a.chairSn = td.eq(1).text();
		a.chairNm = td.eq(2).children().val();
		a.deptCd = td.eq(3).find("#deptCd").val();

		if(a.chairNm == '' || a.deptCd == ''){
			emptyFlag = true;
		}

		console.log("a : " + JSON.stringify(a));

// 			// 체크된 row의 모든 값을 배열에 담는다.
// 			arr.push(chairSn);
// 			arr.push(chairNm);
// 			arr.push(deptCd);

		arr.push(a);

	  });

	  if(emptyFlag) {
		  simpleErrorAlert("체어 정보를 모두 입력해주세요");
		  return false;
	  }

	  console.log("arr : ", arr);

			$.ajax({
				url : '/hospital/manage/hosInfo/createChair',
				type : 'post',
				data : JSON.stringify(arr),
				contentType: 'application/json;charset=utf-8',
				beforeSend: function(xhr){
					xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
				},
				success : function(result){

					$("#myTable tbody").empty();

					console.log("result : " + JSON.stringify(result));

// 					var resultList =  JSON.stringify(result);

					let str = "";
					$(result).each(function(index, chairVO){
					// {"chairSn":39,"chairNm":"4번 체어","deptCd":"1"}
					  const template = document.querySelector('#readOnlyTemplate');

					  // 템플릿의 content 속성과 그의 자식 모든 요소를 복사
					  const clone = template.content.cloneNode(true);

					  // 체크박스 html 태그 설정
					  const tr = clone.querySelector("tr");
					  tr.setAttribute("class", "trClassDelete");

					  const td_checkBox = clone.querySelectorAll("td")[0].querySelector("#checkYn");
					  td_checkBox.setAttribute("class", "chairSelected");
					  td_checkBox.setAttribute("id", "deleteChairCheck");
					  td_checkBox.setAttribute("name", "user_CheckBox");

					  // 왼쪽 숫자 표시 설정
					  var td_slNo = clone.querySelectorAll("td")[1];
					  td_slNo.textContent = index+1;
					  td_slNo.setAttribute("data-chairno", chairVO.chairSn)
					 
					  // 의자 이름 설정
					  const td_chName = clone.querySelectorAll("td")[2].querySelector("#chairNm");
					  td_chName.value = chairVO.chairNm;
					  td_chName.setAttribute("class", "updateInput")
					  td_chName.setAttribute("readonly", true)

					  // 부서 이름 설정
					  const td_deptCd = clone.querySelectorAll("td")[3].querySelector("#deptCd");
					  td_deptCd.value = chairVO.deptCd;

				 	  $("#myTable tbody").append(clone);

				 	 simpleSuccessAlert('체어 정보가 추가되었습니다.');
					});
					 $("#spn1").show();
					 $("#spn2").hide();
				}
			});
}

// 체어 삭제
function deleteRow(){

	  // 체크된 체크박스 값을 가져온다.
	  var checkbox = $("input[name=user_CheckBox]:checked");
	  console.log("checkbox : " ,checkbox);

	  var chairSelected = $(".chairSelected");
	  console.log("chairSelected : " + chairSelected)
	  
	  if(!chairSelected.is(":checked")){
		  simpleErrorAlert("삭제할 항목에 체크하여주십시오.")
		  return false;
	  }

	  let tr = checkbox.parent().parent();
	  let td = tr.children();

	  // 배열 생성
	  var arr = [];

	  checkbox.each(function(i){
		  var a = {};

			var tr = checkbox.parent().parent().eq(i); // tr
			console.log("tr: " , tr);
			var td = tr.children(); // tr의 자식요소들

			// td.eq(0)은 체크박스 이므로 td.eq(1)의 값부터 가져온다.
			a.chairSn = td.eq(1).data("chairno");
			console.log("a.chairSn :",a.chairSn);
			a.chairNm = td.eq(2).children().val();
			a.deptCd = td.eq(3).find("#deptCd").val();

			console.log("a : " + JSON.stringify(a));

//			// 체크된 row의 모든 값을 배열에 담는다.
//			arr.push(chairSn);
//			arr.push(chairNm);
//			arr.push(deptCd);

			arr.push(a);
		});


			console.log("arr : ", arr);

			$.ajax({
				url : '/hospital/manage/hosInfo/deleteChair',
				type : 'post',
				data : JSON.stringify(arr),
				contentType: 'application/json;charset=utf-8',
				beforeSend: function(xhr){
					xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
				},
				success : function(res){

					$(".trClassDelete").each(function(i, tr){
						if($(tr).find('.chairSelected').prop('checked')){
							$(tr).remove();
						}
					});

					simpleSuccessAlert('체어 정보가 삭제되었습니다.');
				}
			});
}


// 체어관리- 체어 수정
function updateRow(){

// 	var total_cnt=0;
// 	var tdArr = new Array();
	var checkbox = $("input[name=user_CheckBox]:checked");
	var arr = [];

	//체크된 체크박스 값을 가져온다.
	checkbox.each(function(i){

		var a = {};

		var tr = checkbox.parent().parent().eq(i); // tr
		var td = tr.children(); // tr의 자식요소들

		//체크된 row의 모든 값을 배열에 담는다.

		//td.eq(0)은 체크박스 이므로 td.eq(1)의 값부터 가져온다.
		a.chairSn = td.eq(1).text();
		a.chairNm = td.eq(2).find(".updateInput").val();
		a.deptCd = td.eq(3).find("#deptCd").val();

		console.log(a);
		arr.push(a); //객체를 배열안에 넣는다.

	});


		console.log("arr : ", arr);

		$.ajax({
			url : '/hospital/manage/hosInfo/updateChair',
			type : 'post',
			data : JSON.stringify(arr),
			contentType: 'application/json;charset=utf-8',
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			success : function(res){
				console.log("res : " + res);

				simpleSuccessAlert('체어 정보가 수정되었습니다.');
				checkbox.click();
			}
		});
}


$(document).ready(function(){

	$("#saveBtn").hide();

	// 체어관리- 취소버튼 클릭시 일반모드로 전환
	$("#cancelBtn").on("click",function(){
		$("#spn1").show();
		$("#spn2").hide();

		$(".trClassAdd").remove();
	});	// 취소버튼 클릭이벤트 끝..

	$(document).on("change", ".chairSelected", function(){

		// 체크박스 활성화했을 시
		if($(this).is(":checked")){
			//alert("체크");

			//parents(해당 요소의 위에있는 부모들 중 <tr>요소를 찾고 찾은 <tr>요소의 자식 중 .updateInput 클래스이름을 가진 요소의 style을 변경 )
			//parent(해당 요소의 바로 위에있는 부모를 찾아 <tr>요소를 찾고 찾은 <tr>요소의 자식 중 .updateInput 클래스이름을 가진 요소의 style을 변경 )
			//children(해당 요소의 아래에 있는 자식들 중 <tr>요소를 찾고 찾은 <tr>요소의 자식 중 .updateInput 클래스이름을 가진 요소의 style을 변경)
			//child(해당 요소의 바로 아래에 있는 자식을 찾아 <tr>요소를 찾고 찾은 <tr>요소의 자식 중 .updateInput 클래스이름을 가진 요소의 style을 변경)

// 			$(this).parent().find(".updateInput").attr("readonly", false); //체어명
			$(this).parent().next().next().find(".updateInput").prop("readonly", false); //체어명
			$(this).parent().next().next().find(".updateInput").css("border", "1px solid blue"); //체어명 작성란 테두리
			$(this).parent().parent().find("#deptCd").prop("disabled", false); //부서 선택란 작성가능 처리


// 			const newText = document.createElement('input');
// 			newText.innerHTML = "<input type='text'>";
// 			$(".update1").appendCild(newText);
		}else{
			//alert("체크해제");
// 			$("#chairSn").prop("disabled", true);
// 			$(".updateInput").attr("readonly", true);
			$(this).parent().next().next().find(".updateInput").prop("readonly", true);
			$(this).parent().next().next().find(".updateInput").css("border", "none");
			$(this).parent().parent().find("#deptCd").prop("disabled", true);
		}
	})


	$("#updateBtn").on("click", function(){
			//alert("체크 눌렸다!");

			// name값을 사용해서 요소 가져오기
			let hiBrno = $("#hiBrno").val();
			console.log("hiBrno : " + hiBrno);

			// readonly true -> readonly false
			$(".form-control-user").attr("readonly", false);
			$("#uploadFile").attr("disabled", false);
			$("#updateBtn").hide();
			$("#saveBtn").show();
// 			$("#backData").show(); //보류
		})

// 	$("#backData").on("click", function(){


// 	});

	// 정규식 모음
	var regFaxNum = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/
	var regTelNum = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/
	
	
	$("#saveBtn").on("click", function(){
// 		alert("저장");

		var faxNumber = $("#hiFax").val();
		if(!regFaxNum.test(faxNumber)){
			alert("팩스번호를 정확하게 입력해주세요.");
			return false;
		}
		
		var regTel = $("#hiPhone").val();
		if(!regTelNum.test(regTel)){
			alert("전화번호를 정확하게 입력해주세요.");
			return false;
		}
		
		$("#updateBtn").show();
		$("#saveBtn").hide();

		//폼데이터 가져오기(파일까지 포함하여 가져올 수 있음.)
		let frm = document.querySelector("#frm");
		let formData = new FormData(frm);
		console.log("formData"+ formData);

		let hiRprsvNm = document.querySelector("#hiRprsvNm").value;
		let hiRprsvRrno = document.querySelector("#hiRprsvRrno").value;

		var juminRule=/^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-8][0-9]{6}$/;

		if(!juminRule.test(hiRprsvRrno)) {
			simpleErrorAlert("[주민등록번호]\n 형식에 맞게 입력하세요!\n ex)000000-0000000")
			$("#updateBtn").hide();
			$("#saveBtn").show();
			return false;
		}

		let hiOpenTime = document.querySelector("#hiOpenTime").value;
		let hiCloseTime = document.querySelector("#hiCloseTime").value;
		let hiLunchStime = document.querySelector("#hiLunchStime").value;
		let hiLunchEtime = document.querySelector("#hiLunchEtime").value;

		formData.append("hiRprsvNm", hiRprsvNm)
		formData.append("hiRprsvRrno", hiRprsvRrno)
		formData.append("hiOpenTime", hiOpenTime)
		formData.append("hiCloseTime", hiCloseTime)
		formData.append("hiLunchStime", hiLunchStime)
		formData.append("hiLunchEtime", hiLunchEtime)

		$.ajax({
			url : '/hospital/manage/hosInfo/updatePost',
			type : 'post',
			contentType : false,
			processData : false,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			data : formData,
			success : function(result){
				console.log("result : " + JSON.stringify(result));

				const hiImg = result.hiImg;
				if(hiImg != null && hiImg != ''){
					$("#hiImg").attr("src", result.hiImg);
				}

			},
			dataType : 'json'
		});
			// readonly false -> readonly true
			$(".form-control-user").attr("readonly", true);
			$("#hiType").attr("disabled", true);
			$("#uploadFile").attr("disabled", true);
			simpleSuccessAlert("병원 정보가 수정되었습니다.");
	});

	//이미지 미리보기 시작/////////////////////////////////
	$("#uploadFile").on("change", handleImgFileSelect);

	function handleImgFileSelect(event){  //change된 event가 따라온다.
		let files = event.target.files; //파일이 1개든 여러개든 파일을 가져온다.
		let fileArr = Array.prototype.slice.call(files); //배열형태로 저장한다.
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				simpleErrorAlert("이미지만 가능합니다.");
				return;
			}

			let reader = new FileReader();
			reader.onload = function(event){
				//읽은 결과
				//<img src = "SFHEHFDG.jpg>"
				let img_html = "<img id=\"hiImg\" src=\"" + event.target.result + "\" style='width:80px;' />";

				$(".bg-register-image").html(img_html);
			}
			reader.readAsDataURL(f);
		});
	}
	//이미지 미리보기 끝/////////////////////////////////

	function fn_retrieveList(){

		$.ajax({
			url : '/hospital/manage/hosInfo/createChair',
			type : 'post',
			contentType : false,
			processData : false,
			beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-TOKEN', '${_csrf.token}');
			},
			data : formData,
			success : function(result){

				 $("#myTable tbody").empty();

				console.log("result : " + result);

				var resultList = result.resultList;

				$(resultList).each(function(index, object){

				  const template = document.querySelector('#readOnlyTemplate');

				  // 왼쪽 숫자 표시 설정
				  const td_slNo = template.content.querySelectorAll("td")[1];
				  const tr_count = $("#myTable tbody tr").length;
				  td_slNo.textContent = tr_count;


				  // 템플릿의 content 속성과 그의 자식 모든 요소를 복사
				  const clone = template.content.cloneNode(true);


			 	  $("#myTable tbody").append(clone);
				  $("#myTable tbody tr:last").find("#deptCd").val("3");
				});
			},
			dataType : 'json'
		});
	}
});

</script>

<div class="content-wrapper"
	 style="background-color: rgb(101, 125, 150); min-height: 1001px;">
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
					<a class="nav-link btn btn-outline-light" href="/hospital/manage/empInfo">직원관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/drug">약품관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/txCode">처치 관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light active" href="/hospital/manage/hosInfo">병원 기초정보관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/manage/statistics">병원 통계</a>
				</li>
			</ul>
		</div>
		<!--
		<div class="collapse navbar-collapse" id="navbarTogglerDemo03"
			style="margin-left: 47%;">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link"	href="/hospital/manage/empInfo" style="color: white;">직원관리</a></li>
				<li class="nav-item"><a class="nav-link" href="/hospital/drug"
					style="color: white;">약품관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/hospital/txCode" style="color: white;">처치 관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/hospital/manage/hosInfo" style="color: white;">병원 기초정보관리</a></li>
			</ul>
		</div>
		 -->
	</nav>
	<!-- main 검색창을 포함한 navbar 끝 -->

<!-- 	<div class="SaveRow"> -->
<!-- 		<input type="button" id="saveBtn" class="btn btn-danger btnCss btn-block" -->
<!-- 			   style="float: right; margin-right: 15px; background-color: #ff3e3e; height: 100%; width: 7%; margin-top: .9rem; margin-bottom: .9rem;" value="병원정보 저장" /> -->
<!-- 		<input type="button" class="btn btn-success btn-inline btnCss" id="backData"  value="돌아가기" -->
<!-- 			   style="background-color: #904aff; border: none; width: 10%;" /> -->
<!-- 		<input type="button" id="updateBtn" class="btn btn-danger btnCss btn-block" -->
<!-- 			   style="float: right; margin-right: 15px; display:none; background-color: #ff3e3e; height: 100%; width: 7%; margin-top: .9rem; margin-bottom: .9rem;" value="병원정보 수정"/> -->
<!-- 	</div> -->
	<section class="content" style="margin-top: 1%;">
		<div class="row">

			<!-- 좌측 상단 -->
			<div class="col-md-6">
				<form id="frm" name="frm" action="/hospital/manage/hosInfo/updatePost?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
				<div class="card card-info">
					<div class="card-header"
						 style="background-color: #404b57; border: none;">
						<div class="d-flex justify-content-between align-items-center">
							<h2 class="card-title">병원기초정보</h2>
							<!-- 병원 정보 수정 버튼 -->
							<input type="button" id="updateBtn" class="btn btn-danger btnCss m-0 border-0"
			   					   style="display:none; background-color: #ff3e3e;" value="병원정보 수정"/>
							<input type="button" id="saveBtn" class="btn btn-danger btnCss m-0 border-0"
			   					   style="background-color: #ff3e3e;" value="병원정보 저장" />
							<!-- 병원 정보 수정 버튼 -->
						</div>
					</div>


						<div class="card-body" style="height: 897px;">
							<p class="fontCss">병원기본정보</p>
							<hr>
							<div class="row">
								<div class="col-md-8">
									<div class="row hospitalRow">
										<div class="col-md-4">
											<label for="hiBrno">병원명</label>
										</div>
										<div class="col-md-8">
											<!--병원명 입력칸 -->
											<input type="text" class="form-control form-control-user" id="hiNm"
												   name="hiNm" value="${hosInfo.hiNm}" required readonly>
										</div>
									</div>
									<div class="row hospitalRow">
										<div class="col-md-4">
											<label for="hiType">병원 구분</label>
										</div>
										<div class="col-md-8">
											<select class="form-control form-control-user" id=hiType name="hiType" disabled>
												<option value="">전체</option>
												<c:forEach var="hiType" items="${requestScope.hiTypeList}">
													<option value="${hiType.commCdNm}"
														<c:if test='${hiType.commCdNm == hosInfo.hiType}'>selected</c:if>>${hiType.commCdCnt}</option>
												</c:forEach>
											</select><br />
										</div>
									</div>
									<div class="row hospitalRow">
										<div class="col-md-4">
											<label for="hiBrno">사업자 등록번호</label>
										</div>
										<div class="col-md-8">
											<!-- 사업자 등록번호 -->
											<input type="text" class="form-control form-control-user" id="hiBrno"
												   name="hiBrno" value="${hosInfo.hiBrno}"  pattern="[0-9]{3}-[0-9]{2}-[0-9]{5}" required readonly>
										</div>
									</div>
								</div>
								<!-- col-md-8 끝 -->
								<!-- 파일 업로드 시작 -->
								<div class="col-md-4" style="margin-top: 15px;">
									<label>병원대표 도장</label>
									<table border="1">
										<table border="1">
											<tr height="200px;">
												<td width="140px;">
													<div class="d-flex justify-content-center align-items-center bg-register-image">
														<c:choose>
															<c:when test="${hosInfo.hiImg == null and hosInfo.hiImg == ''}">
																<c:set var="stampImg" value="/resources/images/employee/s_cb8450a3-35e9-44e1-9598-730c60f5cb54_user.png" />
															</c:when>
															<c:otherwise>
																<c:set var="stampImg" value="${hosInfo.hiImg}" />
															</c:otherwise>
														</c:choose>
														<img id="hiImg" class="mx-auto" src="${stampImg}" style="width: 80px;" />
													</div>
												</td>
											</tr>
										</table>
											<!-- 이미지 미리보기 시작-->
<!-- 											<div class="imgs_wrap"></div> -->
											<!-- 이미지 미리보기 끝-->
<!-- 											<input type="file" class="d-none" id="input_imgs" name="file" /> -->
									</table><br />

									<!--  사진 선택 -->
									<label for="uploadFile" class="form-label" id="input_imgs"></label>
									<input type="file" id="uploadFile" name="uploadFile" disabled>
								</div>
								<!-- 파일 업로드 끝 -->
							</div>

							<p class="fontCss">등록정보</p>
							<hr>

							<div class="row hospitalRow">
								<div class="col-md-6">
									<!-- 전화번호 -->
									<label for="hiPhone">전화번호</label> <input type="tel"
										   class="form-control form-control-user" id="hiPhone" name="hiPhone"
										   value="${hosInfo.hiPhone}" required readonly>
								</div>
								<div class="col-md-6">
									<!-- 팩스번호 -->
									<label for="hiFax">팩스번호</label> 
									<input type="tel" class="form-control form-control-user" id="hiFax" name="hiFax" value="${hosInfo.hiFax}"
										   placeholder="ex)042-223-12345" required readonly>
								</div>
							</div>
							<div class="row hospitalRow">
								<div class="col-md-6">
									<label for="hiEml">email</label> <input type="email"
										   class="form-control form-control-user" id="hiEml" name="hiEml"
										   value="${hosInfo.hiEml}" pattern=".+@globex\.com" size="30"
										   required readonly>
								</div>
								<div class="col-md-6">
									<label for="hiHp">홈페이지</label> <input type="url"
										   class="form-control form-control-user" name="hiHp" id="hiHp"
										   value="${hosInfo.hiHp}" placeholder="https://example.com"
										   pattern="https://.*" size="30" required readonly>
								</div>
							</div>
							<div class="zip row">
								<div class="col-md-12">
									<label for="hiZip">주소</label>
									<div class="row">
										<div class="col-md-6">
											<!-- 우편번호 -->
											<input type="text" class="form-control form-control-user"
												   id="hiZip" name="hiZip"
												   value="${hosInfo.hiZip}" required readonly>
										</div>
										<div class="col-auto">
											<!-- 우편번호 검색 -->
											<button type="button" class="btn btn-success btn-block btnCss violetBtn"
												style="background-color: #904aff; border: none;" id="zipSearch"
												onclick="openHomeSearch();" disabled>주소검색</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row zip">
								<div class="col-md-12">
									<input type="text" class="form-control form-control-user" id="hiAddr"
										name="hiAddr" placeholder="주소를 입력해주세요"
										value="${hosInfo.hiAddr}" required readonly>
								</div>
							</div>
							<div class="row zip">
								<div class="col-md-12">
									<input type="text" class="form-control form-control-user" id="hiDaddr"
										name="hiDaddr" placeholder="상세주소를 입력해주세요"
										value="${hosInfo.hiDaddr}" required readonly>
								</div>
							</div>
						</div>
				</div>
					<!-- Cross Site Request Forgery -->
					<sec:csrfInput />
				</form>
			</div>

			<!-- 우측 -->
			<div class="col-md-6">

				<div class="card card-info">

					<div class="card-header"
						 style="background-color: #404b57; border: none;">
						<div class="d-flex justify-content-between align-items-center">
							<h2 class="card-title">대표자 정보</h2>
						</div>
					</div>

					<div class="card-body">
						<div class="row hospitalRow">
							<div class="col-md-6">
								<!-- 대표자명 -->
								<label for="hiRprsvNm">대표자명</label> <input type="text"
									class="form-control form-control-user" id="hiRprsvNm" name="hiRprsvNm"
									value="${hosInfo.hiRprsvNm}" required readonly>
							</div>
							<div class="col-md-6">
								<!-- 주민등록번호 -->
								<label for="hiRprsvRrno">대표자 주민등록번호</label>
								<input type="password"
									class="form-control form-control-user" id="hiRprsvRrno" name="hiRprsvRrno"
									placeholder="주민등록번호를 입력하세요." title="'-'를 붙여 형식에 맞게입력해주세요."
									value="${hosInfo.hiRprsvRrno}" required readonly>
							</div>
						</div>



					</div>
				</div>
				<!-- 우측 중앙 -->
				<div class="card card-info">

					<div class="card-header"
						style="background-color: #404b57; border: none;">
						<div class="d-flex justify-content-between align-items-center">
							<h2 class="card-title">병원 운영정보</h2>
						</div>
					</div>

					<div class="card-body">
						<div class="row hospitalRow">
							<div class="col-md-4">
								<label>Office hours</label>
							</div>
							<div class="col-sm-4">
								<input type="time" class="form-control form-control-user" id="hiOpenTime"
									name="hiOpenTime" min="09:00" max="18:00" step="1800"
									value="${hosInfo.hiOpenTime}" required readonly>
							</div>
							<div class="col-sm-4">
								<input type="time" class="form-control form-control-user" id="hiCloseTime"
									name="hiCloseTime" min="09:00" max="18:00" step="1800"
									value="${hosInfo.hiCloseTime}" required readonly>
							</div>
						</div>
						<div class="row hospitalRow">
							<div class="col-md-4">
								<label>병원 휴식시간</label>
							</div>
							<div class="col-sm-4">
								<input type="time" class="form-control form-control-user" id="hiLunchStime"
									name="hiLunchStime" min="09:00" max="18:00" step="1800"
									value="${hosInfo.hiLunchStime}" required readonly>
							</div>
							<div class="col-sm-4">
								<input type="time" class="form-control form-control-user" id="hiLunchEtime"
									name="hiLunchEtime" min="09:00" max="18:00" step="1800"
									value="${hosInfo.hiLunchEtime}" required readonly>
							</div>
						</div>
					</div>
				</div>
				</form>
				<!-- 우측 하단 -->
				<div class="card card-info">

					<div class="card-header"
						style="background-color: #404b57; border: none;">
						<div class="d-flex justify-content-between align-items-center">
							<h4 class="card-title">체어 관리</h4>
						</div>
					</div>
					<!-- 					https://inpa.tistory.com/1093#datalist_%ED%83%9C%EA%B7%B8 -->
					<div class="card-body" style="height: 450px;">

						<form name="myTable" action="" method="post">
							<div class="card-body chairBoard"
								style="max-height: 317px; overflow-y: auto;">
								<table class="table table-bordered chairTable" id="myTable">
									<thead>
										<tr>
											<th style="width: 10px">🛠</th>
											<th>No.</th>
											<!-- 자동생성 -->
											<th>체어명</th>
											<!-- 직접 입력 -->
											<th>부서</th>
											<!-- 직접 입력 -->
										</tr>
									</thead>
									<tbody id="chairListBody">
										<c:forEach var="chair" items="${requestScope.chairList}" varStatus="stat">
											<tr class="trClassDelete">
												<td>
													<input type="checkbox" class="form-control chairSelected" id="deleteChairCheck"
														   name="user_CheckBox" id="" required /></td>
<%-- 												<td>${chair.chairSn}</td> --%>
												<td data-chairno="${chair.chairSn}">${stat.index + 1}</td>
												<td>
													<input type="text"
													data-chair="${chair.chairNm}" class="form-control updateInput"
													value="${chair.chairNm}" style="border: none;" readonly /></td>
												<td>
													<select id="deptCd" name="deptCd" class="form-control"
													data-dept="${chair.deptCd}" disabled>
														<option value="">진료실 선택</option>
														<c:forEach var="dept" items="${requestScope.deptList}">
															<option value="${dept.deptCd}"
																<c:if test='${dept.deptCd == chair.deptCd}'>selected</c:if>>${dept.deptNm}</option>
														</c:forEach>
												</select></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>



								<!-- 테이블에 추가할 테이블 내부 템플릿 -->
								<template id="rowTemplate">
									<tr class="trClassAdd">
										<td id="td1"><input type="checkbox" class="form-control"  name="user_Check" id="checkYn" required checked></td>
										<td id="td2"></td>
										<td id="td3"><input type="text" class="form-control" id="chairNm"/></td>
										<td id="td4"><select id="deptCd" name="deptCd" class="form-control updateInput" >
												<option value="">진료실 선택</option>
												<c:forEach var="dept" items="${requestScope.deptList}">
													<option value="${dept.deptCd}"
														<c:if test='${deptCd == dept.deptCd}'>selected</c:if>>${dept.deptNm}</option>
												</c:forEach>
										</select></td>
									</tr>
								</template>

								<template id="readOnlyTemplate">
									<tr class="trClassAdd">
										<td id="td1"><input type="checkbox"  name="user_Check" id="checkYn"></td>
										<td id="td2"></td>
										<td id="td3"><input type="text"  id="chairNm" style="border:none;" readOnly/></td>
										<td id="td4"><select id="deptCd" name="deptCd" class="updateInput" disabled >
												<option value="">진료실 선택</option>
												<c:forEach var="dept" items="${requestScope.deptList}">
													<option value="${dept.deptCd}">${dept.deptNm}</option>
												</c:forEach>
										</select></td>
									</tr>
								</template>

							</div>
						</form>
						<div class="card-footer">
						<!-- 일반모드 시작 -->

						<!-- 버튼 클릭하면 자바스크립트 실행 -->
						<input type="button" class="btn btn-success btn-inline btnCss violetBtn" id="addTr" value="추가" onclick="addRow()" disabled
						   style="background-color: #904aff; border: none; width: 10%; float:left; margin-right:-0.2em;" />
						<span id="spn1">
							<!-- 저장 클릭하면 자바스크립트 실행 -->
							<input type="button" class="btn btn-success btn-inline btnCss violetBtn" id="updateChair" value="저장" onclick="updateRow()" disabled
								   style="background-color: #904aff; border: none; width: 10%; margin-left:10px;"/>
						    <input type="button" class="btn btn-danger btn-inline btnCss redBtn" id="deleteChair" value="삭제" onclick="deleteRow()" disabled
						    	   style="border:none; width: 10%;"/>
				        </span>
						<!-- 일반모드 끝 -->

						<!-- 수정모드 시작 -->
						<span id="spn2" style="display: none;">
							<input type="button" class="btn btn-success btn-inline btnCss violetBtn" id="createChair" value="추가항목 저장" onclick="createRow()"
							       style="background-color: #904aff; border: none; width: 22%; margin-left:8px;">
							<input type="button" class="btn btn-danger btn-inline btnCss redBtn" id="cancelBtn"  value="취소"
							       style="border:none; width: 10%;" />
						</span>
						<!-- 수정모드 끝 -->


						</div>
					</div>
				</div>
			</div>

		</div>
	</section>
</div>