/***************************************
****************************************
**********예약페이지 캘린더(시간, 월)***********
****************************************
****************************************/

//--------------------------------- 시간 달력 생성 시작----------------------------------------
var carrentTime =  moment(new Date().setHours(new Date().getHours() - 1)).format('HH:MM:SS'); // 현재시간 기준 한시간 전; 
var calendarDay = document.getElementById('calendarDay');
var dCalendar = new FullCalendar.Calendar(calendarDay, {
	locale: 'ko',						// 한글 설정
	timeZone: 'local',					// 시간 설정
	initialView: 'timeGridDay',			// 일자 달력 표시  , 'dayGridWeek', 'timeGridDay', 'listWeek'
	allDaySlot: false,					// 상단에 AllDay 출력여부
	nowIndicator: true,					// 현재 시간 줄 표시
	eventMinHeight: '100px',			// 이벤트 최소 높이 설정	default : 15
	//eventShortHeight	: '40px',		// 길이가 짧은 이벤트가 있을 경우, 높이 조절 default : 30
	//businessHours		: true,			// 비즈니스 시간(토요일 일요일 배경색 회색으로 변함) default 09:00 ~ 17:00
	slotEventOverlap: false,			// 이벤트 겹침 여부 , default : true
	hiddenDays: [],						// 달력 보기에 주말을 포함할 지 여부를 설정 default : [] (월 : 1, 일 : 0, 금 : 5)
	dayHeaders: true,					// headr에 월 표시 여부 default : true
	height: '800px',					// 높이 크기 조절
	slotMinTime: '07:00:00',			// 슬롯 최소 시간 default : '00:00:00'
	slotMaxTime: '20:00:00',			// 슬롯 최대 시간 default : '24:00:00'
	scrollTime: carrentTime,		// 날짜 변경시 보여지는 시간 설정	 default : 06:00:00 (오전 6시)
	scrollTimeReset: false,				// 날짜 변경시 시간 초기화(scrollTime 시간으로 초기화) default : true
	slotDuration: '00:15:00',			// 슬롯의 시간 설정 default : '00:30:00'
	slotLabelInterval: '00:30',			// {hours:1} : "01:00"
	selectable: true,					// 테이블 선택 가능
	selectMirror: true,					// 테이블 선택 영역 이벤트 발생
	slotLabelFormat: 					// 라벨의 보여지는 시간 설정
	{
		hour: '2-digit',
		minute: '2-digit',
		omitZeroMinute: false,
		hour12: false,
		meridiem: 'narrow'
	},
	customButtons: 					// 사용자 커스텀 버튼 추가
	{
		addEvent: {
			text: '예약',
			click: function() {
				newEvent();
			}
			//},
			//todayEvent : {
			//	text : '오늘',
			//	click : function(){
			//		todayClick();
			//	}
		}
	},
	select: function(arg) {
		console.log(arg);
		var title = prompt('입력할 일정:');
		// title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가
		if (title) {
			calendar.addEvent({
				title: title,
				start: arg.start,
				end: arg.end,
				allDay: arg.allDay,
				backgroundColor: "yellow",
				textColor: "blue"
			});
		}
		calendar.unselect();
	},
	headerToolbar:
	{								// 캘린더 위 header 지정
		start: 'prev,today',
		center: 'title',
		end: 'addEvent,next'
	},
	buttonText:						// header버튼 이름 지정
	{
		today: '오늘',
		month: 'month',
		week: 'week',
		day: 'day',
		list: 'list'
	},
	buttonIcons:
	{
		prev: 'chevron-left',
		next: 'chevron-right'
	},
	eventTimeFormat:
	{
		hour: '2-digit',
		minute: '2-digit',
		hour12: false
	},
	datesSet: function(info) {				// 날짜가 변경 될 때마다 이벤트
		breakTime();
	},
	eventContent: function(arg) {
		let italicEl = document.createElement('i')
		let resvInfo = arg.event.extendedProps;
		var resvStartTime = moment(arg.event.start).format("HH:mm");
		var resvEndTime = moment(arg.event.end).format("HH:mm");

		var ptHtml = resvStartTime + ' ~ ' + resvEndTime;
		ptHtml += '<br>환자:' + resvInfo.ptNm;
	  	
		var empHtml = '';
		if(resvInfo.statNm == '예약미이행'){
			empHtml += '/의사:' + resvInfo.empNm;
		} else {
			empHtml += '/의사:' + resvInfo.empNm;
		}

    	italicEl.innerHTML = ptHtml + empHtml;
		let arrayOfDomNodes = [ italicEl ]
		return { domNodes: arrayOfDomNodes }
	},
	viewHint: function(buttonText, buttonName) {	// ??
		if (buttonName.match(/^dayGrid/)) { 		// matches "dayGridWeek"
			return buttonText + " list view" 		// results in "week list view"
		} else {
			return buttonText + " view" 			// results in "week view"
		}
	},
	eventMouseEnter: function(info) {	// popover 이벤트에 마우스 올릴 때 발생
		var popLocation = 'bottom';
		popoverEvent(info, popLocation);
	},
	/*****************
	 * 예약 현황 불러오기 *
	 *************** */
	eventSources: [
		{
			url: '/hospital/resv/list',
			method: 'get',
			failure: function() {
				simpleJustErrorAlert('이벤트 로딩오류!!!...다시 시도해주세요');
			}
		}
	],
	eventClick: function(info) {		// 이벤트 클릭시 발생
		eventDetailInfo(info);
	},
	eventDidMount: function (arg) {		// event가 render 되었을 때 호출되는 함수
		filter(arg)
  	}
});
// --------------------------------- 시간 달력 생성 끝----------------------------------------

