<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
/* font */
h3, h4{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight : 700;
}

h5{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight : 700;
    line-height:32px;
}

h6{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight : 500;
    font-size:14px;
    margin-left:50px;
}
/* scroll css */
.resvList::-webkit-scrollbar {
    display: none;
}

/* button css */
.receiptPrintBtn{
    background-color: #904aff;
    border:none;
    border-radius:30px;
    font-family: 'Noto Sans KR', sans-serif;
    font-weight: 700;
}
#searchBtn{
    font-family: 'Noto Sans KR', sans-serif;
    font-weight:700;
    background-color: #9d59f0;
    border:none;
    margin-left:10px;
}
.receiptTr{
	cursor: pointer;
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
}
</style>
<!-- Head Image 시작 -->
<div class="boardHeadImage">
	<div class="wrapper">
		<div class="slide">
			<img src="/resources/images/layout/ddit/receiptHeadImg.png" />
		</div>
	</div>
</div>
<!-- Head Image 끝 -->
<!-- main section 시작 -->
<section class="container">
	<!-- 결제내역 조회 nav 시작 -->
	<div class="row" style="margin-left: 7%; margin-top: 50px; width: 85%; height: 100px; border-top: 1px solid gray; border-bottom: 1px solid gray;">
		<div class="col-12">
			<h4 style="margin-left: 50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">결제내역 조회</h4>
		</div>
		<div class="col-6">
			<h6 style="opacity: 0.5;">home > 예약 / 조회 > 결제내역 조회</h6>
		</div>
	</div>
	<div class="row" style="margin-left: 7%; margin-top: 20px; width: 85%;">
		<div class="col-sm-5"></div>
		<div class="col-sm-7" style="text-align: right;">
			<label class="col-form-label" for="startDate">시작일</label>
			<input type="date" id="rctSdt" />
			<span> ~ </span>
			<label class="col-form-label" for="LastDate">종료일</label>
			<input type="date" id="rctEdt" />
			<input type="button" class="col-sm-3 btn btn-primary violetBtn" value="검색" style="width: 20%;" onclick="searchReceipt();" />
		</div>
	</div>
	<hr style="margin-left: 7%; width: 85%;" />
	<!-- 결제내역 조회 nav 끝 -->
	<div style="margin-left: 7%; margin-top: 30px; margin-bottom: 30px;">
		<!-- 수납목록 확인, 왼쪽 칸 시작 -->
		<div class="row g-0" style="margin-left: 20px;">
			<h4 style="margin-bottom: 30px;">'<sec:authentication property="principal.ptVO.ptNm" />'님의 결제내역입니다.</h4>
			<div class="col-md-5 resvList" style="border: 1px solid rgb(211, 211, 211); box-shadow: 7px 7px 16px 0px rgba(130, 130, 130, 0.72); border-radius: 20px; height: 600px; overflow-y: scroll; margin-right: 50px;">
				<div>
					<table class="table table-hover text-center">
						<thead>
							<tr class="stickyTr">
								<th class="p-3" style="width: 20%;">순번</th>
								<th class="p-3" style="width: 40%;">수납일자</th>
								<th class="p-3" style="width: 40%;">수납금액</th>
							</tr>
						</thead>
						<tbody id="rctListBody">
							<c:forEach var="rct" items="${rctList}" varStatus="idx">
								<tr class="receiptTr" data-rctnum="${rct.rctNum}">
									<td>${idx.count}</td>
									<td>${rct.rctIssueDtStr}</td>
									<td><fmt:formatNumber value="${rct.rctAmt}" pattern="###,###,###,###" />원</td>
								</tr>
							</c:forEach>
							<!--
							<tr class="selectTr">
								<td class="p-3">1</td>
								<td class="p-3">2023-03-10</td>
								<td class="p-3">1,215,300</td>
							</tr>
							 -->
						</tbody>
					</table>
				</div>
			</div>
			<!-- 결제목록 확인, 왼쪽 칸 끝 -->
			<!-- 결제정보 확인, 오른쪽 칸 시작 -->
			<!-- 결제정보 선택 전 빈 카드 시작 -->
			<div id="emptyCard" class="col-md-5 d-flex justify-content-center align-items-center" style="border: 1px solid rgb(211, 211, 211); height: 600px; padding: 30px; border-radius: 30px; box-shadow: 7px 7px 16px 0px rgba(130, 130, 130, 0.72);">
				<h5 class="m-0">확인하실 결제 건을 선택해주세요.</h5>
			</div>
			<!-- 결제정보 선택 전 빈 카드 끝 -->
			<!-- 결제정보 선택 후 카드 시작 -->
			<div id="receiptCard" class="col-md-5 d-none" style="border: 1px solid rgb(211, 211, 211); height: 600px; padding: 26px; border-radius: 30px; box-shadow: 7px 7px 16px 0px rgba(130, 130, 130, 0.72);">
				<h4 class="text-end">
					'<span id="ptNm"></span>'님의 <span id="rctIssueDtShort"></span>일자<br /> <span id="rctType"></span>영수증 입니다.
				</h4>
				<table cellpadding="0px" cellspacing="0" width="100%" border="0" style="margin-top: 20px; font-size: 17px; line-height: 22px; table-layout: auto; width: 100%; border: none;">
					<tbody>
						<tr>
							<td style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 16px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">구분</td>
							<td style="text-align: center; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rcvmtType"></span></strong></td>
							<td style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 32px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">결제회차</td>
							<td style="text-align: center; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rcvmtRctSn"></span></strong> 회차</td>
						</tr>
						<tr></tr>
						<tr>
							<td colspan="2" style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 32px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">결제금액</td>
							<td colspan="2" style="text-align: right; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rctAmt"></span>원</strong></td>
						</tr>
						<tr></tr>
						<tr>
							<td colspan="2" style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 32px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">결제방식</td>
							<td colspan="2" style="text-align: right; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rctPayOpt"></span></strong></td>
						</tr>
						<tr></tr>
						<tr>
							<td colspan="2" style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 32px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">결제일시</td>
							<td colspan="2" style="text-align: right; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rctIssueDtStr"></span></strong></td>
						</tr>
						<tr></tr>
						<tr>
							<td colspan="2" style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 32px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">승인번호</td>
							<td colspan="2" style="text-align: right; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rctAcceptNum"></span></strong></td>
						</tr>
						<tr></tr>
						<tr>
							<td colspan="2" style="font-weight: normal; text-align: left; white-space: nowrap; padding: 18px 32px 18px 0; vertical-align: top; border-bottom: 1px solid rgba(0, 27, 55, 0.1)">카드사</td>
							<td colspan="2" style="text-align: right; padding: 18px 0; border-bottom: 1px solid rgba(0, 27, 55, 0.1)"><strong><span id="rctCardComp"></span></strong></td>
						</tr>
						<tr></tr>
					</tbody>
				</table>
				<div class="mt-3 d-flex justify-content-end align-items-center">
					<h3 class="m-0"><span id="hiNm"></span></h3>
					<img src="/resources/images/stamp/stamp.png" alt="병원 직인" class="ms-3" style="max-width: 50px; max-height: 50px;" />
				</div>
				<button class="btn btn-primary violetBtn receiptPrintBtn mt-2" type="button" id="rctBtn" data-rctnum="" onclick="rctIssue(this);">영수증 출력</button>
			</div>
			<!-- 결제정보 선택 후 카드 시작 -->
			<!-- 결제정보 확인, 오른쪽 칸 끝 -->
		</div>
	</div>
