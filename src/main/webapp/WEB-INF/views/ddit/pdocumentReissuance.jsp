<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap 5 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jquery 3.6.0 -->
<script src="C:/Users/PC-23/Desktop/SPRING/lib/jquery-3.6.0.js"></script>

<!-- icon setting = font awesome -->
<script src="https://kit.fontawesome.com/5f4aa574e8.js" crossorigin="anonymous"></script>

<!-- google font + 500/700 -->
<!-- 사용시 font-weight : 500 or 700으로 줄것 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">


<!-- Swiper Demo Css, JS setting -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

<!-- favicon -->
<link rel="icon" type="image/png" sizes="16x16" href="C:/Users/PC-23/Desktop/images/logo/favicon.ico/favicon-16x16.png">

<!-- 결제 API -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<title>서류 재발급 결제</title>

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
/* Button css */
    .resvBtn{
        background-color: #904aff;
        border:none;
        border-radius:30px;
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
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 700;
    }

/* Modal content Css */
    .modal-body{
        overflow-x: hidden;
    }

    .disabledDocCard{
        transition:all 0.3s;
        position:relative;
        padding-bottom:30px;
    }

    .disabledChooseDoc{
        width: 12rem; 
        text-align: center; 
        padding-top: 20px;
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 700;
        background-color: #aaaaaa;
    }

    .docCard{
        transition:all 0.3s;
        position:relative;
        cursor:pointer;
        padding-bottom:30px;
    }

    .docCard:hover{
        transform: scale(1.05);
    }

    .chooseDoc{
        width: 12rem; 
        text-align: center; 
        padding-top: 20px;
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 700;
    }

    .choiceDoc{
        width: 12rem; 
        text-align: center; 
        padding-top: 20px;
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 700;
        margin-bottom:20px; 
        display:none;
    }

    .chooseDoc p{
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 500;
    }

    .chooseDocBtn{
        background-color: #904aff;
        border:none;
        font-family: 'Noto Sans KR', sans-serif;
        font-weight: 500;
    }

    .card-img-top{
        border-radius:100px; 
        width:150px; 
        height:150px; 
        margin:auto;
        border:1px solid #e2e2e2;
    }

/* scroll css */
    .modal-body::-webkit-scrollbar{
	    width: 10px;
	    height: 10px;
    }
    .modal-body::-webkit-scrollbar-thumb{
        background-color: #404b57;
        border-radius: 5px;
    }
    .modal-body::-webkit-scrollbar-track{
        background-color: rgba(0,0,0,0);
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
</style>
<script>

$(function(){
	
	$("#creditCard").on("click",function(){
		
		let docIssuePrice=$("#ptRrno2").val(); //발급가격
		let docIssueNmtm=$("#ptRrno1").val(); //발급통수
		let docIssueNum=$("#docIssueNum").val(); //발급 번호
		let resvCC=$("#resvCC").val(); //발급이유
		let ptNum=$("#ptNum").val(); //환자 번호
		let mix=docIssuePrice*docIssueNmtm;

		if(docIssueNmtm==null || docIssueNmtm == "" || resvCC ==null || resvCC == "") {
			simpleErrorAlert("필수 입력사항이 기재되지 않았습니다.");
			return false;
		};
		
		console.log(docIssuePrice);
		console.log(docIssueNmtm);
		console.log(docIssueNum);
		console.log(resvCC);
		
		var IMP = window.IMP;
		
		//가맹점 식별코드
		IMP.init('imp44461458');

		IMP.request_pay({
		    pg : 'html5_inicis', // 여러 가맹점 지정시 html5_inicis
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : 100, //판매 가격
		    buyer_email : 'iamport@test.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강서구 내발산동',
		    buyer_postcode : '123-456'
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        
		        var rctCardComp = rsp.card_name;
		        if(rctCardComp == null){
		        	rctCardComp = "카카오페이";
		        }
		        var rctCardNum = rsp.card_number;
		        var rctAcceptNum = rsp.apply_num;
		        
		        console.log("rsp>>>>>>>>>>>>",rsp);
		        
				let data = {
						docIssuePrice : docIssuePrice,
						docIssueNmtm : docIssueNmtm,
						resvCC: resvCC,
						docIssueNum:docIssueNum,
						ptNum:ptNum,
						rctCardComp : rctCardComp,
						rctCardNum : rctCardNum,
						rctAcceptNum : rctAcceptNum,
						rctAmt : docIssueNmtm,
						mix : mix
				}
				
				
				console.log("data>>>>>>>>>",data);
		        
				$.ajax({
					url: '/ddit/document/pdocUpdate',
					contentType:"application/json;charset:utf-8",
					data:JSON.stringify(data),
					type: 'post',
					dataType: 'json',
					beforeSend : function(xhr) { // 데이터 전송 전 헤더에 csrf값 설정
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result){
						if(confirm('결제가 완료되었습니다. 영수증을 확인하시겠습니까?')){
							console.log("result>>>>>>>>",result);
							var rctNum = result;
							patientRctWindow(rctNum);
							
							location.replace('/ddit/document/pdocumentLocker');
						}else {
							location.replace('/ddit/document/pdocumentLocker');
						}
					},
				});

		    } else {
		        var msg = '결제에 실패하였습니다.\n';
		        msg += rsp.error_msg;
		        alert(msg);
		        return false;
		    }
		});


	});
	
});

