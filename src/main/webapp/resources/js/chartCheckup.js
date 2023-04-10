listRegist();
listResv();

// 접수 목록 드롭다운 메뉴 출력
$(document).on('click', '.regRow', function(e){

	if($(this).closest('.regRow').children()[3].textContent != '접수'){
		$('#regDropdownMenu')
			.addClass('d-none');

		document.querySelector('#ptSearch').value = '';
		document.querySelector('#selectedPtNm').textContent = $(this).closest('.regRow').children()[1].textContent;
		
		chartListPtNum.value = $(this).closest('.regRow').children()[2].textContent;
		chartListChkNum.value = $(this).closest('.regRow').data('chknum');
//		document.querySelector('#chartListBody').dataset.ptnum = $(this).closest('.regRow').children()[2].textContent;
//		document.querySelector('#chartListBody').dataset.chknum = $(this).closest('.regRow').data('chknum');
		listChart();
		return false;
	}

	$('#regDropdownMenu')
		.attr('data-regnum', $(this).data('regnum'))
		.removeClass('d-none')
		.css({
			left: e.pageX,
			top: e.pageY
		});
});

// 다른 곳을 클릭할 경우 접수 목록 드롭다운 메뉴 숨김
$(document).on('click', function(e){

	if(!e.target.parentNode.classList.contains('regRow')){
		$('#regDropdownMenu')
			.addClass('d-none');
	}
});

// 접수/예약 목록의 탭을 클릭하여 탭 내용을 바꾼다.
$('a[data-toggle="pill"]').on('click', function(e){
	e.preventDefault();
	$(this).tab('show');
});

// 치아 이미지를 클릭하면 선택된 치아가 하이라이트된다.
$('#upperTeeth td, #lowerTeeth td').on('click', function(e){

	activeTeethTd($(this), false);
	/*
	if($(this).hasClass('selectedTeeth')){ // 이미 선택된 치아인 경우
		$(this).removeClass('selectedTeeth');
		$(this).on('mouseenter', function(){changeTeethImage(this);});
		$(this).on('mouseleave', function(){changeTeethImage(this);});
	} else { // 새로 선택된 치아인 경우
		$(this).addClass('selectedTeeth');
		$(this).off('mouseenter');
		$(this).off('mouseleave');
	}
	*/
});

// 치아 차트의 치아를 선택 처리
function activeTeethTd(target, needImgEvent){

	if($(target).hasClass('selectedTeeth')){ // 이미 선택된 치아인 경우
		$(target).removeClass('selectedTeeth');
		$(target).on('mouseenter', function(){changeTeethImage(target);});
		$(target).on('mouseleave', function(){changeTeethImage(target);});

		if(needImgEvent){
			$('.defaultImg', target).removeClass('d-none');
			$('.selectedImg', target).addClass('d-none');
		}
	} else { // 새로 선택된 치아인 경우
		$(target).addClass('selectedTeeth');
		$(target).off('mouseenter');
		$(target).off('mouseleave');

		if(needImgEvent){
			$('.defaultImg', target).addClass('d-none');
			$('.selectedImg', target).removeClass('d-none');
		}
	}

}

// 치아 이미지 위에 마우스가 올라가면 하이라이트된다.
$('#upperTeeth td, #lowerTeeth td').on('mouseenter', function(){changeTeethImage(this);});
$('#upperTeeth td, #lowerTeeth td').on('mouseleave', function(){changeTeethImage(this);});

// 차트의 치아 번호를 클릭하면 치아 차트에서 해당 치아가 선택됨
$(document).on('click', '.teethNum', function(e){

	const targetImgTd = $('td[data-value="' + $(this).text() + '"]');
	activeTeethTd(targetImgTd, true);

	/*
	if($(targetImgTd).hasClass('selectedTeeth')){ // 이미 선택된 치아인 경우
		$(targetImgTd).removeClass('selectedTeeth');
		$(targetImgTd).on('mouseenter', function(){changeTeethImage(this);});
		$(targetImgTd).on('mouseleave', function(){changeTeethImage(this);});
		$('.defaultImg', targetImgTd).removeClass('d-none');
		$('.selectedImg', targetImgTd).addClass('d-none');
	} else { // 새로 선택된 치아인 경우
		$(targetImgTd).addClass('selectedTeeth');
		$(targetImgTd).off('mouseenter');
		$(targetImgTd).off('mouseleave');
		$('.defaultImg', targetImgTd).addClass('d-none');
		$('.selectedImg', targetImgTd).removeClass('d-none');
	}
	*/
});

// 진료 시작 (진료 추가)
function insertCheckup(){

	const regDropdownMenu = document.querySelector('#regDropdownMenu');

	let formData = new FormData();
	formData.append('regNum', regDropdownMenu.dataset.regnum);
	formData.append('empNum', $('#_empNum').val());

	const csrfToken = $('#_csrfToken').val();

	fetch('/hospital/chart/insertCheckup', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : csrfToken
		},
		body: formData
	})
		.then(res => res.text())
		.then(text => {

			if(text == "FAILED"){
				simpleJustErrorAlert();
				return false;
			}

			listRegist();
		});
}

