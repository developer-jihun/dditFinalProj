<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	background-color: rgba(0, 0, 0, 0);
}

#tabCard::-webkit-scrollbar {
	width: 10px;
	height: 10px;
}

#txCodeList {
	cursor: pointer;
}

.table {font-size: 12pt;}

.cancel{
	padding-left:10px;
	cursor: pointer;
	font-weight:bold;
	color: red;
}

tbody,thead{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight:700;
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

<!-- 권한
관리자일때와 직원일때 활성화되는 버튼이 달라요
1) 관리자 : 수정/등록/삭제
2) 직원 : 비우기
 -->
 <!-- script(61~171번줄)는 관리자로 로그인한 경우에는 있으나,
 	그 이외의 권한(ROLE_EMP)은 안보임
  -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.empVO" var="empVO" />
	<sec:authentication property="principal.empVO.authList" var="authList" />
	<sec:authentication property="principal.empVO.authList[0].empAuthrt" var="empAuthrt" />
</sec:authorize>
<script>
	$(function(){
		let empAuthrt = "${empAuthrt}";
		let authList = "${authList}";

		console.log("empAuthrt : " + empAuthrt);
		console.log("authList : " + authList);

		if("${message}" != null && "${message}" != ""){
			simpleSuccessAlert("${message}");
		}

		//ROLE_ADMIN일 때 시작///////////////////////
		if(empAuthrt=="ROLE_ADMIN"){
			console.log("ROLE_ADMIN");
			$("#insertMode").css("display","block");
			$("#updateBtnMode").css("display","none");
			$("#resetMode").css("display","block");
			$("#updateMode").css("display","none");
			$("#deleteMode").css("display","none");
			
			$("#drugSearch").prop("readonly",true);
		//ROLE_ADMIN일 때 끝///////////////////////
		}else{
			//ROLE_EMP일 때 시작///////////////////////
			console.log("ROLE_EMP");
			$("#insertMode").css("display","none");
			$("#updateBtnMode").css("display","none");
			$("#resetMode").css("display","block");
			$("#updateMode").css("display","none");
			$("#deleteMode").css("display","none");

			$("#txcCd").prop("readonly",true);
			$("#txcNm").prop("readonly",true);
			$("#txcPrice").prop("readonly",true);
			$("#checkBtn").prop("disabled",true);
			$("#drugSearch").prop("readonly",true);
			//ROLE_EMP일 때 끝///////////////////////
		}


		//tr 클릭시 상세 조회 읽기 전용으로
		$(document).on("click",".txCodeListTr",function(){

			$('.txCodeListTr').children('td').css({'background-color' : '', 'color' : ''});
			$(this).children('td').css({'background-color' : 'rgb(101, 125, 150)', 'color' : 'white'});

// 			$('.txCodeListTr').children('td').css({'color' : '', 'font-weight' : ''});
// 			$(this).children('td').css({'color' : 'red', 'font-weight' : 'bold'});


			console.log("나왔다.");
			let code = $(this).children()[0].textContent;
			console.log("code : " + code);
			$("#txcCd").val(code);
			let name = $(this).children()[1].textContent;
			$("#txcNm").val(name);
			let price = $(this).children()[2].textContent;
			console.log("price : " + price);
			let dataPrice = $(this).data("txcPrice");
			console.log("dataPrice : ", dataPrice);
			//data-txcPrice="'+vo.txcPrice+'"
			let toLacaleStringPrice = dataPrice.toLocaleString();
			console.log("toLacaleStringPrice : " + toLacaleStringPrice);
			$("#txcPrice").val(toLacaleStringPrice);


			$("#txcCd").prop("readonly",true);
			$("#txcNm").prop("readonly",true);
			$("#txcPrice").prop("readonly",true);
			$("#checkBtn").prop("disabled",true);
			$("#drugSearch").prop("readonly",true);

			<!-- insertMode, resetMode, updateBtnMode, updateMode, deleteMode -->
			//ROLE_ADMIN일 때 시작///////////////////////
			if(empAuthrt=="ROLE_ADMIN"){
				console.log("ROLE_ADMIN");
				$("#insertMode").css("display","none");
				$("#updateBtnMode").css("display","block");
				$("#resetMode").css("display","block");
				$("#updateMode").css("display","none");
				$("#deleteMode").css("display","block");
			//ROLE_ADMIN일 때 끝///////////////////////
			}else{
				//ROLE_EMP일 때 시작///////////////////////
				console.log("ROLE_EMP");
				$("#insertMode").css("display","none");
				$("#updateBtnMode").css("display","none");
				$("#resetMode").css("display","block");
				$("#updateMode").css("display","none");
				$("#deleteMode").css("display","none");
				//ROLE_EMP일 때 끝///////////////////////
			}


			$("#coment").text('');

			$("#drugList").empty();

			let data = {"txcCd":code};
			console.log("data : " + JSON.stringify(data));

			//처치 약품 상세조회
			$.ajax({
				url:"/hospital/txCode/selectDrugList",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType : "json",
				beforeSend : function(xhr) { // 데이터 전송 전 헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					/*
					result : List<DrugVO>
					이름drugNm	종류drugType	주성분drugIngre	제조사drugComp
					result :  [
						//{"drugNum":197500185,"drugNm":"파목신캡슐250밀리그램(아목시실린수화물)","drugNmEn":"Pamoxin Cap. 250mg","drugType":"항생제","drugIngre":"아목시실린수화물","drugComp":"동화약품(주)","drugCount":0,"dosage":0,"doses":0,"dosesdate":0,"drugList":null,"purchaseDrugList":null},
						//{"drugNum":197500272,"drugNm":"에이씰린캡슐250밀리그램(아목시실린)","drugNmEn":"A-Cillin Cap. 250mg(Amoxicillin)","drugType":"항생제","drugIngre":"아목시실린수화물","drugComp":"(주)보령","drugCount":0,"dosage":0,"doses":0,"dosesdate":0,"drugList":null,"purchaseDrugList":null},
						//{"drugNum":197900574,"drugNm":"일동아목시실린수화물캡슐250밀리그램","drugNmEn":"Ildong Amoxicillin Hydrate Cap. 250mg","drugType":"항생제","drugIngre":"아목시실린수화물","drugComp":"일동제약(주)","drugCount":0,"dosage":0,"doses":0,"dosesdate":0,"drugList":null,"purchaseDrugList":null}]
					*/
					console.log("result : ", JSON.stringify(result));

					let str = "";

					$.each(result, function(index,drugVO){
						//<tr class="selectedDrug" data-drug-num="199601337"><td><input type="hidden" name="dataDrugNum" value="199601337">아스타펜정160밀리그람(아세트아미노펜제피세립)</td><td>진통소염제<span class="cancel">  X</span></td><td>아세트아미노펜제피세립</td><td>삼남제약(주)</td></tr>
						str += "<tr class='selectedDrug' data-drug-num='"+drugVO.drugNum+"'><td><input type='hidden' name='dataDrugNum' value='"+drugVO.drugNum+"'>"+drugVO.drugNm+"</td><td>"+drugVO.drugType+"<span class='cancel' style='display:none;'>  X</span></td><td>"+drugVO.drugIngre+"</td><td>"+drugVO.drugComp+"</td></tr>"
					});

					$("#drugSelectList").html(str);
				}
			});

		});


		//수정하기 클릭시 수정모드 활성화시키기
		$("#txUpdateBtn").on("click",function(){
			beforeTxcNm = $("#txcNm").val();
			beforTxcPrice = $("#txcPrice").val();
			console.log("beforeTxcNm : " + beforeTxcNm + ", beforTxcPrice : " + beforTxcPrice);
			console.log("나왔다.");


			$("#txcCd").prop("readonly",true);
			$("#txcNm").prop("readonly",false);
			$("#txcPrice").prop("readonly",false);
			$("#checkBtn").prop("readonly",false);
			$("#drugSearch").prop("readonly",false);


			<!-- insertMode, resetMode, updateBtnMode, updateMode, deleteMode -->
			$("#updateMode").css("display","block");
			$("#insertMode").css("display","none");
			$("#resetMode").css("display","none");
			$("#updateBtnMode").css("display","none");
			$("#deleteMode").css("display","none");

			//cancel 보이기
			$(".cancel").css("display","block");

		});

		//비우기 클릭시 지워지되 활성화시키고
		$("#txResetBtn").on("click",function(){

			//ROLE_ADMIN일 때 시작///////////////////////
			if(empAuthrt=="ROLE_ADMIN"){
				console.log("ROLE_ADMIN");
	 			$("#txcCd").prop("readonly",false);
	 			$("#txcNm").prop("readonly",false);
	 			$("#txcPrice").prop("readonly",false);
	 			$("#checkBtn").prop("disabled",false);
	 			$("#txInsertBtn").prop("disabled",true);
	 			$("#drugSearch").prop("readonly",true);

	 			<!-- insertMode, resetMode, updateBtnMode, updateMode, deleteMode -->
	 			$("#deleteMode").css("display","none");
	 			$("#insertMode").css("display","block");
	 			$("#resetMode").css("display","block");
	 			$("#updateBtnMode").css("display","none");
	 			$("#updateMode").css("display","none");

	 			$("#coment").text('');
	 			$("#drugSelectList").empty();

	 			$(".cancel").css("display","none");

	 	        $("#txcCd").val("");
	 	        $("#txcNm").val("");
	 	        $("#txcPrice").val("");
			//ROLE_ADMIN일 때 끝///////////////////////
			}else{
				//ROLE_EMP일 때 시작///////////////////////
				console.log("ROLE_EMP");
				$("#insertMode").css("display","none");
				$("#updateBtnMode").css("display","none");
				$("#resetMode").css("display","block");
				$("#updateMode").css("display","none");
				$("#deleteMode").css("display","none");

				$("#txcCd").prop("readonly",true);
				$("#txcNm").prop("readonly",true);
				$("#txcPrice").prop("readonly",true);
				$("#checkBtn").prop("disabled",true);
				$("#drugSearch").prop("readonly",true);

				$("#coment").text('');
	 			$("#drugSelectList").empty();

	 			$(".cancel").css("display","none");

	 	        $("#txcCd").val("");
	 	        $("#txcNm").val("");
	 	        $("#txcPrice").val("");
				//ROLE_EMP일 때 끝///////////////////////
			}


// 			$("#txcCd").prop("readonly",false);
// 			$("#txcNm").prop("readonly",false);
// 			$("#txcPrice").prop("readonly",false);
// 			$("#checkBtn").prop("disabled",false);
// 			$("#txInsertBtn").prop("disabled",true);
// 			$("#drugSearch").prop("readonly",false);

// 			<!-- insertMode, resetMode, updateBtnMode, updateMode, deleteMode -->
// 			$("#deleteMode").css("display","none");
// 			$("#insertMode").css("display","block");
// 			$("#resetMode").css("display","block");
// 			$("#updateBtnMode").css("display","none");
// 			$("#updateMode").css("display","none");

// 			$("#coment").text('');
// 			$("#drugSelectList").empty();

// 			$(".cancel").css("display","none");

// 	        $("#txcCd").val("");
// 	        $("#txcNm").val("");
// 	        $("#txcPrice").val("");


		});

		//등록하기 클릭시 DB에 등록하기
		$("#txInsertBtn").on("click", function(){
			let txcCd = $("#txcCd").val();
			let txcNm = $("#txcNm").val();
			let price = $("#txcPrice").val();
			let txcPrice = uncomma(price);
	   		let coment = $("#coment").text();

	   		var dataDrugNum = "";

	   		$("[name='dataDrugNum']").each(function(index, obj){
	   			if(index == 0){
	   				dataDrugNum = $(obj).val();
	   			}else{
	   				dataDrugNum += ","+$(obj).val();
	   			}
	   		});

	   		console.log("dataDrugNum : " + dataDrugNum);

	   		//alert(data-drug-num);

	   		console.log("coment 검사중 : " + coment);
	   		console.log("txcCd : " + txcCd + "txcNm : " + txcNm + "txcPrice : " + txcPrice);


		    if(jQuery.trim(txcCd)==""){
		    	setTimeout(() => simpleErrorAlert('처치코드를 작성해주세요.'), 100);
		    	$("#txcCd").focus();
		        return false;
	   		 }

		    if(jQuery.trim(txcNm)==""){
		    	setTimeout(() => simpleErrorAlert('치료명을 작성해주세요.'), 100);
	            $("#txcNm").focus();
	            return false;
		    }

	   		if(jQuery.trim(txcPrice)==""){
		    	setTimeout(() => simpleErrorAlert('가격 작성해주세요.'), 100);
	            $("#txcPrice").focus();
	            return false;
		    }



	   		if(jQuery.trim(coment)=="*아이디를 사용할 수 없습니다."){
		    	setTimeout(() => simpleErrorAlert('처치 코드를 사용할 수 없습니다.\n 다시 입력해주세요.'), 100);
	            $("#txcCd").focus();
	            return false;

	   		}


	   		let data ={  "txcCd":txcCd
	   				   , "txcNm":txcNm
	   				   , "txcPrice":txcPrice
	   				   , "dataDrugNum":dataDrugNum
	   		};

	   		console.log("data" , data);
	   		$.ajax({
		        url:"/hospital/txCode/insertPost",
		        contentType:"application/json;charset:utf-8",
		        data:JSON.stringify(data),
		        type:"post",
		        dataType:"json",
		        beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
		        success:function(result) {
		            console.log("result : " + JSON.stringify(result));

		            let vo = result.txCodeVO;
		            console.log(vo);

		            let price = vo.txcPrice.toLocaleString();
		            console.log("price : " + price);

		            //str에 담기 txCodeList
		            let str = "";
		            str += '<tr class="txCodeListTr" data-txc-cd="'+vo.txcCd+'" data-txc-price="'+vo.txcPrice+'" id="'+vo.txcCd+'">';
		            str += '	<td>'+vo.txcCd+'</td>';
		            str += '	<td>'+vo.txcNm+'</td>';
		            str += '	<td>'+price+'</td>';
		            str += '</tr>';

		            $("#txCodeList").prepend(str);

		            //alert 띄우기
			    	setTimeout(() => simpleSuccessAlert(result.message), 100);

					$("#txcCd").prop("readonly",true);
					$("#txcNm").prop("readonly",true);
					$("#txcPrice").prop("readonly",true);
					$("#checkBtn").prop("disabled",true);
					$("#drugSearch").prop("readonly",true);

					$("#deleteMode").css("display","block");
					$("#insertMode").css("display","none");
					$("#resetMode").css("display","block");
					$("#updateBtnMode").css("display","block");
					$("#updateMode").css("display","none");
					$(".cancel").css("display","none");

					
					$("#coment").text('');
		 			$("#drugList").empty();
		 			$("#drugSearch").val("");

		 			$(".cancel").css("display","none");


		        }
	   		});

		});

		//삭제하기 버튼 클릭시 삭제되기
		$("#txDeleteBtn").on("click",function(){

			Swal.fire({
				  title : '진료 처치 삭제 중',
			      text: '정말 삭제하시겠습니까?',
			      showDenyButton: true,
			      confirmButtonText: '예',
			      denyButtonText: '아니요',
			   }).then((result) => {
				   if(result.isConfirmed){
					   
					let txcCd = $("#txcCd").val();
		
					let data ={"txcCd":txcCd}
		
					$.ajax({
				        url:"/hospital/txCode/deletePost",
				        contentType:"application/json;charset:utf-8",
				        data:JSON.stringify(data),
				        type:"post",
				        dataType:"json",
				        beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				        },
				        success:function(result) {
				            console.log("result : " + JSON.stringify(result));
				            let vo = result.txCodeVO;
		
				            //alert 띄우기
					    	simpleSuccessAlert(result.message);
		
				          	console.log(vo.txcCd);
		
				          	$("#"+vo.txcCd).remove();
		
		
				            $("#txcCd").prop("readonly",false);
						    $("#txcNm").prop("readonly",false);
						    $("#txcPrice").prop("readonly",false);
						    $("#checkBtn").prop("disabled",false);
		
				            $("#coment").val("");
				            $("#txcCd").val("");
				            $("#txcNm").val("");
				            $("#txcPrice").val("");
		
				            $("#drugSelectList").empty();
		
				            $("#insertMode").css("display","block");
						    $("#updateBtnMode").css("display","none");
						    $("#resetMode").css("display","block");
						    $("#updateMode").css("display","none");
						    $("#deleteMode").css("display","none");
		
		
				        }
					});
				   }
				   

				
			});




		});

		//확인 버튼 클릭시 수정되기
		$("#okBtn").on("click",function(){
			let txcCd = $("#txcCd").val();
			let txcNm = $("#txcNm").val();
			let price = $("#txcPrice").val();
			console.log("price : " + price);
			console.log("price.length : " + price.length);

			let txcPrice = uncomma(price);
			console.log("uncomma(txcPrice) : " + price);
// 			price = parseInt(price);
// 			console.log("parseInt(price) : " + price);


			<!-- insertMode, resetMode, updateBtnMode, updateMode, deleteMode -->
			$("#updateMode").css("display","none");
			$("#insertMode").css("display","block");
			$("#resetMode").css("display","none");
			$("#updateBtnMode").css("display","block");
			$("#deleteMode").css("display","none");

			if(jQuery.trim(txcNm)==""){
			    	simpleErrorAlert("수정할 치료명을 작성해주세요");
		            $("#txcNm").focus();
		            return false;
			    }

	   		if(jQuery.trim(txcPrice)==""){
	   			simpleErrorAlert("수정할 가격 작성해주세요");
	            $("#txcPrice").focus();
	            return false;
		    }

	   		let selectTrs = $("#drugSelectList").children();

	   		let dataDrugNum = "";

	   		$.each(selectTrs,function(index,data){
				//data-drug-num="197500185"
				let drugNum = $(this).data("drugNum");
				if(index>0){
					dataDrugNum += ",";
				}
				dataDrugNum += drugNum;
	   		});

	   		console.log("dataDrugNum : " + dataDrugNum);

			//data : TxCodeVO
			//data.TxDrugList
			let data = {'txcCd':txcCd,
				   'txcNm':txcNm,
   				   'txcPrice':txcPrice,
   				   'dataDrugNum':dataDrugNum
   			};

	   		console.log("data : " + JSON.stringify(data));

	   		$.ajax({
		        url:"/hospital/txCode/updatePost",
		        contentType:"application/json;charset:utf-8",
		        data:JSON.stringify(data),
		        type:"post",
		        dataType:"json",
		        beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
		        success:function(result) {
		            console.log("result : " + JSON.stringify(result));
		            let vo = result.txCodeVO;

	// 		        alert 띄우기
				    simpleSuccessAlert(result.message);

			        console.log(vo);

			        $("#txcCd").prop("readonly",true);
					$("#txcNm").prop("readonly",true);
					$("#txcPrice").prop("readonly",true);
					$("#checkBtn").prop("disabled",true);
					$("#drugSearch").prop("readonly",true);

					$("#coment").text('');
			        $("#txcCd").val(vo.txcCd);
			        $("#txcNm").val(vo.txcNm);
			        $("#txcPrice").val(comma(vo.txcPrice));
			        $("#drugSearch").val("");

			        $("#updateMode").css("display","none");
					$("#deleteMode").css("display","block");
					$("#insertMode").css("display","none");
					$("#resetMode").css("display","block");
					$("#updateBtnMode").css("display","block");
					$(".cancel").css("display","none");
					$("#drugList").empty();

					//진료 처치 테이블의 정보 변경
	  				let td = $("#"+txcCd).children();
	  				td.eq(1).html(vo.txcNm);
	  				td.eq(2).html(comma(vo.txcPrice));
		        }
			});

			$("#updateMode").css("display","block");
			$("#insertMode").css("display","none");
			$("#resetMode").css("display","none");
			$("#updateBtnMode").css("display","none");
			$("#deleteMode").css("display","none");

		});

		//취소 버튼 클릭시 이전 모드로 전환하기
		$("#cancleBtn").on("click", function(){
			<!-- insertMode, resetMode, updateBtnMode, updateMode, deleteMode -->

// 			let txcCd = $("#txcCd").val("");
// 			let txcNm = $("#txcNm").val("");
// 			let txcPrice = $("#txcPrice").val("");
			$("#checkBtn").prop("disabled",false);
			$("#txcCd").prop("readonly",false);


			$("#updateMode").css("display","none");
			$("#insertMode").css("display","none");
			$("#resetMode").css("display","block");
			$("#updateBtnMode").css("display","block");
			$("#deleteMode").css("display","block");
			$(".cancel").css("display","none");
			$("#coment").text('');

			$("#txcCd").prop("readonly",true);
			$("#txcNm").prop("readonly",true);
			$("#txcPrice").prop("readonly",true);
			$("#checkBtn").prop("disabled",true);
			$("#drugSearch").prop("readonly",true);

		});


// 		중복 검사하기 버튼 클릭 시 중복 검사하기
		$("#checkBtn").on("click", function(){

			if($("#txcCd").val()==null||$("#txcCd").val()==""){
				setTimeout(() => simpleErrorAlert('처치 코드를 입력해주세요.'), 100);
				$("#txcCd").focus();
				return;
			}

			let txcCd = $("#txcCd").val();
			console.log("txcCd : " + txcCd);

			$.ajax({
				url:"/hospital/txCode/doubleCheck?txcCd="+txcCd,
				contentType : "application/json;charset=utf-8",
				type:"get",
				dataType : "json",
				success:function(result){
					console.log("result : ", JSON.stringify(result));
					console.log("result.message : "+result.message);
					let message = result.message;
					$("#coment").html(message);
					if(message=="*코드를 사용할 수 있습니다."){
						$("#txcCd").prop("readonly",true);
						$("#txInsertBtn").prop("disabled",false);
						$("#drugSearch").prop("readonly",false);
						$("#coment").css("color","green");
					}else{
						$("#coment").css("color","red");
						
					}
					

				}
			});
		});

		$("#plusBtn").on("click", function(){

			console.log("버튼 클릭했어요");
			let str="";
			str += "<tr class='drugListTr' style='height:50px;'>";
			str += "		<td></td>";
			str += "		<td></td>";
			str += "		<td></td>";
			str += "		<td></td>";
			str += "</tr>";
			$("#drugSelectList").append(str);

			});


		//약품 검색 기능
		$("#drugSearch").keyup(function(e){

			let checkReadonly = $("#drugSearch").attr("readonly");
			console.log("checkReadonly : " + checkReadonly);

			if(checkReadonly=="readonly"){
				return;
			}

			let keyword = $("#drugSearch").val();
			console.log(keyword);

			$.ajax({
				url : "/hospital/drug/showMd?keyword=" + keyword,
				type : "get",
				dataType : "json",
				success : function(result) {
					//console.log("result : " + JSON.stringify(result));

					let str = "";

					$.each(result, function(index, drugVO) {

						str += "<tr class='selectDrug' data-drug-num='"+drugVO.drugNum+"'>";
						str += "<td>" + drugVO.drugNm + "</td>";
						str += "<td>" + drugVO.drugType + "</td>";
						str += "<td>" + drugVO.drugIngre + "</td>";
						str += "<td>" + drugVO.drugComp + "</td>";
						str += "</tr>";
					});

					//console.log("str : " + str);
					$("#drugList").html(str);

				}
			});

		});

		//선택한 tr 가져오기
		$(document).on("click",".selectDrug",function(){
			let drugNum = $(this).data("drugNum");
// 			200202208
			console.log(drugNum);


			//drugNum 으로 한 VO 가져오기
			$.ajax({
				url:"/hospital/txCode/drugDetail?drugNum="+drugNum,
				type : "get",
	            dataType : "json",
	            success : function(result) {
	            	console.log("result : " + JSON.stringify(result));
	            	let str = "";

	            	//클릭한 약품 번호 data에 담아두기
	            	str += "<tr class='selectedDrug' data-drug-num='"+result.drugNum+"'>";
					str += "<td><input type='hidden' name='dataDrugNum' value='"+result.drugNum+"'>" + result.drugNm + "</td>";
					str += "<td>" + result.drugType + "<span class='cancel' >  X</sapn></td>";
					str += "<td>" + result.drugIngre + "</td>";
					str += "<td>" + result.drugComp + "</td>";
					str += "</tr>";

					let selectDrugArr = $("#drugSelectList").children();
					console.log("selectDrugArr : ", selectDrugArr);

					let count = 0;

					$.each(selectDrugArr,function(i,v){
						//이미 선택되어 테이블에 추가된 행
						console.log("selectDrugArr[",i,"] :", v);

						//이미 선택되어 테이블에 추가된 행의 data에서 약품 번호 추출하기
						console.log('v.data("drugNum") : ' + $(v).data("drug-num"));

						let selectedDrugNum = $(v).data("drug-num");


						if(result.drugNum==selectedDrugNum){
							console.log("같은 행 있다");
							count=count+1;
							return;
						}


					});

					if(count!=0){
						console.log("같은 행이 있어서 추가가 안된다.");
					}else{
			            $("#drugSelectList").append(str);
					};


	            }
			});



		});


		//X버튼 클릭 시 행 지워지기
		$(document).on("click",".cancel",function(){
			let tr =  $(this).parent().parent();
			console.log("tr : ", tr);
			tr.remove();
		});

		//처치코드 또는 치료명 검색하기
		$("#txKeyword").keyup(function(e){
			let keyword = $("#txKeyword").val();
			console.log("keyword : " + keyword);
			let data = {"keyword":keyword};

			$.ajax({
				url : "/hospital/txCode/keywordSearch",
// 				contentType : "application/json;charset:utf-8",
				data :data,
				type : "get",
// 				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
// 		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 		        },
				success:function(result){
					console.log("result : ", result);

					/*
					0:{txcCd: 'b123466666', txcNm: '충치치료2', txcPrice: 800000, dataDrugNum: null, drugNum: null, …}
					1:{txcCd: 'd12343333', txcNm: '충치치료2', txcPrice: 8999, dataDrugNum: null, drugNum: null, …}
					2:{txcCd: '333', txcNm: '충치치료2', txcPrice: 78, dataDrugNum: null, drugNum: null, …}
					*/

					let str ="";
					$.each(result,function(index, data){
						console.log("comma(data.txcPrice) : " + comma(data.txcPrice));
						str += '<tr class="txCodeListTr" data-txc-cd="'+data.txcCd+'" data-txc-price="'+data.txcPrice+'"  id="'+data.txcCd+'">';
						str += '	<td>'+data.txcCd+'</td>';
						str += '	<td>'+data.txcNm+'</td>';
						str += '	<td>'+comma(data.txcPrice)+'</td>';
						str += '</tr>';
					});

					$("#txCodeList").html(str);
				}
			});
		});

	});

	//콤마 붙이는 함수
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }

	//콤마를 떼는 함수
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    }

    //숫자를 받아와 콤마를 붙이는 함수
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    }