</script>

</head>
<body style="overflow-x: hidden;">
<!-- Head Image 시작 -->
<div class="boardHeadImage">
    <div class="wrapper">
        <div class="slide">
             <img src="/resources/images/layout/ptDocPageHeadImg.png">
        </div>
    </div>
</div>
<!-- Head Image 끝 -->
<!-- main section 시작 -->
<section class="container">
    <!-- 온라인예약 nav 시작 -->
    <div class="row" style="margin-left:7%; margin-top:50px; width:85%; height: 100px; border-top: 1px solid gray; border-bottom:1px solid gray;">
        <div class="col-12">
            <h4 style="margin-left:50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight:700;">서류 재발급 결제</h4>
        </div>
        <div class="col-6">
            <h6 style="opacity: 0.5;">home   >   재증명발급   >   발급내역 조회</h6>
        </div>
    </div>
    <!-- 온라인예약 nav 끝 -->
    <div style="margin-left:7%; margin-top:30px; margin-bottom:30px;">
        <h6 style=" margin-top:20px;"><span style="color:red;">*</span>결제내역은 가입하실때 입력했던 이메일에서 확인가능합니다.</h6>
        <h6 style=" margin-top:20px;"><span style="color:red;">*</span>무통장입금, 현금결제, 계좌이체는 온라인 발급시에는 불가능합니다.</h6>
        <h6 style=" margin-top:20px;"><span style="color:red;">*</span>결제명의자는 꼭 서류신청자 본인이 아니어도 결제가 가능합니다.</h6>
        <h6 style=" margin-top:20px;"><span style="color:red;">*</span>결제한 재증명서류는 출력만 가능하며, PDF파일로 저장을 원하신다면 내원하시어 데스크에 문의해주시기 바랍니다.</h6>
    </div>
    <hr style="margin-left:7%; width:85%;" />
    <div style="margin-left:7%; width:85%;">
        <form>
            <div class="row mb-3" style="padding-bottom:30px;">
                <div class="col-sm-2"></div>
                <label for="ptNm" class="col-sm-1 col-form-label">신청서류</label>
                <div class="col-sm-6">
                	<input type="hidden" value="${documentVO.docIssueNum}" id="docIssueNum" name="docIssueNum">
                	<input type="hidden" value="${documentVO.ptNum}" id="ptNum" name="ptNum">
                    <input type="text" class="form-control" id="ptNm" value="${documentVO.docName}" readonly>
                </div>
                <div class="col-sm-3"></div>
            </div>
            <div class="row mb-3" style="padding-bottom:30px;">
                <div class="col-sm-2"></div>
                <label for="ptRrno1" class="col-sm-1 col-form-label">발급통수</label>
                <div class="col-sm-2">
                    <input type="number" class="form-control" id="ptRrno1">
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row mb-3" style="padding-bottom:30px;">
                <div class="col-sm-2"></div>
                <label for="ptPhone1" class="col-sm-1 col-form-label">결재금액</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="ptRrno2" value="${documentVO.docIssuePrice}" readonly>
                </div>
            </div>

            <div class="row mb-3 certificationText" style="display:none; padding-bottom:30px;">
                <div class="col-sm-1"></div>
                <label for="certification" class="col-sm-2 col-form-label" style="padding-left:90px;"><span style="color:red;">*</span> 인증번호</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="certification" required>
                </div>
                <div class="col-sm-2">
                    <input type="button" value="인증번호 확인" class="btn btn-primary certChkBtn" />
                </div>
            </div>

            
            <div class="row mb-3" style="padding-bottom:30px;">
                <div class="col-sm-2"></div>
                <label for="resvCC" class="col-sm-1 col-form-label">발급사유</label>
                <div class="col-sm-6">
                    <textarea class="form-control" cols="70" rows="3" placeholder="발급사유를 간단히 기재해주세요 ex) 회사 제출용" id="resvCC"></textarea>
                </div>
            </div>
            <hr style="width:100%; margin-top:50px;"/>
            
            <button type="button" class="btn btn-primary btn-lg resvBtn" id="creditCard">신용카드 결제</button>
        </form>

    </div>
</section>

<!-- main section 끝 -->

</body>
</html>
<script src="/resources/js/receiptIssue.js"></script>