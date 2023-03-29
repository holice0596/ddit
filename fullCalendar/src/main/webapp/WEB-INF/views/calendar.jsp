<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<!-- ===================[fullcalendar 5.8.0 CDN]===================== -->
<!-- <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' /> -->
<!-- <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script> -->
<!-- fullcalendar 언어 CDN -->
<!-- <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script> -->
<!-- ===================[fullcalendar 5.8.0 CDN]===================== -->

<!-- ===================[fullcalendar 6.1.4 CDN]===================== -->
<!--  fullcalendar 6.1.4버전 CDN -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js"></script>
<!-- fullcalendar 6.1.4버전 언어 설정 -->
<script src="/resources/fullcalendar/ko.global.min.js"></script>
<!-- ===================[fullcalendar 6.4.1 CDN]===================== -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<style>
/* body 스타일 */
html, body {
 	overflow: hidden;
/* 	font-family: Arial, Helvetica Neue, Helvetica, sans-serif; */
	font-size: 14px;
}
/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
.fc-header-toolbar {
	padding-top: 1em;
	padding-left: 1em;
	padding-right: 1em;
}

/* .modal-backdrop { 
	position: fixed; 
	background: rgba(0, 0, 0, 0.8); 
 } */

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
	border:solid 1px;
	border-radius: 10px;
	width: 400px;
/* 	height: 200px; */
}
</style>
</head>
<script>

