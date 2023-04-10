chatsFlag = false;
totalChatCount = document.querySelector('#totalChatCount');
chatMainWindow = document.querySelector('#chatMainWindow');
chatgrpList = document.querySelector('#chatgrpList');
chatRoom = document.querySelector('#chatRoom');
chatList = document.querySelector('#chatList');
chatMsg = document.querySelector('#chatMsg');
chatEmpNum = document.querySelector('#_empNum').value;

// 채팅 웹소켓 연결
connectChatServer();
// 채팅그룹 목록 초기화
initChatList();

// 채팅방 입장
$(chatgrpList).on('click', '.chatgrpTitle', function(e){
	chatMainWindow.style.display = 'none';
	chatRoom.style.display = '';

	document.querySelector('#chatList').innerHTML = '';

	const chatgrpNum = $(this).children('p').attr('id');
	chatsOpen(chatgrpNum);

	chatMsg.dataset.value = chatgrpNum;
});

// 채팅그룹 목록으로 이동
$('#backToChatMainWindow').on('click', function(e){
	chatRoom.style.display = 'none';
	chatMainWindow.style.display = '';

	chatsClose();
});

// 채팅그룹 나가기 알림창
$('#exitChatgrp').on('click', function(e){

	Swal.fire({
		title: '채팅을 나가시겠습니까?',
		showDenyButton: true,
		confirmButtonText: '나가기',
		denyButtonText: '취소',
	}).then(result => {
		if(result.isConfirmed){
			exitChatgrp();
		}
	});

});

// 채팅그룹 나가기
function exitChatgrp(){

	const chatgrpNum = chatMsg.dataset.value;
	const csrfToken = $('#_csrfToken').val();

	fetch('/chat/exitChatgrp', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : csrfToken,
			'Content-Type' : 'application/json;chatset=utf-8'
		},
		body: JSON.stringify({
			'empNum' : chatEmpNum,
			'chatgrpNum' : chatgrpNum
		})
	})
		.then(function (){
			chatRoom.style.display = 'none';
			chatMainWindow.style.display = '';

			chatsClose();
			initChatList();
			reconnectChatServer();
		});

}

// 채팅창을 클릭했을 때는 채팅창이 닫히지 않도록
$('.dropdown-menu , .modal').on('click', function(e){
	e.stopPropagation();
});

$(document).on('click', '.swal2-container', function(e){
	e.stopPropagation();
})

// 채팅창에서 enter 입력 시 채팅 전송
chatMsg.addEventListener('keydown', function(e){

	if(e.keyCode == 13){
		sendMessage();
	}
});

// esc를 입력할 경우 채팅창 닫힘
document.addEventListener('keydown', function(e){

	const chats = document.querySelector('.dropdown-menu');
	if(e.keyCode == 27 && chats.classList.contains('show')){
		chatsClose();
	}
});

// 모달창이 닫히면 내용 초기화
$('button[data-dismiss="modal"]').on('click', function(){
	$('#chatgrpNm').val('');
});

// 채팅 버튼의 알림 숫자 초기화
function resetTotalChatCount(){
	totalChatCount.textContent = '';
}

// 채팅 버튼의 알림 숫자 증가
function addTotalChatCount(count){
	totalChatCount.textContent = parseInt(totalChatCount.textContent == '' ? 0 : totalChatCount.textContent) + count;
	if(totalChatCount.textContent == '0') totalChatCount.textContent = '';
}

// 채팅 버튼의 알림 숫자 감소
function subTotalChatCount(count){
	totalChatCount.textContent = parseInt(totalChatCount.textContent == '' ? 0 : totalChatCount.textContent) - count;
	if(totalChatCount.textContent == '0') totalChatCount.textContent = '';
}