// --------------------------------- 월 달력 생성 시작----------------------------------------
var calendarMonth = document.getElementById('calendarMonth');
var mCalendar = new FullCalendar.Calendar(calendarMonth, {
	nowIndicator	: true,
	initialView		: 'dayGridMonth',
	locale			: "ko",
	height			: '800px',			// 573px  639px 726px
	businessHours	: false,			// 비즈니스 시간(토요일 일요일 배경색 회색으로 변함)
	navLinks		: false,			// can click day/week names to navigate views
	dayMaxEventRows	: true, 			// 이벤트 + more 표시 여부
	dayMaxEvents	: false, 			// allow "more" link when too many events
	moreLinkClick	: "popover",
	slotLabelFormat: 					// 라벨의 보여지는 시간 설정
	{
		hour: '2-digit',
		minute: '2-digit',
		omitZeroMinute: false,
		hour12: false,
		meridiem: 'narrow'
	},
	dayPopoverFormat: {					// 이벤트 popover시 제목의 날짜 형식 지정 default : { month: 'long', day: 'numeric', year: 'numeric' }
		hour: '2-digit',
		minute: '2-digit',
		omitZeroMinute: false,
		hour12: false,
		meridiem: 'narrow'
	},
	headerToolbar: {
		left: 'prev',
		center: 'title',
		right: 'next'
	},
	eventSources: [
		{
			url: '/hospital/resv/list',
			method: 'get',
			failure: function() {
				simpleJustErrorAlert('이벤트 로딩오류!!!...다시 시도해주세요');
			},
		}
	],
	eventDidMount: function (arg) {		// event가 render 되었을 때 호출되는 함수
		setTimeout(Monthfilter(arg),0);
	},
	//eventContent: function(arg) {
	//	let italicEl = document.createElement('i')
	//	let resvInfo = arg.event.extendedProps;
	//	var resvStartTime = moment(arg.event.start).format("HH:mm");
	//	var resvEndTime = moment(arg.event.end).format("HH:mm");
	//	
	//	var resvHtml = '';
	//	resvHtml += '<div style="display:flex; overflow:hidden; flex:1 1 100px;">';
	//	resvHtml += '	<div class="fc-daygrid-event-dot" style="border-color: ' + arg.backgroundColor + '" display:inline;>';
	//	resvHtml += '	</div>';
	//	resvHtml += '	<div class="fc-event-time">' + resvStartTime + '~' +  resvEndTime+ '</div>';
	//	resvHtml += '	<div class="fc-event-title">' + resvInfo.ptNm + '</div>';
	//	resvHtml += '</div>';
	//	
    //	italicEl.innerHTML = resvHtml;
	//	let arrayOfDomNodes = [ italicEl ];
	//	return { domNodes: arrayOfDomNodes };
	//},
	eventMouseEnter: function(info) {
		var popLocation = 'left';
		popoverEvent(info, popLocation);
	},
	eventClick: function(info) {
		eventDetailInfo(info);
	}
	
});
// --------------------------------- 월 달력 생성 끝----------------------------------------