// 접수 목록 조회
function listRegist(){

	fetch('/hospital/chart/listRegist')
		.then(res => res.json())
		.then(regList => {

			const regListBody = document.querySelector('#regListBody');
			regListBody.innerHTML = '';

			let code = '';

			if(regList.length == 0){
				code += '<tr class="text-center"><td colspan="6">등록된 접수가 없습니다.</td></tr>'
				regListBody.innerHTML = code;
				return false;
			}

			regList.forEach(function(reg, idx){
				code += '<tr class="regRow"';
				code += 'data-regnum="' + reg.regNum + '"';
				if(reg.regStatus == '진료중'){
					code += 'data-chknum="' + reg.chkNum + '"';
				} else {
					code += 'data-chknum=""';
				}
				code += '>';
				code += '<td>' + (idx + 1) + '</td>';
				code += '<td>' + reg.ptNm + '</td>';
				code += '<td>' + reg.ptNum + '</td>';
				code += '<td>';
				code += reg.regStatus
				code += '</td>';
				code += '<td>' + reg.chairNm + '</td>';
				code += '<td>' + reg.empNm + '</td>';
				code += '</tr>'
			});
			regListBody.innerHTML = code;
		});

}

// 예약 목록 조회
function listResv(){

	fetch('/hospital/chart/listResv')
		.then(res => res.json())
		.then(resvList => {

			const resvListBody = document.querySelector('#resvListBody');
			resvListBody.innerHTML = '';

			let code = '';

			if(resvList.length == 0){
				code += '<tr class="text-center"><td colspan="5">등록된 예약이 없습니다.</td></tr>'
				resvListBody.innerHTML = code;
				return false;
			}

			resvList.forEach(function(resv, idx){
				code += '<tr>'
				code += '<td>' + (idx + 1) + '</td>';
				code += '<td>' + resv.ptNm + '</td>';
				code += '<td>' + resv.ptNum + '</td>';
				code += '<td>' + resv.resvSdt + '</td>';
				code += '<td>' + resv.empNm + '</td>';
				code += '</tr>'
			})
			resvListBody.innerHTML = code;
		});

}

// 이벤트가 발생하면 해당 치아 이미지를 선택된 치아 이미지로 변경한다.
function changeTeethImage(target){

	const img = $('img', target);
	img.each(function(i, v){
		if(v.classList.contains('d-none')){
			v.classList.remove('d-none');
		} else {
			v.classList.add('d-none');
		}
	});
}

// 치아차트 및 증상뱃지 모두 초기화
function resetAll(){
	resetTeethImage();
	resetPiBadges();
	document.querySelector('#checkupMemo').value = '';
}

// 치아차트 초기화
function resetTeethImage(){

	const toothTd = $('.selectedTeeth');
	toothTd.each(function(i, v){
		$(v).removeClass('selectedTeeth');
		$(v).on('mouseenter', function(){changeTeethImage(this);});
		$(v).on('mouseleave', function(){changeTeethImage(this);});
	});

	const img = $('#teethChart img');
	img.each(function(i, v){
		if($(v).hasClass('defaultImg')){
			$(v).removeClass('d-none');
		} else {
			$(v).addClass('d-none');
		}
	});

}

// 증상 선택 시 빨갛게 하이라이트
$('#piTxTabContent .badge-pitx').on('click', function(){

	// 재선택일 경우 하이라이트 취소
	if($(this).hasClass('selectedPiTx')){
//		$(this).removeClass('badge-danger');
		$(this).removeClass('selectedPiTx');
//		$(this).addClass('badge-primary');
		return false;
	}

	// 증상 뱃지 초기화
	resetPiBadges();

	// 증상 하이라이트
//	$(this).removeClass('badge-primary');
//	$(this).addClass('badge-danger');
	$(this).addClass('selectedPiTx');

});

// 선택되어있던 증상들의 하이라이트 제거
function resetPiBadges(){

	$('#piTxTabContent .badge-pitx').each(function(i, v){
		if($(v).hasClass('selectedPiTx')){
//			$(v).removeClass('badge-danger');
			$(v).removeClass('selectedPiTx');
//			$(v).addClass('badge-primary');
		}
	});
}

// 선택된 치아의 번호들을 가져옴
function getSelectedTeeth(){

	const toothTd = document.querySelectorAll('.selectedTeeth');
	const teeth = [...toothTd].map(td => td.dataset.value).join(', ').trim();

	return teeth;

}

// 선택된 PITX의 코드를 가져옴
function getSelectedPiTx(){

	const pis = document.querySelectorAll('.selectedPiTx');
	const piCd = [...pis].map(badge => badge.dataset.cd).join('').trim();

	return piCd;
}