let today = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split('T')[0];
let beforeSevenDays = new Date(today);
beforeSevenDays.setDate(beforeSevenDays.getDate() - 7);
beforeSevenDays = beforeSevenDays.toISOString().split('T')[0];

document.querySelector('#chartEDate').value = today;
document.querySelector('#chartSDate').value = beforeSevenDays;
document.querySelector('#chartEDate').min = beforeSevenDays;
document.querySelector('#chartSDate').max = today;
document.querySelector('#chartEDate').max = today;


// 차트 목록
const chartListBody = document.querySelector('#chartListBody');
// 영상이미지 목록
const mediaList = document.querySelector('#mediaList')
// 영상이미지 모달
const mediaModal = document.querySelector('#mediaModal');
// 영상이미지 모달의 이미지 태그
const mediaModalImg = mediaModal.querySelector('#mediaModalImg');
// 영상이미지 모달의 헤더에 표시되는 환자명(환자번호)
const mediaModalPtNum = document.querySelector('#mediaModalPtNum');
// 영상이미지 모달의 헤더에 표시되는 영상이미지 촬영일
const mediaModalmedDtStr = document.querySelector('#mediaModalmedDtStr');

// 시작날짜를 변경하면 조건에 맞추어 종료날짜가 변경됨
$('#chartSDate').on('change', function(e){
	const chartSDate = $('#chartSDate');
	const chartEDate = $('#chartEDate');

	if(chartSDate.val() > chartEDate.val()){
		chartEDate.val(chartSDate.val());
	}
	chartEDate.attr('min', chartSDate.val());
});

// 환자 검색란에서 엔터 클릭 시 검색 수행
$('#ptSearch').on('keydown', function(e){
	if(e.keyCode == 13){
		document.querySelector('#ptSearchBtn').click();
	}
});

// 환자 검색
function searchPt(){

	const keyword = document.querySelector('#ptSearch').value;

	fetch('/hospital/checkup/searchPt?keyword=' + keyword)
		.then(res => res.json())
		.then(ptList => {

			let code = '';

			if(ptList.length == 0){
				code += '<tr>';
				code += '<td colspan="2">일치하는 환자가 존재하지 않습니다.</td>';
				code += '</tr>';
			}else{
				ptList.forEach(function(pt){
					code += '<tr class="ptRow">';
					code += '<td>' + pt.ptNum + '</td>';
					code += '<td>' + pt.ptNm + '</td>';
					code += '</tr>';
				});
			}

			document.querySelector('#patientListBody').innerHTML = code;
		});

}

// 환자 목록에서 환자를 선택할 경우 해당 환자의 진료 차트 조회
$(document).on('click', '.ptRow', function(e){

	const ptNum = $(this).children()[0].textContent;
	const ptNm = $(this).children()[1].textContent;
	$('#ptNum').val(ptNum);
	$('#selectedPt').text(ptNm + '(' + ptNum + ')');
	$('#listChartBtn').click();

});