</section>
<!-- main section 끝 -->
<script>

function rctIssue(e){  
	if(confirm('영수증을 확인하시겠습니까?')){
		console.log(e);
		var rctNum = e.dataset.rctnum;
		patientRctWindow(rctNum);
	};
};


// 검색 기간의 최댓값을 오늘로 지정
let offset = new Date().getTimezoneOffset() * 60000;
let today = new Date(new Date().getTime() - offset).toISOString().split('T')[0];

$('#rctSdt').attr('max', today);
$('#rctEdt').attr('max', today);

// 검색 시작날짜 변경 시 종료날짜 min, max값 조절
$('#rctSdt').on('change', function(){
	if($('#rctSdt').val() > $('#rctEdt').val()){
		$('#rctEdt').val($('#rctSdt').val());
	}
	$('#rctEdt').attr('min', $(this).val());
});

// 결제이력 목록 클릭 시 결제 상세정보를 우측 카드에 출력
$(document).on('click', '.receiptTr', function(){
	const rctNum = $(this).data('rctnum');
	fetch('/ddit/receipt/selectReceipt?rctNum=' + rctNum)
		.then(res => {
			if(!res.ok) throw new Error();
			return res.json();
		})
		.then(rct => {
			$('#rctBtn').attr("data-rctNum",rct.rctNum);
			
			$('#ptNm').text(rct.ptNm);
			const rctIssueDtStr = rct.rctIssueDtStr;
			$('#rctIssueDtShort').text(rctIssueDtStr.split(' ')[0]);
			const rctPayOpt = rct.rctPayOpt;
			if(rctPayOpt != '현금' && rctPayOpt != '카드'){
				$('#rctType').text(rctPayOpt);
			} else {
				$('#rctType').text('결제');
			}

			$('#rcvmtType').text(rct.rcvmtType);
			let rcvmtRctSn = rct.rcvmtRctSn;
			if(rcvmtRctSn > 0){
				$('#rcvmtRctSn').text(rct.rcvmtRctSn);
			} else {
				$('#rcvmtRctSn').text('-');
			}
			$('#rctAmt').text(rct.rctAmt.toLocaleString());

			$('#rctPayOpt').text(rctPayOpt);
			$('#rctIssueDtStr').text(rctIssueDtStr);
			$('#rctAcceptNum').text(rct.rctAcceptNum);
			$('#rctCardComp').text(rct.rctCardComp);
			$('#hiNm').text(rct.hiNm);


			$('#emptyCard').addClass('d-none');
			$('#receiptCard').removeClass('d-none');
		})
		.catch(() => {
			alert('잠시 후 다시 시도해주세요.')
		})
});

// 선택된 날짜로 결제이력 검색
function searchReceipt(){

	const rctSdt = $('#rctSdt').val();
	const rctEdt = $('#rctEdt').val();
	let paramData = {
		rctSdt: rctSdt,
		rctEdt: rctEdt
	};

	let paramString = Object.entries(paramData).map(e => e.join('=')).join('&');
	fetch('/ddit/receipt/searchReceipt?' + paramString)
		.then(res => {
			if(!res.ok) throw new Error();
			return res.json();
		})
		.then(rctList => {

			let code = '';
			rctList.forEach(function(rct, idx){
				code += '<tr class="receiptTr" data-rctnum="' + rct.rctNum + '">';
				code += '<td>' + (idx + 1) + '</td>';
				code += '<td>' + rct.rctIssueDtStr + '</td>';
				code += '<td>' + rct.rctAmt.toLocaleString() + '원</td>';
				code += '</tr>';
			});

			$('#rctListBody').html(code);
		});

}
</script>

<script src="/resources/js/receiptIssue.js"></script>