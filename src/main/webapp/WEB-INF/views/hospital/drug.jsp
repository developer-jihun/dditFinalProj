<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
/* chatCss */
#chatButton{
	padding-right:1.25rem;
}
.navbar-badge{
	top:5px;
}
/* **************************** */
.tableHead {
	position: sticky;
	top: -0.1px;
	background-color: whitesmoke;
}

#tabCard::-webkit-scrollbar-thumb {
    background-color: #404b57;
    border-radius: 5px;
}
#tabCard::-webkit-scrollbar-track {
    background-color: rgba(0,0,0,0);
}
#tabCard::-webkit-scrollbar {
    width: 10px;
    height: 10px;
}

.tablehover { cursor : pointer; }

thead, tbody{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight:500;
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
.redBtn:hover{
	background-color:#e13636 !important;
	color:white;
}
.navbar-light .navbar-nav .nav-link {
	color: #f8f9fa;
	margin-left: 0.5rem;
	height: 38px;
	padding: 0.25rem;
	display: flex;
	align-items: center;
}
</style>
<script type="text/javascript">
	$(function() {

		csrfToken = $('#_csrfToken').val();

		//발주 중 목록 초기 데이터 넣어주기
		$.ajax({
			url:"/hospital/drug/showPurchasing",
			dataType:"json",
			type:"get",
			success:function(result){

				let str = "";
				//result : List<PurchaseVO> purchaseVOList
				$.each(result,function(index,purchaseVO){
					//<tr><td>P20230307088</td><td>14</td><td>2023-03-07</td><td><select data-pur-num="P20230307088" class="custom-select form-control-border optionPurchasingDrug" id="exampleSelectBorder"><option>발주 중</option><option>발주 완료</option></select></td></tr>
					str += "<tr class='purchasingTr' data-purchasing-pur-num='"+purchaseVO.purNum+"'>";
					str += "<td>"+purchaseVO.purNum+"</td>";
					str += "<td>"+purchaseVO.purCost.toLocaleString()+"</td>";
					str += "<td>"+dateFormat(new Date(purchaseVO.purDt))+"</td>";
					str += "<td>";
					str += "<select data-pur-num='"+purchaseVO.purNum+"' class='custom-select form-control-border purchaseclass optionPurchasingDrug'>";
					str += "<option value='order' selected>발주 중</option>";
					str += "<option value='cancel'>발주 취소</option>";
					str += "<option value='complete'>발주 완료</option>";
					str += "</select>";
					str += "</td>";
					str += "</tr>";
				});

				$("#selectPurchasingDrug").append(str);
			}
		});



		//발주 완료 목록 초기 데이터 넣어주기
		$.ajax({
			url:"/hospital/drug/showPurchased",
			dataType:"json",
			type:"get",
			success:function(result){

				let str = "";
				//result : List<PurchaseVO> purchaseVOList
				$.each(result,function(index,purchaseVO){
					//<tr><td>P20230307088</td><td>14</td><td>2023-03-07</td><td><select data-pur-num="P20230307088" class="custom-select form-control-border optionPurchasingDrug" id="exampleSelectBorder"><option>발주 중</option><option>발주 완료</option></select></td></tr>
					str += "<tr>";
					str += "<td>" + purchaseVO.purNum + "</td>";
					str += "<td>" + purchaseVO.purCost.toLocaleString() + "</td>";
					str += "<td>" + dateFormat(new Date(purchaseVO.purDt)) + "</td>";
					str += "<td>";
					str += "<select data-pur-num='" + purchaseVO.purNum + "' class='custom-select form-control-border purchaseclass optionFinishPurchasingDrug'>";
					str += "<option>발주 중</option>";
					str += "<option selected>발주 완료</option>";
					str += "</select>";
					str += "</td>";
					str += "</tr>";
				});

				$("#finishPurchasingDrug").append(str);
			}
		});

		//검색 기능
		$("#keyword").keyup(function(e){
			//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
			if(e.keyCode && e.keyCode == 13){
				$("#search").trigger("click");
				return false;
			}

			searchMd();
		});

		//선택한 리스트 밑에 div에 한줄씩 꺼내기
		//고려사항 클릭시 비활성화시키기(재검색시에도...)
		//=>그것보다 아래 항목에 tr이 있는지 data에 담든, id를 만들어서 중복검사를 실행해서 있는지 비교하는 함수 만들기
		$(document).on("click", ".trSelect", function() {

			//클릭한 약품의 약품 번호
			let num = $(".drugNum", this).text();
			$("#num").text(num);

			let nm = $(".drugNm", this).text();
			$("#nm").text(nm);

			//이미 선택된 목록에 들어있는 항목인지 검사
			//클릭한 약품 목록의 배열(클릭해서 생성된 품목)
			let trArr = $(".purchaseDrugSelect");

			//목록의 약품 번호 꺼내기
			let count = 0;
			trArr.each(function(i, v) {
				let drugSelectNum = $(v).children()[0].textContent;
				//num과 선택한 목록 안의 약품 번호와 비교하는 함수 만들기
				if (num == drugSelectNum) {
					count++;
				}
			});

			//1이 true
			if (count) return false;

			let list = '';
			list += '<tr data-purchase-drug-select-tr='+num+' class="purchaseDrugSelect">';
			list += '<td class="selectDrugNum">' + num + '</td>';
			list += '<td>' + nm + '</td>';
			list += '<td><input class="purchaseDrugPrice" type="number" /></td>';
			list += '<td><input class="selectNumber" type="number" /></td>';
			list += '<td><div class="numPriceMulti">0</div></td>';
			list += '<td><button type="button" class="btn btn-light drugDelete" >삭제</button></td>';
			list += '</tr>';

			document.querySelector('#purchaseDrugList').insertAdjacentHTML('beforeEnd', list);
		});

		//가격을 마지막에 뗐을 때 비어있는지 확인해서 합계를 넣는 함수
		$(document).on('blur', '.purchaseDrugPrice', function() {
			process($(".selectNumber"), $(".purchaseDrugPrice"));

		});

		//개수를 마지막에 뗐을 때 비어있는지 확인해서 합계를 넣는 함수
		$(document).on('blur', '.selectNumber', function() {
			process($(".selectNumber"), $(".purchaseDrugPrice"));
		});

		function process(ele1, ele2){
			var total = 0;
			for(var i=0; i < ele1.length; i++){
				var selectNum = ele1[i].value;
				var purPrice = ele2[i].value;

				var sum = selectNum * purPrice;
				total += sum;

				$(".numPriceMulti")[i].innerText = sum.toLocaleString();
			}

			$("#sumAllInput").html(total.toLocaleString());
		}

		//삭제 버튼 클릭시 지우기
		$(document).on("click", ".drugDelete", function() {
			$(this).parent().parent().remove();
			process($(".selectNumber"), $(".purchaseDrugPrice"));
		});

		//모두 삭제 버튼 클릭시 선택했던 약품 모두 삭제하기
		$("#selectDrugDeleteAll").on("click", function() {
			$(".purchaseDrugSelect").remove();
			$("#sumAllInput").html(0);
			process($(".selectNumber"), $(".purchaseDrugPrice"));
		});


		//*****발주하기 버튼 클릭 시 선택했던 약품 발주 중으로
		$("#selectDrugPurchase").on("click",function() {

			let priceIndex = -1;
			$(".purchaseDrugPrice").each(function(i, v) {
				//console.log("i", i);

				//console.log("==== index", index);
				if (priceIndex > -1) return;

				if ($(v).val() == null || $(v).val().trim() == "" || $(v).val() == 0) {
					priceIndex = i;
				}
			});

			//console.log("index", index);
			if (priceIndex > -1) {
				simpleErrorAlert("가격을 입력해주세요.");
				$(".purchaseDrugPrice").get(priceIndex).focus();
				return;
			}

			let numberIndex = -1;
			$(".selectNumber").each(function(i, v) {

				if (numberIndex > -1) return;

				if ($(v).val() == null || $(v).val().trim() == "" || $(v).val() == 0) {
					numberIndex = i;
				}
			});

			//console.log("index", index);
			if (numberIndex > -1) {
				simpleErrorAlert("개수를 입력해주세요.");
				$(".selectNumber").get(numberIndex).focus();
				return false;
			}

			Swal.fire({
				  title : '발주 중',
			      text: '발주 주문하시겠습니까?',
			      showDenyButton: true,
			      confirmButtonText: '예',
			      denyButtonText: '아니요',
			   }).then((result) => {
			      if (result.isConfirmed) {

				totalPrice = 0;

				/*
					1 : PurchaseVO
						private String purNum;	//자동증가
						private int purCost;	//총합
						private Date purDt;		//sysdate
						private String purStatus; //1(발주중)
						private List<PurchaseDrugVO> purchaseDrugList

					N : PurchaseDrugVO
						private int purDrugSn;	//자동증가
						private String purNum;	//발주번호(부모 데이터)
						private int drugNum;	//약품번호
						private String drugNm;	//약품명(서브쿼리로 처리)
						private int purDrugCount;	//개수

				 */
				let purchaseDrugList = [];

				//필요한 데이터 : 총합, 약품번호, 개수
				//입력된 값을 가져올 때는 text, html로 가져오고  input과 같이 값을 입력하는 것은 val로 가져오기
				//1) 총합=>완료
				let purchaseDrugCost = $("#sumAllInput").text().replaceAll(",", "");
// 				purchaseDrugCost = parseInt(purchaseDrugCost);
				console.log("purchaseDrugCost : "+ purchaseDrugCost);

				//2) 약품번호
				//data : <td class="selectDrugNum">201103627</td>
				let selectDrugNum = [];
				$(".selectDrugNum").each(function(index, data) {
					console.log("index : " + index+ ", data : "+ $(this).text());

					selectDrugNum[index] = $(this).text();
					console.log("selectDrugNum["+ index + "] :"+ selectDrugNum[index]);
				});

				//3) 개수
				let selectNumber = [];
				$(".selectNumber").each(function(index, data) {
					console.log("index : " + index+ ", data : " + $(this).val());
					selectNumber[index] = $(this).val();
					console.log("selectNumber[" + index+ "] :" + selectNumber[index]);
				});

				for (let i = 0; i < selectDrugNum.length; i++) {
					let arr = {
						"drugNum" : selectDrugNum[i],
						"purDrugCount" : selectNumber[i]
					};
					purchaseDrugList.push(arr);
				}

				//1
				let data = {
					"purCost" : purchaseDrugCost,
					"purchaseDrugList" : purchaseDrugList
				};

				//data : {"purCost":"26","purchaseDrugList":[{"drugNum":"201103366","purDrugCount":"2"},{"drugNum":"201103628","purDrugCount":"4"}]}

				$.ajax({
					url : "/hospital/drug/purchase",
					contentType : "application/json;charset:utf-8",
					data : JSON.stringify(data),
					type : "post",
					dataType : "json",
					beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
						xhr.setRequestHeader("X-CSRF-TOKEN", csrfToken);
					},
					success : function(result) {

						//result : PurchaseVO [purNum=P20230306003, purCost=26, purDt=2023/03/06, purStatus=1,
						//		purchaseDrugList=[PurchaseDrugVO [purDrugSn=5, purNum=P20230306003, drugNum=201100501, drugNm=칼도롤주사액(이부프로펜), purDrugCount=2],
						//		                  PurchaseDrugVO [purDrugSn=6, purNum=P20230306003, drugNum=201103628, drugNm=스피딕400연질캡슐(이부프로펜), purDrugCount=4]]]
						console.log("result : "+ JSON.stringify(result));
						console.log("dateFormat(new Date(result.purDt)) : "+ dateFormat(new Date(result.purDt)));

						//발주 상태가 1이라면 발주 중으로 변경해주고 select 태그 넣어주기

						let str = "";
						str += "<tr class='purchasingTr'>";
						str += "<td>" + result.purNum + "</td>";
						str += "<td>" + result.purCost.toLocaleString() + "</td>";
						str += "<td>" + dateFormat(new Date(result.purDt)) + "</td>";
						str += '<td>';
						str += '<select data-pur-num="' + result.purNum + '" class="custom-select form-control-border purchaseclass optionPurchasingDrug" id="exampleSelectBorder">';
						str += '<option value="order" selected>발주 중</option>';
						str += '<option value="cancel">발주 취소</option>';
						str += '<option value="complete">발주 완료</option>';
						str += '</select>';
						str += '</td>';
						str += "</tr>";

						document.querySelector('#selectPurchasingDrug').insertAdjacentHTML('afterbegin', str);

					}

				});

				simpleSuccessAlert('발주가 등록되었습니다.');
				$(".purchaseDrugSelect").remove();
				$("#sumAllInput").html(0);
		      }
		   });

		});

		//발주 완료로 바꾸면...
		$(document).on("change",".optionPurchasingDrug",function() {

			const selectStatus = $(this).val();

			if(selectStatus == 'complete'){ // 발주 완료 선택 시

				Swal.fire({
					title : '발주 완료 중',
					text: '발주 완료하시겠습니까?',
					showDenyButton: true,
					confirmButtonText: '예',
					denyButtonText: '아니요',
				}).then((result) => {

					if (result.isDenied){
						$(this).prop('selectedIndex', 0);
						return;
					}

					if (result.isConfirmed) {

					//발주 번호 추출하기(data-pur-num=..)
					let purchaseNum = $(this).data("purNum");
					let data = {
						"purNum" : purchaseNum
					};

					let finishTr = $(this).parent().parent();

					//발주  재고량 일괄 변경 및 발주 완료목록 띄우기
					$.ajax({
						url : "/hospital/drug/updateCount",
						contentType : "application/json;charset:utf-8",
						data : JSON.stringify(data),
						type : "post",
						dataType : "json",
						async : false,
						beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
							xhr.setRequestHeader("X-CSRF-TOKEN", csrfToken);
						},
						success : function(result) {
							//result : List<PurchaseVO> purchaseVOList

							let str = "";
							//finishPurchasingDrug에 접근하여 append 처리
							//result : List<PurchaseVO> purchaseVOList
							$.each(result,function(index,result) {
								str += "<tr>";
								str += "<td>"+ result.purNum+ "</td>";
								str += "<td>"+ result.purCost.toLocaleString()+ "</td>";
								str += "<td>"+ dateFormat(new Date(result.purDt))+ "</td>";
								str += '<td>';
								str += '<select data-pur-num="' + result.purNum + '" class="custom-select form-control-border purchaseclass optionFinishPurchasingDrug" id="exampleSelectBorder">';
								str += '<option value="order">발주 중</option>';
								str += '<option value="complete" selected>발주 완료</option>';
								str += '</select>';
								str += '</td>';
								str += "</tr>";
							});

							$("#finishPurchasingDrug").html(str);

							finishTr.remove();
							simpleSuccessAlert('발주가 완료되었습니다.');
							searchMd();
						}
					});


			      }
			   });

			} else if(selectStatus == 'cancel'){ // 발주 취소 선택 시

				Swal.fire({
					title : '발주 취소 중',
					text: '발주 취소하시겠습니까?',
					showDenyButton: true,
					confirmButtonText: '예',
					denyButtonText: '아니요',
				}).then((result) => {

					if (result.isDenied){
						$(this).prop('selectedIndex', 0);
						return;
					}

					if (result.isConfirmed) {

						const targetRow = $(this).parents('.purchasingTr');
						const purNum = targetRow.children()[0].textContent;

						$.ajax({
							url: '/hospital/drug/cancelPurchase',
							type: 'post',
							beforeSend: function(xhr){
								xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
								xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
							},
							data: JSON.stringify({
								purNum : purNum
							}),
							dataType: 'text',
							success: function(result){
								if(result == 'FAILED'){
									simpleErrorAlert('잠시 후 다시 시도해주세요.');
									return;
								}

								targetRow.remove();
								simpleSuccessAlert('발주가 취소되었습니다.');
								searchMd();
							}
						});

					}
				});

			}

		});

		//발주 중으로 바꾸면...
		$(document).on("change",".optionFinishPurchasingDrug",function() {

			Swal.fire({
				title : '발주 완료 취소 중',
				text: '다시 발주 중으로 돌리시겠습니까?',
				showDenyButton: true,
				confirmButtonText: '예',
				denyButtonText: '아니요',
			}).then((result) => {

				if (result.isDenied){
					$(this).prop('selectedIndex', 1);
					return;
				}

				if (result.isConfirmed) {

					//발주 번호 추출하기(data-pur-num=..)
					let purchaseNum = $(this).data("purNum");
					let data = {
						"purNum" : purchaseNum
					};

					let finishTr = $(this).parent().parent();

					//발주  재고량 일괄 변경 및 발주 완료목록 띄우기
					$.ajax({
						url : "/hospital/drug/reupdateCount",
						contentType : "application/json;charset:utf-8",
						data : JSON.stringify(data),
						type : "post",
						async : false,
						dataType : "json",
						beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(result) {
							//result : List<PurchaseVO> purchaseVOList
							console.log("result : "+ JSON.stringify(result));

							let str = "";
							//finishPurchasingDrug에 접근하여 append 처리
							//result : List<PurchaseVO> purchaseVOList
							$.each(result,function(index,result) {
								str += "<tr class='purchasingTr'>";
								str += "<td>"+ result.purNum+ "</td>";
								str += "<td>"+ result.purCost.toLocaleString()+ "</td>";
								str += "<td>"+ dateFormat(new Date(result.purDt))+ "</td>";
								str += '<td>';
								str += '<select data-pur-num="' + result.purNum + '" class="custom-select form-control-border purchaseclass optionPurchasingDrug" id="exampleSelectBorder">';
								str += '<option value="order" selected>발주 중</option>';
								str += '<option value="cancel">발주 취소</option>';
								str += '<option value="complete">발주 완료</option>';
								str += '</select>';
								str += '</td>';
								str += "</tr>";
							});

							$("#selectPurchasingDrug").html(str);

							finishTr.remove();
							simpleSuccessAlert('발주가 변경되었습니다.');
							searchMd();
						}
					});

				}
			});
		});

		//기간 설정 시 해당 발주 완료 목록 띄우기
		$("#dateBtn").on("click",function(){
			let startDate = $("#startDate").val();
			let endDate = $("#endDate").val();
			console.log("startDate : " + startDate + ", typeof endDate : " + typeof endDate);
			let purchaseVO = {"startDate" : startDate, "endDate" : endDate};
			console.log("data : " + JSON.stringify(purchaseVO));

			$.ajax({
				url : "/hospital/drug/purchasePeriod",
				contentType:"application/json;charset:utf-8",
				data : JSON.stringify(purchaseVO),
				type : "post",
				dataType:"json",
				beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					console.log("result : " + JSON.stringify(result));
					console.log(result);

					let str = "";
					//반복문으로 str 작성하고 html로 #finishPurchasingDrug에 뿌려주기
					$.each(result,function(index,data){
						str += '<tr>';
						str += '<td>' + data.purNum + '</td>';
						str += '<td>' + data.purCost + '</td>';
						str += '<td>' + data.purDt + '</td>';
						str += '<td>';
						str += '<select data-pur-num="' + data.purNum + '" class="custom-select form-control-border purchaseclass optionFinishPurchasingDrug">';
						str += '<option>발주 중</option>';
						str += '<option selected>발주 완료</option>';
						str += '</select>';
						str += '</td>';
						str += '</tr>';
					});

					$("#finishPurchasingDrug").html(str);

				}
			});


		});

	});

	// 약품 목록 조회
	function searchMd(){

		//약품 목록의 재고수량 발주 중으로 바꾸자마자 바뀌기
		let keyword = $("#keyword").val();
		console.log(keyword);

		$.ajax({
			url : "/hospital/drug/showMd?keyword=" + keyword,
			contentType : "application/json;charset=utf-8",
			// 				data:JSON.stringify(data),
			type : "get",
			dataType : "json",
			success : function(result) {

				let str = "";
				//#DrugList에 반복문을 통해 리스트 넣어주기
				$.each(result,function(index,data){
					if(data.drugNmEn=="null") {
						data.drugNmEn = "";
					}
					str += "<tr class='trSelect'>";
					str += "<td class='drugNum'>"+data.drugNum+"</td>";
					str += "<td class='drugNm'>"+data.drugNm+"</td>";
					str += "<td>"+data.drugNmEn+"</td>";
					str += "<td>"+data.drugType+"</td>";
					str += "<td>"+data.drugIngre+"</td>";
					str += "<td>"+data.drugComp+"</td>";
					str += "<td>"+data.drugCount+"</td>";
					str += "</tr>";

				});

				$("#DrugList").html(str);
			}
     	});

	}

	function dateFormat(mydate) {
		let month = (mydate.getMonth() + 1);
		month = month < 10 ? "0" + month : month;
		let day = mydate.getDate();
		day = day < 10 ? "0" + day : day;

		return mydate.getFullYear() + "-" + month + "-" + day;
	}