// 진료 차트 조회
function listChart(){

	const ptNum = document.querySelector('#ptNum').value;
	if(ptNum == ''){
		simpleErrorAlert('환자를 선택해주세요.');
		return false;
	}

	const chartSDate = document.querySelector('#chartSDate').value;
	const chartEDate = document.querySelector('#chartEDate').value;

	const parameterData = {
			ptNum : ptNum,
			chartSDate : chartSDate,
			chartEDate : chartEDate
	}

	const parameterString = Object.entries(parameterData).map(e => e.join('=')).join('&');

	fetch('/hospital/checkup/listChart?' + parameterString)
		.then(res => res.json())
		.then(chartList => {

			let code = '';
			let thumb = '';

			if(chartList.length == 0){
				code += '<tr>';
				code += '<td colspan="4">진료기록이 존재하지 않습니다.</td>';
				code += '</tr>';
			} else {

				chartList.forEach(function(chart){

					// 다음 치료 계획 출력
					chart.txnList.forEach(function(txn){

						if(txn.txnSn == 0) return false;

						code += '<tr class="chartRow" data-chknum="' + txn.chkNum + '" data-sn="' + txn.txnSn + '">';
						code += '<td>' + txn.chkDtStr + '</td>';
						code += '<td>TX NEXT</td>';
						code += '<td class="text-left">';
						code += txn.txnToothNum.split(', ').map(num => '#<u class="teethNum">' + num + '</u>').join(', ');
						code += '<br />- ' + txn.txcNm;
						if(txn.txnContent != null){
							code += '<hr class="mx-0 my-2" />';
							code += txn.txnContent;
						}
						code += '</td>';
						code += '<td>' + txn.empNm + '</td>';
						code += '</tr>';
					});

					// 처치 출력
					chart.txList.forEach(function(tx){

						if(tx.txSn == 0) return false;

						code += '<tr class="chartRow" data-chknum="' + tx.chkNum + '" data-sn="' + tx.txSn + '">';
						code += '<td>' + tx.chkDtStr + '</td>';
						code += '<td>TX</td>';
						code += '<td class="text-left">';
						code += tx.txToothNum.split(', ').map(num => '#<u class="teethNum">' + num + '</u>').join(', ');
						code += '<br />- ' + tx.txcNm;
						if(tx.txContent != null){
							code += '<hr class="mx-0 my-2" />';
							code += tx.txContent;
						}
						code += '</td>';
						code += '<td>' + tx.empNm + '</td>';
						code += '</tr>';
					});

					// 치료 계획 출력
					chart.txpList.forEach(function(txp){

						if(txp.txpSn == 0) return false;

						code += '<tr class="chartRow" data-chknum="' + txp.chkNum + '" data-sn="' + txp.txpSn + '">';
						code += '<td>' + txp.chkDtStr + '</td>';
						code += '<td>TX PLAN</td>';
						code += '<td class="text-left">';
						code += txp.txpToothNum.split(', ').map(num => '#<u class="teethNum">' + num + '</u>').join(', ');
						code += '<br />- ' + txp.txcNm;
						if(txp.txpContent != null){
							code += '<hr class="mx-0 my-2" />';
							code += txp.txpContent;
						}
						code += '</td>';
						code += '<td>' + txp.empNm + '</td>';
						code += '</tr>';
					});

					// 증상 출력
					chart.piList.forEach(function(pi){

						if(pi.piSn == 0) return false;

						code += '<tr class="chartRow" data-chknum="' + pi.chkNum + '" data-sn="' + pi.piSn + '">';
						code += '<td>' + pi.chkDtStr + '</td>';
						code += '<td>PI</td>';
						code += '<td class="text-left">';
						code += pi.piToothNum.split(', ').map(num => '#<u class="teethNum">' + num + '</u>').join(', ');
						code += '<br />- ' + pi.disKorNm;
						if(pi.piContent != null){
							code += '<hr class="mx-0 my-2" />';
							code += pi.piContent;
						}
						code += '</td>';
						code += '<td>' + pi.empNm + '</td>';
						code += '</tr>';
					});

					// 영상이미지 출력
					chart.medList.forEach(function(med){
						if(med.medNum == null) return false;

						thumb += '<div class="mx-1 my-2 text-center">';
						thumb += '<p class="m-0">' + med.medDtStr + '</p>';
						thumb += '<div class="d-flex justify-content-center align-items-center bg-black mediaImgBox" style="width: 100px; height: 100px;">';
						thumb += '<img src="/resources/upload' + med.medThumbPath + '" alt="영상이미지" data-mednum="' + med.medNum + '" style="max-height: 100%; max-width: 100%;" />';
						thumb += '</div>';
						thumb += '</div>';

					});
				});

			}

			chartListBody.innerHTML = code;
			if(thumb == '') thumb += '<p class="my-3">등록된 영상이 존재하지 않습니다.</p>';
			mediaList.innerHTML = thumb;
		});
}

//영상 목록에서 썸네일 클릭 시 영상이미지 상세정보를 가져오고 모달에 원본 이미지를 출력
$(document).on('click', '.mediaImgBox', function(e){
	e.stopPropagation();

	const medNum = $(this).children()[0].dataset.mednum;

	$.ajax({
		url: '/hospital/checkup/selectMedia?medNum=' + medNum,
		type: 'get',
		dataType: 'json',
		success: function(res){
			mediaModalPtNum.textContent = res.ptNm + '(' + res.ptNum + ')';
			mediaModalmedDtStr.textContent = res.medDtStr;
			mediaModalImg.src = '/resources/upload' + res.medSavePath;
			mediaModalImg.dataset.mednum = res.medNum;
			$(mediaModal).modal('show');
		},
		error: function(){
			simpleJustErrorAlert();
		}
	})

});

// 영상이미지 모달에서 이미지 다운로드
async function downloadImg(){

	const imgSrc = mediaModalImg.src;
	const response = await fetch(imgSrc);

	const fileName = imgSrc.substring(imgSrc.lastIndexOf('/') + 1).trim();
	const blobData = await response.blob();

	const objectUrl = URL.createObjectURL(blobData);

	const downloadTag = document.createElement('a');
	downloadTag.href = objectUrl;
	downloadTag.download = fileName;
	document.body.appendChild(downloadTag);
	downloadTag.click();
	downloadTag.remove();

	URL.revokeObjectURL(objectUrl);

}