// 채팅그룹 목록 초기화
function initChatList(){

	// 현재 사용자가 속해있는 채팅그룹 목록 가져옴
	fetch('/chat/chatgrpList')
		.then((res) => res.json())
		.then((grpList) => {

			resetTotalChatCount();

			let list = '';
			if(grpList.length == 0){
				list += '<div class="d-flex justify-content-center align-items-center" style="height: 60px;>';
				list += '<p class="m-0">참여중인 채팅이 없습니다.</p>';
				list += '</div>';
				list += '<div class="dropdown-divider"></div>';
			} else {
				grpList.forEach(function(grp){

					list += '<div class="d-flex align-items-center chatgrpTitle" style="height: 60px; cursor: pointer;">';
					list += '<p id="' + grp.chatgrpNum + '" class="m-0">' + grp.chatgrpNm + ' ';
					let noReadCount = grp.noReadCount == 0 ? '' : grp.noReadCount;
					list += '<span class="badge rounded-pill bg-danger chatsCounter">' + noReadCount + '</span>';
					list += '<span class="text-sm">' + (grp.lastChat == null ? '채팅 내용이 없습니다.' : grp.lastChat) + '</span>';
					list += '</p>';
					list += '</div>';
					list += '<div class="dropdown-divider"></div>';

					addTotalChatCount(noReadCount);
				});
			}
			chatgrpList.innerHTML = list;

		});
}

// 채팅그룹 초대 모달 출력
function inviteMemModal(){

	const chatgrpNum = chatMsg.dataset.value;

	// 채팅에 속하지 않은 직원 목록 가져옴
	fetch('/chat/empList?chatgrpNum=' + chatgrpNum)
		.then((res) => res.json())
		.then((empList) => {

			let listData = '';
			empList.forEach(function(item){
				listData += '<tr>';
				listData += '<td>' + item.empNum + '</td>';
				listData += '<td>' + item.empNm + '</td>';
				listData += '<td><input type="checkbox" name="empNum" value="' + item.empNum + '" /></td>';
				listData += '</tr>';
			});

			$('#inviteMemSelectList').html(listData);
			$('#inviteMemModal').modal('show');
		});

}

// 새 채팅 모달 출력
function newChatModal(){

	// 직원 목록 가져옴
	fetch('/chat/empList')
		.then((res) => res.json())
		.then((empList) => {

			let listData = '';
			empList.forEach(function(item){
				listData += '<tr>';
				listData += '<td>' + item.empNum + '</td>';
				listData += '<td>' + item.empNm + '</td>';
				listData += '<td><input type="checkbox" name="empNum" value="' + item.empNum + '" /></td>';
				listData += '</tr>';
			});

			$('#chatMemSelectList').html(listData);
			$('#newChatModal').modal('show');
		});

}

// 채팅그룹에 새 멤버 초대
function inviteNewMem(){

	const formData = new FormData(document.inviteMemForm);
	if(formData.getAll('empNum') == ''){
		simpleErrorAlert('초대할 멤버를 선택해주세요.');
		return false;
	}

	const chatgrpNum = chatMsg.dataset.value;
	formData.append('chatgrpNum', chatgrpNum);

	const csrfToken = $('#_csrfToken').val();

	fetch('/chat/inviteNewMem', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : csrfToken
		},
		body: formData
	})
		.then(() => {
			$('#inviteMemModal').modal('hide');
		});

}

// 현재 채팅그룹의 멤버 목록 조회
function chatgrpMemListModal(){

	const chatgrpNum = chatMsg.dataset.value;
	fetch('/chat/listChatMem?chatgrpNum=' + chatgrpNum)
		.then(res => {
			if(!res.ok) throw new Error();
			return res.json();
		})
		.then(memList => {

			let code = '';
			memList.forEach(function(mem){
				code += '<tr>';
				code += '<td>' + mem.empNum + '</td>';
				code += '<td>' + mem.empNm + '</td>';
				code += '<td>' + mem.jbgdCd + '</td>';
				code += '<td>' + mem.deptCd + '</td>';
				code += '</tr>';
			});
			$('#chatgrpMemListBody').html(code);
			$('#chatgrpMemListModal').modal('show');
		})
		.catch(() => {
			simpleJustErrorAlert();
		});
}