// 캘린더 이벤트 재 로딩
function resvEventReLoding() {
	dCalendar.refetchEvents();
	mCalendar.refetchEvents();
}

// 휴식시간 색상 변경
function breakTime() {
	// 오픈시간 초기화
	$('#calendarDay').find('tr').each(function() {
		var fcTd = $(this).find('td').eq(1);
		fcTd.removeClass('fc-businesshour');
	});

	if (new Date(dCalendar.getDate()).getDay() == 6) {	// 토요일은 점심시간 전까지
		$('#calendarDay').find('tr').each(function() {
			var fcTd = $(this).find('td').eq(1);
			var dataTime = fcTd.attr('data-time');
			if ($(this).hasClass('fc-scrollgrid-section') || dataTime == null) {
				return true;
			};
			dataTime = parseInt(dataTime.replaceAll(":" ,"").substr(0,4));
			if (dataTime < openTime || dataTime >= sbreak) {
				fcTd.addClass('fc-businesshour');
			};
		});
	} else if (new Date(dCalendar.getDate()).getDay() == 0) {	// 일요일은 영업 안함
		$('#calendarDay').find('tr').each(function() {
			var fcTd = $(this).find('td').eq(1);
			if ($(this).hasClass('fc-scrollgrid-section')) {
				return true;
			};
			fcTd.addClass('fc-businesshour');
		});
	} else {	// 평일
		$('#calendarDay').find('tr').each(function() {
			var fcTd = $(this).find('td').eq(1);
			var dataTime = fcTd.attr('data-time');
			if ($(this).hasClass('fc-scrollgrid-section') || dataTime == null) {
				return true;
			};
			dataTime = parseInt(dataTime.replaceAll(":" ,"").substr(0,4));
			if (dataTime < openTime || (dataTime >= sbreak && dataTime < ebreak) || dataTime >= closeTime) {
				fcTd.addClass('fc-businesshour');
			};
		});
	}
	
};

// 이벤트 hover시 정보 출력
function popoverEvent(info, popLocation){
	var element = info.el;
	var resvInfo = info.event.extendedProps;
	
	var popTime = '';	// 시간
	var resvSTime = moment(info.event.start).format("HH:mm");
  	var resvETime = moment(info.event.end).format("HH:mm");
  	if(resvInfo.statNm=='예약미이행'){
		popTime = '<td class="non-compliance">' + resvSTime + ' ~ ' + resvETime + '</td>';
   	} else {
   		popTime = '<td>' + resvSTime + ' ~ ' + resvETime + '</td>';
   	}
	var popContent = '';
	popContent += '<tr>';
	popContent += '		<td>이름</td>';
	popContent += '		<td>' + resvInfo.ptNm + '</td>';
	popContent += '</tr>';
	popContent += '<tr>';
	popContent += ' 	<td>휴대전화</td>';
	popContent += ' 	<td>' + resvInfo.ptPhone + '</td>';
	popContent += '</tr>';
	popContent += '<tr>';
	popContent += ' 	<td>시간</td>';
	popContent += 			popTime;
	popContent += '</tr>';
	if(resvInfo.ptNm.indexOf('!') == 0){
		popContent += '<tr>';
		popContent += ' 	<td colspan="2" style="width:180px; font-size:0.5em;">';
		popContent += ' 		<span style="color:red;" >*</span> 예약 미이행이 잦은 환자입니다!';
		popContent += ' 	</td>';
		popContent += ' 	<td style="display:none;"></td>';
		popContent += '</tr>';
	}
	
	$(element).popover({
   		title: $('<div/>', {
    		class	: 'popoverResvTitle',
    		text	: '의사 - ' + resvInfo.empNm
   		}).css({
        	'background': info.event.backgroundColor,
        	'color': '#ffffff'		//event.textColor
      	}),
	   	content: $('<table />', {
	   		class: 'card popoverResvInfo'
		})
		.append(popContent),
	   	trigger		: 'hover',
     	placement	: popLocation,
      	html		: true,
     	container	: 'body'
	}).popover('show');	
}

