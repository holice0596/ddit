<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>

<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


<style>
/* body 스타일 */
html, body {
	overflow: hidden;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}
/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
.fc-header-toolbar {
	padding-top: 1em;
	padding-left: 1em;
	padding-right: 1em;
}

.modal-backdrop {
	position: fixed;
	background: rgba(0, 0, 0, 0.8);
}

#calendarModal {
	position: fixed;
	top: 50%;
	left: 50%;
	width: 200px;
	/*    background-color: #2C3E50;  */
	/*     background-color: #fff;  */
}

#modalBox {
	position: absolute;
	transform: translate(-50%, -50%);
	padding: 15px;
	position: absolute;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	border-color: black 1px;
	border-radius: 10px;
	width: 400px;
	height: 200px;
}
</style>
</head>
<script>


(function() {
      $(function() {
	//아작났어유..피씨다타써..??? ajax 쓰는법
	var request = $.ajax({
		url:"/ddit/list", // 변경하기
	    type:"post",
	});
	
    request.fail(function(jqXHR, textStatus){
    	alert("오류발생!! : " + textStatus);
    });
    
	request.done(function(data){
    	var modalEl = document.getElementById('calendarModal');
//     	var modalEl = $('#calendarModal');
        
        var startInput = $("#calendar_start_date").val();
        var endInput = $("#calendar_end_date").val();
        var saveBtn = $("#addCalendar");			// modal [추가] 버튼
        var closeBtn = $("#closeBtn");				// modal [x] 버튼
        var modalCloseBtn = $("#modalCloseBtn");	// modal [취소] 버튼
		
		
		
    	console.log("don )data가 잘 넘어오니??? : "+ JSON.stringify(data));	// log로 controller에서 넘어온 데이터 정보
		console.log("no[0] : " + data[0].no);	// 이렇게 하면 no값은 가져오긴 하는데..이걸 어떻게 써먹어
    	
         // calendar element 취득
         var calendarEl = $('#calendar')[0];
         
         // full-calendar 생성하기
         var calendar = new FullCalendar.Calendar(calendarEl, {
            height : '700px', 				// calendar 높이 설정
            expandRows : true, 				// 화면에 맞게 높이 재설정
//             slotMinTime : '00:00', 		// Day 캘린더에서 시작 시간
//             slotMaxTime : '24:00', 		// Day 캘린더에서 종료 시간

            // 해더에 표시할 툴바
            headerToolbar : {
               left : 'prev,next today',
               center : 'title',
               right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
            },
            initialView : 'dayGridMonth', 	// 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
            //initialDate: '2023-01-01', 	// 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
            navLinks : true, 				// 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
            editable : true, 				// 수정 가능 여부
            selectable : true, 				// 달력 일자 드래그 설정가능
            nowIndicator : true, 			// 현재 시간 마크
            dayMaxEvents : true, 			// 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
            locale : 'ko', 					// 한국어 설정
            
            select : function(info) { 		// 캘린더에서 드래그 (일정 등록)이벤트를 생성할 수 있다.
               console.log("date info >>> " + info.startStr + ", " + info.endStr);
               
               var modal = new bootstrap.Modal(modalEl);
               
               $("#deleteCalendar").hide();	// '삭제' 버튼이 남아있는 것을 숨김
               modal.show();
               
               var title = $("#calendar_content").val();
               console.log("title : ",title);
               
               if(title == null || title == ""){
            	   $("#addCalendar").text("추가");
               }
               
//                $('#calendarModal').modal( {backdrop: 'static' } )	// 모달 backdrop : 이게 왜 안먹힐까요..?????
               $('#calendarModal').modal()
               var saveBtn = document.getElementById('addCalendar');	// 모달 창 [추가] 버튼
               
               $("#calendar_start_date").val(info.startStr);			// 일정 시작일
               $("#calendar_end_date").val(info.endStr);				// 일정 종료일
               
               // modal 창 초기화
               closeBtn.on("click",function(){
              	 $("#calendar_content").val("");
              	 $("#calendar_start_date").val("");
              	 $("#calendar_end_date").val("");
//               	 $('#calendar').calendar('unselect');
              	calendar.unselect();
               });
               
               // modal 창 초기화
               modalCloseBtn.on("click",function(){
              	 $("#calendar_content").val("");
              	 $("#calendar_start_date").val("");
              	 $("#calendar_end_date").val("");
//               	$('#calendar').fullcalendar('unselect');
              	calendar.unselect();
               });
               
               $(saveBtn).on('click', function() {
            	   
            	   title = $("#calendar_content").val();
            	   startInput = document.getElementById('calendar_start_date').value;
            	   endInput = document.getElementById('calendar_end_date').value;
            	   console.log("startInput : " + startInput);
            	   
                   console.log("title : " + title + "startDate : " + startInput);
            	   
                  // 입력값을 받아와서 디비에 저장
                  $.ajax({
            	   	type : "POST",
            	   	url : "/ddit/register",
            	   	data :{
            		   	'title' : title,
            		   	'startDate' : startInput,
            		   	'endDate' : endInput,
            	   	},
            	   	success : function(res){
            		   	alert("일정이 추가되었습니다.");
			            if(title == null || title == ""){
			              alert("내용을 입력하세요.");  
			            }
			            if(new Date(endInput) - new Date(startInput) < 0){
			               alert("종료일이 시작일보다 먼저입니다.");                 
			            }
            	   	}
               	});
                  
			    // addEvent를 통해 캘린더 화면에 일정 추가
			    calendar.addEvent({
			        title : title,
			        start : startInput,
			        end : endInput,
			        allDay: info.allDay   // allDay로 설정됨
			    });
                  
                  modal.hide();
                  $("#calendar_content").val('');
                  $("#calendar_start_date").val('');
                  $("#calendar_end_date").val('');
               
                  
            });	// saveBtn end
            
//             	$('#calendar').fullCalendar('unselect');
               calendar.unselect()	// 일정 선택 취소 시 실행될 코드 작성
               
            },	// select end
           	
//             드래그&드랍으로 이벤트 수정하기 (하고싶다)
// 			eventDrop : function(info){
// 				console.log(lnfo)
				
// 				var events = new Array();	// Json 데이터를 받기위한 배열
// 				var obj = new Object();
				
// 				obj.title = info.event._def.title;
// 			},
            
//             dateClick: function(info){	// 날짜 클릭했을 경우 날짜 정보가 alert에 나옴
//             	alert("clicked : " + info.dateStr);
//             },
            eventClick: function(info){	// 등록된 일정을 클릭했을 경우 이벤트 발생
            	console.log("clicked : " + info.event.title +" // "+ info.event.startStr+" // "+ info.event.endStr) ;	// 등록된 일정 클릭시 해당 일정의 제목, 시작일 정보
            	
            	var calNo = info.event.calNo
            	
            	// info.event.startStr, info.event.endStr은 시간정보까지 포함되어있어서
            	// 만약 시간정보까지 등록하려면 split 하지 않고
            	// var startDate = info.event.startStr 이런식으로 사용하면 된다.
            	
            	var startDate = info.event.startStr.split('T')[0];
            	var endDate = info.event.endStr.split('T')[0];
            	
            	console.log("calNo : "+ calNo +"startDate : " + startDate + ", endDate : " + endDate);
            
            	//모달창 오픈
            	 var modalEl = document.getElementById('calendarModal');
                 var modal = new bootstrap.Modal(modalEl);
                 var title = info.event.title;
                 var deleteBtn = $("#deleteCalendar");
                 
                 if(title != null || title != ''){
                	 $("#addCalendar").text('수정');
                	 deleteBtn.css("display", "block");
                 }
                 
                 
                 modal.show();
                 
                 $('#calendarModal').modal()
                 
                 
                 var titleInput = $("#calendar_content").value;
                 startInput = document.getElementById('calendar_start_date').value;
          	   	 endInput = document.getElementById('calendar_end_date').value;
          	     console.log("startInput : " + startInput);
                 var calNo = calNo;
                 
                 console.log("saveBtn >>> " + saveBtn + "// event : " + info.event + "//calNo : "+ info.calNo);
                 
                 console.log("title : " + title);
                 console.log("eventClick START : " + info.event.start);
                 
                 $("#calendar_content").val(title);
                 $("#calendar_start_date").val(info.event.startStr);
                 $("#calendar_end_date").val(info.event.endStr);
                 
                 // modal 창 초기화
                 closeBtn.on("click",function(){
                	 $("#calendar_content").val("");
                	 $("#calendar_start_date").val("");
                	 $("#calendar_end_date").val("");
//                 	 $('#calendar').calendar('unselect');
                	calendar.unselect();
                 });
                 
                 // modal 창 초기화
                 modalCloseBtn.on("click",function(){
                	 $("#calendar_content").val("");
                	 $("#calendar_start_date").val("");
                	 $("#calendar_end_date").val("");
//                 	$('#calendar').fullcalendar('unselect');
                	calendar.unselect();
                 });
            	
                 deleteBtn.on("click",function(){	// 삭제버튼 클릭시 이벤트 발생
                	 title = $("#calendar_content").val();
                     var startInput = $("#calendar_start_date").val();
                     var endInput = $("#calendar_end_date").val();
                	 var param ={
	                   		   'title' : title,
	                   		   'startDate' : startInput
	                   	   }
            		
	            	if(confirm("정말 삭제하시겠습니까?")){
	            		$.ajax({
	                   	   type : "POST",
	                   	   url : "/ddit/remove",
	                   	   data :param,
	                	   dataType : "json",
	                   	   success : function(req){
	                   		  console.log("req ??" + req);
	                	   }
	            		});
	            		
						alert(title+"삭제되었습니다.");
						console.log("info >> ",info)
						info.event.remove();	// 캘린더 화면에서 해당 일정 삭제
						modal.hide();
						
					}	// if(confirm) end
					
                 });
                 
            },
           events : data

         });
         // 캘린더 랜더링 (캘린더 그리기)
         calendar.render();
      });
    });
   })(); 
</script>
<body>

	<!-- modal -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: none; z-index: 2;">
		<div class="modal-dialog" role="document">
			<div class="modal-content" id="modalBox">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
					<button type="button" id="closeBtn" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
					
						<label for="taskId" class="col-form-label">일정 내용</label> 
						<input type="text" class="form-control" id="calendar_content" name="calendar_content"><br> 
						
						<label for="taskId" class="col-form-label">시작 날짜</label> 
						<input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date"><br> 
						
						<label for="taskId" class="col-form-label">종료 날짜</label> 
						<input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date"><br>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
					<button type="button" class="btn btn-delete" id="deleteCalendar" style="display: none">삭제</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal" id="modalCloseBtn">취소</button>
				</div>
			</div>
		</div>
	</div>

	<!-- calendar -->
	<div id='calendar-container'>
		<div id='calendar'></div>
	</div>

</body>
</body>
</html>