// 새 채팅그룹 생성
function createNewChat(){

	const formData = new FormData(document.newChatForm);
	if(formData.get('chatgrpNm') == ''){
		simpleErrorAlert('채팅 이름을 입력해주세요.');
		return false;
	}

	if(formData.getAll('empNum') == ''){
		simpleErrorAlert('채팅 멤버를 선택해주세요.');
		return false;
	}

	const csrfToken = $('#_csrfToken').val();

	fetch('/chat/createNewChat', {
		method: 'post',
		headers: {
			'X-CSRF-TOKEN' : csrfToken
		},
		body: formData
	})
		.then(() => {
			$('#newChatModal').modal('hide');
			$('#chatgrpNm').val('');
			initChatList();
		});
}

// 채팅 연결
function chatsOpen(chatgrpNum){

	// 채팅방의 채팅 목록을 가져온다.
	fetch('/chat/chatList?chatgrpNum=' + chatgrpNum)
		.then((res) => res.json())
		.then((chats) => {

			let chatData = '';
			chats.forEach(function(chat){
				if(chat.empNum == 'SYSTEM'){ // 채팅 초대, 퇴장 알림일 경우
					chatData += '<div class="my-2">';
					chatData += '<hr class="mb-0" />';
					chatData += '<p class="m-0 text-center" style="font-size: 14px;">' + chat.chatContent + '</p>';
					chatData += '<hr class="mt-0" />';
					chatData += '</div>';
				} else {
					if(chat.empNum != chatEmpNum){
						chatData += '<div class="my-2 text-left">';
						chatData += '<div class="row m-auto">';
						if(chat.empImg == null){
							chat.empImg = '/doc_def_image.png';
						}
						chatData += '<img src="/resources/images/employee' + chat.empImg + '" class="col-auto p-0 rounded-circle" style="width: 48px; height: 48px;" />'
						chatData += '<h5 class="col-auto m-0 d-flex align-items-center">' + chat.empNm + '</h5>';
						chatData += '</div>';
						chatData += '<div class="mt-1 mr-4 p-1 rounded-lg d-inline-block" style="background-color: #1976D2">';
						chatData += '<p class="m-0 text-white text-left">' + chat.chatContent + '</p>';
						chatData += '</div>';
					} else {
						chatData += '<div class="my-2 text-right">';
						chatData += '<div class="mt-1 ml-4 p-1 rounded-lg d-inline-block" style="background-color: #1976D2">';
						chatData += '<p class="m-0 text-white text-left">' + chat.chatContent + '</p>';
						chatData += '</div>';
					}
					chatData += '</div>';
				}
			});

			document.querySelector('#chatList').insertAdjacentHTML('beforeEnd', chatData);

			chatsFlag = true;
			subTotalChatCount($('p[id=' + chatgrpNum + '] .chatsCounter').text());
			$('p[id=' + chatgrpNum + '] .chatsCounter').text('');

			chatList.scrollTop = chatList.scrollHeight;
			updateLastReadDate(chatgrpNum);
		});

}

// 마지막 채팅 확인 시간 갱신
function updateLastReadDate(chatgrpNum){

	const csrfToken = $('#_csrfToken').val();

	fetch('/chat/updateLastReadDate', {
		method: 'post',
		headers: {
			'Content-Type' : 'application/json;charset=utf-8',
			'X-CSRF-TOKEN' : csrfToken
		},
		body: JSON.stringify({
			'empNum' : chatEmpNum,
			'chatgrpNum' : chatgrpNum
		})
	});

}

// 채팅 종료
function chatsClose(){
	chatsFlag = false;
	chatMsg.value = '';
	chatMsg.dataset.value = '';
}


// 채팅 웹소켓 연결
function connectChatServer(){
	sock = new SockJS('http://192.168.145.28/chatServer');
// 	sock = new SockJS('http://192.168.0.7/chatServer');
	sock.onmessage = onMessage;
}

