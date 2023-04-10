// 영수증 발급 윈도우
function rctWindow(rctNum){
	Swal.fire({
		title: '영수증',
		text: '영수증을 확인하시겠습니까?',
		showDenyButton: true,
		confirmButtonText: '확인',
		denyButtonText: '취소',
	}).then(result => {
		if(result.isConfirmed){
			let receiptWin = window.open(
			url = "/hospital/rcvmt/rcvmtWindow?rctNum=" + rctNum,
			 'rcvmt', 'top=200, left=300, width=1000, height=800, toolbar=no, menubar=no, location=no, status=no, scrollbars=no, resizable=no');
		}
	});
};

function patientRctWindow(rctNum){
	let receiptWin = window.open(
		url = "/ddit/receipt/patientRcvmtWindow?rctNum=" + rctNum,
	 'rcvmt', 'top=200, left=300, width=1000, height=800, toolbar=no, menubar=no, location=no, status=no, scrollbars=no, resizable=no');
};