function filter(arg){
	// 1. 이벤트 개수만큼 실행 된다 -> 이벤트 하나씩 온다??
	var show_emp = true;
	var show_state = true;
	var show_pt = true;
	
	var empNums = $('#emp_filter').val();
	if (empNums && empNums.length > 0) {
	  if (empNums[0] == "all") {
	    show_emp = true;
	  } else {
	    show_emp = empNums.indexOf(arg.event.extendedProps.empNum) >= 0;
	  }
	}
	
	var states = $('#type_filter').val();
	if (states && states.length > 0) {
	  if (states[0] == "all") {
	    show_state = true;
	  } else {
	    show_state = states.indexOf(arg.event.extendedProps.status) >= 0;
	  }
	}
	
	var ptInfo = $("#ptSearch").val();
	if(ptInfo != ''){
		var ptNum = ''; 
		var ptNm = ''; 
		
		if( ptInfo.indexOf("(") >= 0 ){
			ptNum = ptInfo.split("(")[1].split(")")[0];	// 환자 번호
			ptNm = ptInfo.split("(")[0];				// 환자 이름
			var show_pt_Num = arg.event.extendedProps.ptNum.indexOf(ptNum) >= 0;
			var show_pt_Nm = arg.event.extendedProps.ptNm.indexOf(ptNm) >= 0;
			var show_pt = show_pt_Num && show_pt_Nm;
		} else {
			ptNm = ptInfo.split("(")[0];	// 환자 이름
			show_pt = arg.event.extendedProps.ptNm.indexOf(ptNm) >= 0;
		}
		
	}
	
	if(show_emp && show_state && show_pt){
		arg.el.style.display = "";	// block flex??
		//	arg.el.style.removeProperty("display");			 
		arg.el.style.color = arg.backgroundColor;
	} else {
		arg.el.style.display = "none";
	};	
}

function Monthfilter(arg){
	// 1. 이벤트 개수만큼 실행 된다 -> 이벤트 하나씩 온다??
	var show_emp = true;
	var show_state = true;
	var show_pt = true;
	
	var empNums = $('#emp_filter').val();
	if (empNums && empNums.length > 0) {
	  if (empNums[0] == "all") {
	    show_emp = true;
	  } else {
	    show_emp = empNums.indexOf(arg.event.extendedProps.empNum) >= 0;
	  }
	}
	
	var states = $('#type_filter').val();
	if (states && states.length > 0) {
	  if (states[0] == "all") {
	    show_state = true;
	  } else {
	    show_state = states.indexOf(arg.event.extendedProps.status) >= 0;
	  }
	}
	
	var ptInfo = $("#ptSearch").val();
	if(ptInfo != ''){
		var ptNum = ''; 
		var ptNm = ''; 
		
		if( ptInfo.indexOf("(") >= 0 ){
			ptNum = ptInfo.split("(")[1].split(")")[0];	// 환자 번호
			ptNm = ptInfo.split("(")[0];				// 환자 이름
			var show_pt_Num = arg.event.extendedProps.ptNum.indexOf(ptNum) >= 0;
			var show_pt_Nm = arg.event.extendedProps.ptNm.indexOf(ptNm) >= 0;
			var show_pt = show_pt_Num && show_pt_Nm;
		} else {
			ptNm = ptInfo.split("(")[0];	// 환자 이름
			show_pt = arg.event.extendedProps.ptNm.indexOf(ptNm) >= 0;
		}
	}
	
	if(show_emp && show_state && show_pt){
		arg.el.style.display = "";	// block flex??
		arg.el.style.color = arg.backgroundColor;	
	} else {
		arg.el.style.display = "none";
	};	
}