// 채팅 웹소켓 재연결
function reconnectChatServer(){
	sock.close();
	connectChatServer();
}

// 채팅 전송
function sendMessage() {

	let chatMsgContent = chatMsg.value.trim();
	chatMsgContent = chatMsgContent.replace(/\$\/\/##/g, '');
	sock.send(chatMsg.dataset.value + "$//##" + chatMsgContent);
	chatMsg.value = '';

	updateLastReadDate(chatMsg.dataset.value);
}

// 채팅 수신
function onMessage(chat){

	const chatData = chat.data.split('$//##');
	const chatgrpNum = chatData[0].trim();
	const chatContent = chatData[1].trim();
	const sendEmpNum = chatData[2].trim();
	let empImg = chatData[3].trim();

	// 채팅그룹이 채팅그룹 목록에 존재하지 않을 경우
	// 새로운 채팅그룹이 생성되었거나 초대된 것이므로 채팅그룹 목록을 초기화
	// DB에서 다시 채팅그룹 목록을 가져옴
	if($('.chatgrpTitle p[id=' + chatgrpNum + ']').length == 0){
		initChatList();
	}

	$('#' + chatgrpNum + '>.text-sm').text(chatContent.replace(/\$\/:\/##/g, ' : '));

	// 채팅창이 열려있지 않거나 현재 보고있는 채팅방의 그룹이 수신된 채팅의 그룹이 아닐 경우
	if(!chatsFlag || chatMsg.dataset.value != chatgrpNum) {
		const chatsCounter = $('.chatgrpTitle p[id=' + chatgrpNum + '] .chatsCounter');
		const counterNum = chatsCounter.text() == '' ? 1 : parseInt(chatsCounter.text()) + 1;
		chatsCounter.text(counterNum);

		addTotalChatCount(1);
		return;
	}

	// 현재 보고있는 채팅방의 채팅을 수신했을 경우
	if(chatsFlag && chatMsg.dataset.value == chatgrpNum){
		const msgBody = chatContent.split('$/:/##');
		const empNm = msgBody[0];
		const chatMsg = msgBody[1];

		let chatElement = '';
		if(sendEmpNum == 'SYSTEM'){ // 채팅 초대, 퇴장 알림일 경우
			chatElement += '<div class="my-2">';
			chatElement += '<hr class="mb-0" />';
			chatElement += '<p class="m-0 text-center" style="font-size: 14px;">' + chatMsg + '</p>';
			chatElement += '<hr class="mt-0" />';
			chatElement += '</div>';
		} else {
			if(sendEmpNum != chatEmpNum){
				chatElement += '<div class="my-2 text-left">';
				chatElement += '<div class="row m-auto">';
				if(empImg == 'null'){
					empImg = '/doc_def_image.png';
				}
				chatElement += '<img src="/resources/images/employee' + empImg + '" class="col-auto p-0 rounded-circle" style="width: 48px; height: 48px;" />'
				chatElement += '<h5 class="col-auto m-0 d-flex align-items-center">' + empNm + '</h5>';
				chatElement += '</div>';
				chatElement += '<div class="mt-1 mr-4 p-1 rounded-lg d-inline-block" style="background-color: #1976D2">';
				chatElement += '<p class="m-0 text-white text-left">' + chatMsg + '</p>';
				chatElement += '</div>';
			} else {
				chatElement += '<div class="my-2 text-right">';
				chatElement += '<div class="mt-1 ml-4 p-1 rounded-lg d-inline-block" style="background-color: #1976D2">';
				chatElement += '<p class="m-0 text-white text-left">' + chatMsg + '</p>';
				chatElement += '</div>';
			}
		}
		chatElement += '</div>';

//		let chatElement = '<p>' + chatContent + '</p>';
		chatList.insertAdjacentHTML('beforeEnd', chatElement);

		updateLastReadDate(chatgrpNum);
		chatList.scrollTop = chatList.scrollHeight;
		return;
	}

}