</script>
<title>약품관리시스템</title>
	<div class="content-wrapper"
		style="background-color: rgb(101, 125, 150); min-height: 1033px;">
		<!-- main 검색창을 포함한 navbar 시작-->
		<nav class="navbar navbar-expand navbar-white navbar-light"
			style="background-color: #404b57;">

			<div class="dropdown">
				<!-------------------- 검색대 -------------------->
				<input type="text" class="form-control" id="keyword" name="keyword"
					placeholder="발주할 약품을 입력해주세요." style="width: 400px;" autocomplete="off" />
				<ul id="ptSearchDropdown" class="dropdown-menu">
				</ul>
				<!-------------------- 검색대 -------------------->
			</div>
<!-- 			<img src="/resources/images/layout/memo_icon.png" alt="메모" id="memo" -->
<!-- 				class="brand-image elevation-1" style="margin-left: 15px;"> -->

		<ul class="navbar-nav ml-auto"></ul>
		<div class="manageMenu">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light" href="/hospital/manage/empInfo">직원관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link btn btn-outline-light active" href="/hospital/drug">약품관리</a>
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

		<!--
		<div class="collapse navbar-collapse" id="navbarTogglerDemo03"
			style="margin-left: 47%;">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link"
					href="/hospital/manage/empInfo" style="color: white;">직원관리</a></li>

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
		<section class="content" style="margin-top: 1%;">

			<div class="row">
				<div class="col-lg-8">
					<!-------------------- 목록 리스트 -------------------->
						<div class="card">
							<div class="card-header" style="background-color: #404b57;">
								<h3 class="card-title" style="color: white;">약품 목록</h3>
							</div>

							<div class="card-body table-responsive p-0"
								style="height: 350px; border-bottom: 20px; overflow-x: hidden;"
								id="tabCard">
								<div id="example2_wrapper"
									class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table id="table table-hover text-nowrap"
												class="table table-bordered table-hover dataTable dtr-inline tablehover"
												aria-describedby="example2_info"
												style="table-layout: fixed;">
												<thead class="tableHead text-center">
													<tr>
														<th style="width: 9%;">약품 번호</th>
														<th style="width: 17%;">약품 한글 명</th>
														<th style="width: 15%;">약품 영문 명</th>
														<th style="width: 9%;">약품 종류</th>
														<th style="width: 9%;">약품 주성분</th>
														<th style="width: 9%;">약품 제조사</th>
														<th style="width: 9%;">약품 재고수</th>
													</tr>
												</thead>
												<tbody id="DrugList"></tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					<!-------------------- 목록 리스트 -------------------->
				</div>
				<div class="col-lg-4">
					<!-------------------- 발주 중 목록 리스트 -------------------->
				<div class="card">
					<div class="card-header" style="background-color: #404b57;">
						<h3 class="card-title" style="color: white;">발주 중 목록</h3>
					</div>

					<div class="card-body table-responsive p-0"
						style="height: 350px; border-bottom: 20px; overflow-x: hidden;"
						id="tabCard">
						<div id="example2_wrapper"
							class="dataTables_wrapper dt-bootstrap4">
							<div class="row">
								<div class="col-sm-12">
									<table id="table table-hover text-nowrap"
										class="table table-bordered table-hover dataTable dtr-inline purchasingDrug"
										aria-describedby="example2_info">
										<thead class="tableHead text-center">
											<tr>
												<th scope="col">발주 번호</th>
												<th scope="col">발주 예상 비용</th>
												<th scope="col">발주 일시</th>
												<th scope="col">발주 상태</th>
											</tr>
										</thead>
										<tbody id="selectPurchasingDrug"></tbody>
									</table>
								</div>

							</div>
						</div>
					</div>
					<!-- 테스트 -->