(function() { // 표현식 함수
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
    	var modal = new bootstrap.Modal(modalEl);
        
        var title = $("#calendar_title");		// 일정 제목
        var content = $("#calendar_content"); 	// 일정 내용
        var account = $("#account");			// 거래처
        var loc = $("#loc");					// 장소
        var schType = $("#schType");			// 타입
        var color = $("#color");				// 색상
        
        var startTime = $("#startTime");		// 시작시간
        var endTime = $("#endTime");			// 종료 시간

        var start = $("#calendar_start_date");
        var end = $("#calendar_end_date");
        var saveBtn = $("#addCalendar");			// modal [추가] 버튼
        var closeBtn = $("#closeBtn");				// modal [x] 버튼
        var modalCloseBtn = $("#modalCloseBtn");	// modal [취소] 버튼
        var deleteBtn = $("#deleteCalendar");		// 삭제 버튼
    	 var flag = false;
        
        
       /* 
       		//일정 등록
       		$(saveBtn).on('click', function() {
        	
        	 var title = $("#calendar_title");		// 일정 제목
             var content = $("#calendar_content"); 	// 일정 내용
             var account = $("#account");			// 거래처
             //var location = $("#location");			// 장소
             var schType = $("#schType");			// 타입
             var color = $("#color");				// 색상
             
             var startTime = $("#startTime");		// 시작시간
             var endTime = $("#endTime");			// 종료 시간

             var start = $("#calendar_start_date");
             var end = $("#calendar_end_date");
             var saveBtn = $("#addCalendar");			// modal [추가] 버튼
             var closeBtn = $("#closeBtn");				// modal [x] 버튼
             var modalCloseBtn = $("#modalCloseBtn");	// modal [취소] 버튼
             var deleteBtn = $("#deleteCalendar");		// 삭제 버튼
             
     	   
     });	// saveBtn end
     
     */
     
     
     
     saveBtn.on("click", function(){
    	 console.log("flag == ", flag);
    	 var title = $("#calendar_title");		// 일정 제목
         var content = $("#calendar_content"); 	// 일정 내용
         var account = $("#account");			// 거래처
         //var location = $("#location");		// 장소
         var schType = $("#schType");			// 타입
         var color = $("#color");				// 색상
         
         var startTime = $("#startTime");		// 시작시간
         var endTime = $("#endTime");			// 종료 시간

         var start = $("#calendar_start_date");
         var end = $("#calendar_end_date");
         var saveBtn = $("#addCalendar");			// modal [추가] 버튼
         var closeBtn = $("#closeBtn");				// modal [x] 버튼
         var modalCloseBtn = $("#modalCloseBtn");	// modal [취소] 버튼
         var deleteBtn = $("#deleteCalendar");		// 삭제 버튼
         
    	if(flag == true){ 						// 일정 등록
	     	   titleInput = title.val();
	     	   contentInput = content.val();
	     	   
	     	   startTimeInput = startTime.val(); 
	     	   endTimeInput = endTime.val(); 
	     	   alert("startTimeInput : " + startTimeInput + ", endTimeInput : " + endTimeInput);
	     	   
	     	   startInput = document.getElementById('calendar_start_date').value;
	     	   endInput = document.getElementById('calendar_end_date').value;
	     	   console.log("startInput : " + startInput);
	     	   
	            console.log("title : " + titleInput + ", content : "+ contentInput + "startDate : " + startInput);
	     	   
	           // 입력값을 받아와서 디비에 저장
	           $.ajax({
	     	   	type : "POST",
	     	   	url : "/ddit/register",
	     	   	data :{
	     		   	'title' : titleInput,
	     		   	'content' : contentInput,
	     		   	'startDate' : startInput+"T"+startTimeInput,
	     		   	'endDate' : endInput+"T"+endTimeInput,
	     	   	},
	     	   	success : function(res){
	     		   	alert("일정이 추가되었습니다.");
	     		   	location.reload();
			            if(title == null || title == ""){
			              alert("일정의 제목을 입력하세요.");  
			            }
			            if(content == null || content == ""){
			            	alert("일정의 내용을 입력하세요");
			            }
			            if(new Date(endInput) - new Date(startInput) < 0){
			               alert("종료일이 시작일보다 먼저입니다.");                 
			            }
	     	   	}
	        	});
	           
	           modal.hide();
	           
	           $("#calendar_content").val('');
	           $("#calendar_start_date").val('');
	           $("#calendar_end_date").val('');
	        
	           
    		
    	}else{
	     	 calNo = $("#calNo").val();
	     	 title = $("#calendar_title").val();
	     	 content = $("#calendar_content").val();
	     	 startDate = $("#calendar_start_date").val();
	     	 startTime = $("#startTime").val();
	     	 endDate = $("#calendar_end_date").val();
	     	 endTime = $("#endTime").val();
	     	 console.log(">> 수정 : " + calNo + ", " + title +", "+ content+", " + startDate +", "+ startTime);
	     	 var param={
	     			 'calNo' : calNo,
	     			 'title' : title,
	     			 'content' : content,
	     			 'startDate' : startDate+"T"+startTime,
	     			 'endDate' : endDate+"T"+endTime
	     	 }
	     	 $.ajax({
	     		 type : "post",
	     		 url : "/ddit/update",
	     		 data : param,
	     		 dataType : "json",
	     		 success: function(req){
	     			 console.log(req);
	     		 }
	     	 });	//ajax end
	     	 alert("수정이 완료되었습니다.");
	     	 modal.hide();
	     	 location.reload();
        }
     })//:::saveBtn End
	
     deleteBtn.on("click",function(){	// 삭제버튼 클릭시 이벤트 발생
     	 calNo = $("#calNo").val();
    	 var param ={
    			   'calNo' : calNo,
           	   }
		
    	if(confirm("정말 삭제하시겠습니까?")){
    		$.ajax({
           	   type : "POST",
           	   url : "/ddit/remove",
           	   data :param,
        	   dataType : "json",
           	   success : function(req){	// => ?? ajax에서 success로 안넘어오네??
           		  console.log("req ??" + req);
        	   }
    		});
    		
			alert(title+"삭제되었습니다.");
// 			event.remove();	// 캘린더 화면에서 해당 일정 삭제
			modal.hide();
			location.reload();
			
		}	// if(confirm) end
		
     });
		
            	// modal [x] 버튼 
               closeBtn.on("click",function(){
                // modal 창 내용 초기화
              	calendar.unselect();
              	console.log("x버튼 클릭")
               });
              	;
               
            	// modal [취소] 버튼
               modalCloseBtn.on("click",function(){
 	              // modal 창 초기화
            	  var test =   $("#calendar_content").val();
              	 calendar.unselect();
              	 console.log("취소버튼 클릭")
               });
		
		
    	console.log("don )data가 잘 넘어오니??? : "+ JSON.stringify(data));	// log로 controller에서 넘어온 데이터 정보
// 		console.log("no[0] : " + data[0].no);	// 이렇게 하면 no값은 가져오긴 하는데..이걸 어떻게 써먹어
//		console.log("content[0] : " + data[0].content);	
    	
         // calendar element 취득
         var calendarEl = $('#calendar')[0];
         
         // full-calendar 생성하기
         var calendar = new FullCalendar.Calendar(calendarEl, {
            height : '700px', 				// calendar 높이 설정
            expandRows : true, 				// 화면에 맞게 높이 재설정
//             slotMinTime : '06:00', 		// Day 캘린더에서 시작 시간 설정
//             slotMaxTime : '24:00', 		// Day 캘린더에서 종료 시간 설정

            // 해더에 표시할 툴바
            headerToolbar : {
               left : 'prev,next,today',
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
            	var flag = true;
            	console.log("info >> ",info);
               //console.log("date info >>> " + info.startStr + ", " + info.endStr+", defId : ");
               
               $("#deleteCalendar").hide();	// '삭제' 버튼이 남아있는 것을 숨김
               modal.show();
               
               
//                var title = $("#calendar_content").val();
               console.log("title : ",title);
               
               if(title == null || title == ""){
            	   $("#addCalendar").text("추가");
               }
               
               $('#calendarModal').modal()
//                var saveBtn = document.getElementById('addCalendar');	// 모달 창 [추가] 버튼
               var saveBtn = $("#addCalendar");
               
               $("#calendar_start_date").val(info.startStr);			// 일정 시작일
               $("#calendar_end_date").val(info.endStr);				// 일정 종료일
				
               
               
               calendar.unselect()	// 일정 선택 취소 시 실행될 코드 작성
               
            },	// select end
           	
//             드래그&드랍으로 이벤트 수정하기 (하고싶다)
// 			eventDrop : function(info){
// 				console.log(lnfo)
				
// 				var events = new Array();	// Json 데이터를 받기위한 배열
// 				var obj = new Object();
				
// 				obj.title = info.event._def.title;
// 			},
            
            eventClick: function(info){	// 등록된 일정을 클릭했을 경우 이벤트 발생
            	console.log("info >>",info.event); 
                console.log(calendar.getEvents())// 캘린더안에 어떻게 데이터가 담겨있는지 확인할때 사용
            	//console.log("clicked : " + info.event.title + "// content : "+ info.event.extendedProps.content +" // start : "+ info.event.startStr+" // end :  "+ info.event.endStr) ;	// 등록된 일정 클릭시 해당 일정의 제목, 시작일 정보
            	
            	//console.log("no >>> ",info.event.extendedProps.no);
            	$("#calNo").val(info.event.extendedProps.no);
            	var startDate = info.event.startStr.split('T')[0];
            	var startTime = (info.event.startStr.split('T')[1]).split('+')[0];
            	var endDate = info.event.endStr.split('T')[0];
            	var endTime = (info.event.endStr.split('T')[1]).split('+')[0];
            	//console.log(">>>> 시간 : " + startTime +", " + endTime);
            	
            
                 title = info.event.title;
                 content = info.event.extendedProps.content;
                 deleteBtn = $("#deleteCalendar");
                 
                 if(title != null || title != ''){
                	 $("#addCalendar").text('수정');
                	 deleteBtn.css("display", "inline");
                 }
                 
                 
                 modal.show();
                 
                 $('#calendarModal').modal()
                 
                 
//                  startInput = info.event.startStr
//           	   	 endInput = info.event.endStr;
//           	     console.log("startInput : " + startInput);
                 
                 $("#calendar_title").val(title);
                 $("#calendar_content").val(content);
                 $("#calendar_start_date").val(startDate);
                 $("#startTime").val(startTime);
                 $("#calendar_end_date").val(endDate);
                 $("#endTime").val(endTime);
                 
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
			<div class="modal-content" id="modalBox" style="display:block;">
				<div class="modal-header">
					<span id="closeBtn" class="close" data-dismiss="modal" aria-label="Close" style="margin-left:380px; display:inline;">X</span>
					<h3 class="modal-title" id="exampleModalLabel" style="margin:0">일정 등록</h3>
					<hr/>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<input type="text" id="calNo" name="calNo" value=""><br/>		<!-- 일정번호 -->
						<div>
							일정 제목 
							<input type="text" class="form-control" id="calendar_title" name="calendar_title"><br/><br/> 
						</div>
						<div>
							 거래처　 
							 <input type="text" class="form-control" id="account" name="account">
							 <br><br>
<!-- 							<select class="account" name="account"> -->
<!-- 							<option disabled selected>거래처 선택</option> -->
<!-- 							<option value="account1">거래처1</option> -->
<!-- 							<option value="account2">거래처2</option> -->
<!-- 							<option value="account3">거래처3</option> -->
<!-- 							</select> <br/><br/>  -->
						</div>
						<div>
							시작 날짜
							<input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
							<input type="time" id="startTime" name="startTime"> <br><br>
						</div>
						<div>
							종료 날짜
<!-- 							<label for="taskId" class="col-form-label">종료 날짜</label>  -->
<!-- 							<br/><br/> -->
							<input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
							<input type="time" id="endTime" name="endTime"> <br><br>
						</div>
						<div>
							내용<br><br>
<!-- 							<label for="taskId" class="col-form-label">일정 내용</label>  -->
							<textarea class="form-control" id="calendar_content" name="calendar_content" 
								rows="10" cols="50" style="margin-left:10px"></textarea> <br><br>
						</div>
						<div class="row">
							<select class="loc" name="loc">
							<option disabled selected>장소 선택</option>
							<option value="room301">회의실 301호</option>
							<option value="room302">회의실 302호</option>
							<option value="room303">회의실 303호</option>
							</select>
							
							<select class="schType" name="schType">
							<option disabled selected>타입 선택</option>
							<option value="type1">내부일정</option>
							<option value="type2">거래처</option>
							<option value="type3">회의</option>
							</select>
							
							<select class="color" name="color">
							<option disabled selected>색상 선택</option>
							<option value="red">빨간색</option>
							<option value="orange">주황색</option>
							<option value="blue">파란색</option>
							<option value="green">초록색</option>
							</select>
							<br/><br/> 
						</div>
						<div>
							<input type="checkbox" name="read" value="Y" > 일정 비공개
						</div>
						<input type="text" id="empNo" name="empNo" value=""><br/><br/>	<!-- 사원번호 : 세샨값 가져오기 -->
						
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