</script>

<div class="content-wrapper"
	style="background-color: rgb(101, 125, 150); min-height: 1033px;">

	<!-- main 검색창을 포함한 navbar 시작-->
	<nav class="navbar navbar-expand navbar-white navbar-light"
		style="background-color: #404b57;">

		<div class="dropdown" style="clear:both;">
			<!-------------------- 검색대 -------------------->
			<input type="text" class="form-control" id="txKeyword" name="txKeyword"
				placeholder="처치 코드 또는 처치명을 입력하세요." style="width: 400px;">

			<!-------------------- 검색대 -------------------->
		</div>
<!-- 		<img src="/resources/images/layout/memo_icon.png" alt="메모" id="memo" -->
<!-- 			class="brand-image elevation-1" style="margin-left: 15px;"> -->

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
					<a class="nav-link btn btn-outline-light active" href="/hospital/txCode">처치 관리</a>
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
			<div class="col-lg-5">
				<!-------------------- 목록 리스트 -------------------->
				<div class="card">
					<div class="card-header" style="background-color: #404b57;">
						<h3 class="card-title" style="color: white;">처치 목록</h3>
					</div>

					<div class="card-body table-responsive p-0"
						style="height: 850px; border-bottom: 20px; overflow-x: hidden;"
						id="tabCard">
						<div id="example2_wrapper"
							class="dataTables_wrapper dt-bootstrap4">
							<div class="row">
								<div class="col-sm-12">
									<table id="table table-hover text-nowrap"
										class="table table-bordered table-hover dataTable dtr-inline text-center"
										aria-describedby="example2_info" style="table-layout: fixed;">
										<thead class="tableHead text-center">
											<tr>
												<th style="width: 9%;">처치 코드</th>
												<th style="width: 17%;">치료명</th>
												<th style="width: 15%;">가격</th>
											</tr>
										</thead>
										<tbody id="txCodeList">
											<c:forEach var="txCodeVO" items="${txCodeList}" varStatus="index">
												<tr class="txCodeListTr" data-txc-cd="${txCodeVO.txcCd}" data-txc-price="${txCodeVO.txcPrice}" id="${txCodeVO.txcCd}">
													<td>${txCodeVO.txcCd}</td>
													<td>${txCodeVO.txcNm}</td>
													<td><fmt:formatNumber value="${txCodeVO.txcPrice}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-------------------- 목록 리스트 -------------------->
			</div>
			<div class="col-lg-7">
				<!-------------------- 상세내용  -------------------->
				<div class="card">
					<div class="card-header" style="background-color: #404b57;">
						<h3 class="card-title" style="color: white;">상세 정보</h3>
					</div>

					<div class="card-body table-responsive p-0"
						style="height: 850px; border-bottom: 20px; overflow-x: hidden;"
						id="tabCard">
						<div id="example2_wrapper"
							class="dataTables_wrapper dt-bootstrap4">
							<div class="row">
								<div class="col-sm-12">
									<div class="col-7" style="margin-left: 20%; margin-top: 5%;">
										<form id="codeFrm" action="/hospital/txCode/insertPost"
											method="post">
											<div class="form-group">

												<label for="inputName">처치 코드</label>
												<div class="row">
													<div class="col-8">
														<input type="text" id="txcCd" name="txcCd"
															class="form-control" value="${txCodeVO.txcCd}" placeholder="중복 검사를 해주세요"
															<c:if test="${txCodeVO.txcCd!=null}" >readonly</c:if> />
													</div>
													<div class="col-4">
														<button type="button" class="btn btn-info btnCss violetBtn"
															style="background-color: #904aff; border: #904aff; margin-right: 5px; float: right;"
															id="checkBtn">중복 검사하기</button>
													</div>

												</div>

												<div id="coment"></div>
														</div>
														<div class="form-group">
															<label for="inputEmail">치료명</label> <input type="text"
																id="txcNm" name="txcNm" class="form-control"
																value="${txCodeVO.txcNm}" />
														</div>
														<div class="form-group">
															<label for="inputSubject">가격</label> <input type="text"
																id="txcPrice" name="txcPrice" class="form-control"
																value="<fmt:formatNumber value='${txCodeVO.txcPrice}' />"
																maxlength="15" onkeyup="inputNumberFormat(this);" />
														</div>
														<div class="d-flex justify-content-end align-items-center">
															<!-- 등록 모드 시작 -->
															<span id="insertMode"> <input type="button"
																class="btn btn-info btnCss violetBtn"
																style="background-color: #904aff; border: #904aff; margin-right: 5px;"
																id="txInsertBtn" value="등록하기" disabled />
															</span>
															<!-- 등록 모드 끝 -->
															<!-- 수정 버튼 모드 시작 -->
															<span id="updateBtnMode" style="display: none;"> <input
																type="button" class="btn btn-info btnCss violetBtn"
																style="background-color: #904aff; border: #904aff; margin-right: 5px;"
																id="txUpdateBtn" value="수정하기" />
															</span>
															<!-- 수정 버튼 모드 끝 -->
															<!-- 지우기 모드 시작 -->
															<span id="resetMode"> <input type="button"
																class="btn btn-warning btnCss redBtn"
																style="color: white; border: none; background-color: #ff3e3e;"
																id="txResetBtn" value="비우기">
															</span>
															<!-- 지우기 모드 끝 -->
															<!-- 수정모드 시작 -->
															<span id="updateMode" style="display: none;"> <input
																type="button" class="btn btn-info btnCss"
																style="background-color: #904aff; border: #904aff; margin-right: 5px;"
																id="okBtn" value="확인" /> <input type="button"
																class="btn btn-warning btnCss"
																style="color: white; border: none; background-color: #ff3e3e;"
																id="cancleBtn" value="취소">

															</span>
															<!-- 수정모드 끝 -->
															<!-- 삭제모드 시작 -->
															<span id="deleteMode" style="display: none;"> <input
																type="button" class="btn btn-warning btnCss redBtn"
																style="color: white; border: none; background-color: #ff3e3e; margin-left: 10px;"
																id="txDeleteBtn" value="삭제하기">
															</span>
															<!-- 삭제모드 끝 -->

														</div>
														<sec:csrfInput /></form>

									</div>
								</div>

							</div>

							<div class="row">
								<div class="col-sm-12">
									<div class="col-7" style="margin-left: 21%; margin-top: 5%;">

										<!-- 검색대 -->
										<div class="row">
												<input type="text" class="form-control" id="drugSearch"
													placeholder="약품 검색">
										</div>
										<!-- 검색대 -->

									</div>
									<div class="row" style="margin-top: 10px;">
										<div class="col-sm-12" id="drugDiv">
											<div class="col-sm-12">
												<!-- 검색 내용 -->
												<div id="tabCard"
													style="width: 50%; height: 390px; overflow: auto; float: left;">
													<table id="table table-hover text-nowrap"
														class="table table-bordered dataTable dtr-inline"
														aria-describedby="example2_info"
														style="table-layout: fixed;">
														<thead class="tableHead text-center">
															<tr>
																<th style="width: 15%;">이름</th>
																<th style="width: 15%;">종류</th>
																<th style="width: 15%;">주성분</th>
																<th style="width: 15%;">제조사</th>
															</tr>
														</thead>
														<tbody id="drugList" style="font-size: 12px;">


														</tbody>
													</table>
												</div>
												<!-- 검색 내용 -->
												<!-- 선택 내용 -->
												<div id="tabCard"
													style="width: 50%; height: 390px; overflow: auto; float: right; padding-left:5px;">
													<table id="selectedDrugTable"
														class="table table-bordered dataTable dtr-inline"
														aria-describedby="example2_info"
														style="table-layout: fixed;">
														<thead class="tableHead text-center">
															<tr>
																<th style="width: 15%;">이름</th>
																<th style="width: 15%;">종류</th>
																<th style="width: 15%;">주성분</th>
																<th style="width: 15%;">제조사</th>
															</tr>
														</thead>
														<tbody id="drugSelectList" style="font-size: 12px;">


														</tbody>
													</table>
												</div>
												<!-- 선택 내용 -->
											</div>
										</div>
									</div>
								</div>


							</div>
						</div>
					</div>
				</div>
				<!-------------------- 상세 내용 -------------------->
			</div>
		</div>


	</section>
</div>

<script src="/resources/js/alertModule.js"></script>