<!-- 						<div class="card-footer"> -->
<!-- 							<div class="row" style="margin-left:40%;"> -->
<!-- 								<ul class="pagination pagination-sm"> -->
<!-- 									<li class="page-item"><a href="#" class="page-link">«</a></li> -->
<!-- 									<li class="page-item"><a href="#" class="page-link">1</a></li> -->
<!-- 									<li class="page-item"><a href="#" class="page-link">2</a></li> -->
<!-- 									<li class="page-item"><a href="#" class="page-link">3</a></li> -->
<!-- 									<li class="page-item"><a href="#" class="page-link">»</a></li> -->
<!-- 								</ul> -->
<!-- 							</div> -->
<!-- 						</div> -->
					<!-- 테스트 -->

				</div>
				<!-------------------- 발주 중 목록 리스트 -------------------->
				</div>
			</div>

			<div class="row">
				<div class="col-lg-8">
					<!-------------------- 선택한 목록 -------------------->
						<div class="card">
							<div class="card-header" style="background-color: #404b57;">
								<h3 class="card-title" style="color: white;">선택 목록</h3>
							</div>

							<div class="card-body table-responsive p-0"
								style="height: 350px; border-bottom: 20px; overflow-x: hidden;" id="tabCard">
								<div id="example2_wrapper"
									class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table id="table table-hover text-nowrap"
												class="table table-bordered table-hover dataTable dtr-inline"
												aria-describedby="example2_info">
												<thead class="tableHead text-center">
													<tr>
														<th scope="col" style="width: 10%;">약품 번호</th>
														<th scope="col" style="width: 25%;">약품 한글 명</th>
														<th scope="col" style="width: 20%;">발주 약품 가격</th>
														<th scope="col" style="width: 20%;">발주 약품 개수</th>
														<th scope="col" style="width: 9%;">합계</th>
														<th scope="col" style="width: 8%;">삭제</th>
													</tr>
												</thead>
												<tbody id="purchaseDrugList"></tbody>
											</table>
										</div>

									</div>
								</div>


							</div>
							<div class="card-footer">
								<!-- 목록 총합 -->
								<div class="d-flex justify-content-between align-items-center">
									<h2>
										총합 : <span id="sumAllInput">0</span>
									</h2>
									<div class="d-flex justify-content-end align-items-center">
										<input type="button" class="btn btn-info btnCss violetBtn"
											style="background-color: #904aff; border: #904aff; margin-right:5px;"
											id="selectDrugPurchase" value="발주하기" />
										<input type="button"
											class="btn btn-warning btnCss redBtn"
											style="color: white; border: none; background-color: #ff3e3e;"
											id="selectDrugDeleteAll" value="모두 삭제" />
									</div>
								</div>
								<!-- 목록 총합 -->
							</div>
						</div>
					<!-------------------- 선택한 목록 -------------------->
				</div>
				<div class="col-lg-4">

					<!-------------------- 발주 완료 목록 리스트 -------------------->
						<div class="card">
							<div class="card-header" style="background-color: #404b57;">
								<h3 class="card-title" style="color: white;">입고 완료 목록</h3>

								<!-- 테스트 -->
								<div style="max-height: 45px; float:right;">
									<input type="date" id="startDate" />
									<span style="color:white;">~</span>
									<input type="date" id="endDate" />
									<input type="button" class="btn-primary violetBtn" id="dateBtn"
										style="width: 50px; border: 0px; height: 30px; vertical-align: bottom; border-radius: 4px;" value="검색">
								</div>
								<!-- 테스트 -->


							</div>

							<div class="card-body table-responsive p-0"
								style="height: 410px; border-bottom: 20px; overflow-x: hidden;"
								id="tabCard">
								<div id="example2_wrapper"
									class="dataTables_wrapper dt-bootstrap4">
									<div class="row">
										<div class="col-sm-12">
											<table id="table table-hover text-nowrap"
												class="table table-bordered table-hover dataTable dtr-inline purchasingDrug"
												aria-describedby="example2_info">
												<thead class="tableHead text-center">
													<tr>
														<th scope="col">발주 번호</th>
														<th scope="col">발주 예상 비용</th>
														<th scope="col">발주 일시</th>
														<th scope="col">발주 상태</th>
													</tr>
												</thead>
												<tbody id="finishPurchasingDrug"></tbody>
											</table>
										</div>

									</div>
								</div>
							</div>
						</div>
					<!-------------------- 발주 완료 목록 리스트 -------------------->
				</div>
			</div>

		</section>
	</div>

<script src="/resources/js/alertModule.js"></script>