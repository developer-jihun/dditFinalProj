// 가족관계 모달 열기
function openfamilyModal(){
	const ptNum = document.patientForm.ptNum.value;
	if(ptNum == ''){
		simplePatientSelectNeedAlert();
		return false;
	}

	$('#familyModal').modal('show');
}

// 환자의 가족, 진료, 수납 정보를 가져온다.
function selectDetail(){

	const ptNum = document.patientForm.ptNum.value;
	if(ptNum == '') return false;

	fetch('/hospital/desk/selectDetail?ptNum=' + ptNum)
		.then(res => res.json())
		.then(ptDet => {

			// 가족관계 목록 셋팅
			setFamilyList(ptDet.familyList);

			// 진료내역 목록 셋팅
			setCheckupList(ptDet.checkupList);

			// 수납내역 목록 셋팅
			setRcvmtList(ptDet.rcvmtList);

		});

}

//진료이력 목록을 불러온 데이터를 사용해 셋팅한다.
function setCheckupList(chkup){

	let chkList = '';
	chkup.forEach(function(chk){
		chkList += '<tr>';
		chkList += '<td>' + chk.chkNum + '</td>';
		chkList += '<td>' + chk.chkDtStr + '</td>';
		chkList += '<td>' + chk.empNm + '</td>';
		chkList += '</tr>';
	});

	document.querySelector('#checkupListBody').innerHTML = chkList;

}

//수납이력 목록을 불러온 데이터를 사용해 셋팅한다.
function setRcvmtList(rcvmt){

	let rcvmtList = '';
	rcvmt.forEach(function(rcv){
		rcvmtList += '<tr>';
		rcvmtList += '<td>' + rcv.rcvmtNum + '</td>';
		rcvmtList += '<td>' + rcv.rcvmtDtStr + '</td>';
		rcvmtList += '<td>' + rcv.rcvmtGramt.toLocaleString() + '</td>';
		rcvmtList += '<td>' + rcv.rcvmtBalance.toLocaleString() + '</td>';
		rcvmtList += '</tr>';
	});

	document.querySelector('#rcvmtListBody').innerHTML = rcvmtList;

}

// 환자 상세정보의 탭을 클릭하여 탭 내용을 바꾼다.
$('#ptDetailTabList a').on('click', function(){
	$(this).tab('show');
});

// 환자 검색란에 값 입력 시 드롭박스 메뉴가 열린다.
$('#famPtSearch').on('keyup', function(e){
	$(this).dropdown('toggle');
});

// 환자 검색란을 떠나면 드롭박스 메뉴가 닫힌다.
$('#famPtSearch').on('blur', function(e){
	if($('#famPtSearchDropdown').hasClass('show')){
		$('#famPtSearchDropdown').removeClass('show');
	}
});

// 가족관계 추가를 위해 환자를 검색한다.
function searchFamPatient(target){

	const keyword = target.value;
	if(keyword.trim() == '') return false;

	fetch('/hospital/desk/searchPatient?keyword=' + keyword)
		.then(res => res.json())
		.then(ptList => {

			let dropdownItems = '';
			ptList.forEach(function(pt){
				dropdownItems += '<li class="dropdown-item" data-num="' + pt.ptNum + '" data-nm="' + pt.ptNm + '" data-brdt="' + pt.ptBrdt + '" onmousedown="selectFamPt(this);">' + pt.ptNm + '(' + pt.ptNum + ')' + '</li>';
			});

			document.querySelector('#famPtSearchDropdown').innerHTML = dropdownItems;
		});

}

// 검색 목록에서 가족 환자를 선택하면 가족관계 폼이 채워진다.
function selectFamPt(target){

	document.familyPatientForm.action = '/hospital/desk/insertFamily';
	document.querySelector('#famPtSearch').value = target.dataset.nm + '(' + target.dataset.num + ')';
	document.familyPatientForm.famPtNum.value = target.dataset.num;
	document.familyPatientForm.famPtNm.value = target.dataset.nm;
	document.familyPatientForm.famPtBrdt.value = target.dataset.brdt;

}

// 가족관계 추가
function insertFamily(){

	let familyFormData = new FormData(document.familyPatientForm);

	if(familyFormData.get('famPtNum') == ''){
		simpleErrorAlert('환자를 선택해주세요.');
		return false;
	}

	const actionPath = document.familyPatientForm.action;

	if(actionPath.indexOf('insertFamily') != -1){
		const famPtNum = familyFormData.get('famPtNum');
		if(checkAlreadyFamily(famPtNum)) {
			simpleErrorAlert('이미 가족관계인 환자입니다.');
			return false;
		}
	}

	familyFormData.append('ptNum', document.patientForm.ptNum.value);

	const csrfToken = $('#_csrfToken').val();

	fetch(actionPath + '?_csrf=' + csrfToken, {
		method: 'post',
		body: familyFormData
	})
		.then(res => res.text())
		.then(text => {
			if(text == 'FAILED'){
				simpleJustErrorAlert();
				return false;
			}

			if(text == 'INSERT'){
				simpleSuccessAlert('가족관계가 추가되었습니다.');
			} else if (text == 'UPDATE'){
				simpleSuccessAlert('가족관계가 수정되었습니다.');
			}

			$('#familyModal').modal('hide');
			resetFamilyModal();
			listFamily();
		});
}

// 이미 가족관계인 환자인지 확인
function checkAlreadyFamily(famPtNum){

	let famListTr = document.querySelectorAll('#familyListBody tr');
	const famPtNumList = [...famListTr].map(tr => {
		return tr.childNodes[2].textContent.trim();
	});

	if(famPtNumList.includes(famPtNum)) return true;
	return false;
}

// 가족관계 목록 조회
function listFamily(){

	const familyListBody = document.querySelector('#familyListBody');

	const ptNum = document.patientForm.ptNum.value;

	fetch('/hospital/desk/listFamily?ptNum=' + ptNum)
		.then(res => res.json())
		.then(famPt => {
			setFamilyList(famPt);
		});

}

// 가족관계 수정 모달
function openFamilyModalUpdate(famPtNum){

	const ptNum = document.patientForm.ptNum.value;

	fetch('/hospital/desk/selectFamily?ptNum=' + ptNum + '&famPtNum=' + famPtNum)
		.then(res => res.json())
		.then(famPt => {

			document.familyPatientForm.action = '/hospital/desk/updateFamily';

			document.querySelector('#famPtSearch').value = famPt.famPtNm + '(' + famPt.famPtNum + ')';
			document.familyPatientForm.famPtNum.value = famPt.famPtNum;
			document.familyPatientForm.famPtNm.value = famPt.famPtNm;
			document.familyPatientForm.famPtBrdt.value = famPt.famPtBrdt;
			document.familyPatientForm.famRel.value = famPt.famRel;

			$('#familyModal').modal('show');
		});
}

// 가족관계 목록을 불러온 데이터를 사용해 셋팅한다.
function setFamilyList(famPt){

	let famList = '';
	famPt.forEach(function(fam, idx){
		famList += '<tr class="dropdown">';
		famList += '<td>' + (idx + 1) + '</td>';
		famList += '<td data-toggle="dropdown">' + fam.famPtNm;
		famList += '<ul class="dropdown-menu">';
		famList += '<li><a class="dropdown-item" href="#" onclick="openFamilyModalUpdate(\'' + fam.famPtNum + '\')">수정</a></li>';
		famList += '<li><a class="dropdown-item" href="#" onclick="deleteFamilyAlert(\'' + fam.famPtNum + '\')">삭제</a></li>';
		famList += '</ul>';
		famList += '</td>';
		famList += '<td>' + fam.famPtNum + '</td>';
		famList += '<td>' + fam.famRel + '</td>';
		famList += '</tr>';
	});

	familyListBody.innerHTML = famList;

}

// 가족관계 삭제 알림창
function deleteFamilyAlert(famPtNum){

	Swal.fire({
		title: '가족관계를 삭제하시겠습니까?',
		showDenyButton: true,
		confirmButtonText: '삭제',
		denyButtonText: '취소',
	}).then((result) => {
		if (result.isConfirmed) {
			deleteFamily(famPtNum);
		}
	});

}

// 가족관계 삭제
function deleteFamily(famPtNum){

	const csrfToken = $('#_csrfToken').val();
	const ptNum = document.patientForm.ptNum.value;

	fetch('/hospital/desk/deleteFamily', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : csrfToken,
			'Content-Type' : 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			'ptNum' : ptNum,
			'famPtNum' : famPtNum
		})
	})
		.then(res => res.text())
		.then(text => {
			if(text == 'FAILED'){
				simpleJustErrorAlert();
				return false;
			}

			simpleSuccessAlert('가족관계가 삭제되었습니다.');
			listFamily();
		});

}

// 가족관계 모달을 닫으면 내용이 비워진다.
function resetFamilyModal(){

	document.familyPatientForm.reset();

}