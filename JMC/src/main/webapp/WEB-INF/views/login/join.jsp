<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/header.jsp" />
<style type="text/css">
form{
	justify-content: center;
	align-items: center;  
	display: flex;
 	min-height: 100vh; 
 	flex-direction:column; 
	font-weight: bold;
	width: 1000px;
	height: 100%;
	padding-top: 100px;
    padding-bottom: 300px;
    margin: 0 auto;
    font-size: 23px;
}

.box1{
	display: flex;
	flex-direction:column;  
	justify-content: flex-start;
	width: 380px;
}

.labelbox{
}



.btn {
	border: 2px solid #333 ;
	background-color: #333;
	border-radius : 7px;
	color: #fff;
	width: 355px;
	height : 35px;
	font-size: 20px;
	font-weight : bold;
	display: block;
/*  margin: 0 auto; */

}
 .btn1 {
	border: 1px solid #333 ;
	background-color: #333;
	border-radius : 7px;
	color: #fff;
	width: 70px;
	height : 28px; 
	font-size: 15px; 
	font-weight : bold;
	display: block;
	 margin: 0 auto; 

} 

.btn1{
	padding: 0px 0px 0px 0px;
    margin: 0px 0px 0px 0px;
}

.select{
	padding: 15px 10px;
}
.select input[type=text]{
	border-radius : 7px;
}
.select input[type=date]{
	border-radius : 7px;
}
.select input[type=password]{
	border-radius : 7px;
}
.select input[type=radio]{
	display: none;
}
.select input[type=number]{
	border-radius : 7px;
}
.select input[type=radio]+label{
	border-radius : 7px;
	display: inline-block;
	cursor: pointer;
	height: 24px;
	width: 173px;
	border: 1px solid #333;
	line-height:  24px;
	text-align: center;
	font-weight: bold;
	font-size: 13px;
}
.select input[type=radio]+lable{
	background-color: #fff;
	color :#333;
}
.select input[type=radio]:checked+label{
	background-color: #333;
	color: #fff;
}





</style>
</head>
<body>
<div id="join_continner">
<form action="/login/join" method="post" onsubmit="return submitCheck();"> 
<h1 style="font-size:63px;">JAMANCHO</h1> 
<!-- <div class=""> -->
<div class="box1">
	<div class="labelbox">
		<label for="userId">아이디*</label>
	</div>
	<div class="box2">
		<input type="text" name="userId" id="userId">
		<button type="button" id="idchk" name="idchk" onclick="idcheck()">중복확인</button>
	</div>	
	<div class="msgbox">
		<span id="id_msg"></span>	
	</div>	
</div>
 

<div class="box1">
	<div class="labelbox">
		<label for="userPw">패스워드*</label>
	</div>	
	<div class="box2">
		<input type="password" name="userPw" id="userPw">
	</div>
</div>


<div class="box1">
	<div class="labelbox">
	<label for="userPw_chk">패스워드 확인*</label>
	</div>
	<div class="box2">
		<input type="password" name="userPw_chk" id="userPw_chk">
	</div>
</div>


<div class="box1">
	<div class="labelbox">
	<label for="userName">이름*</label>
	</div>
	<div class="box2">
		<input type="text" name="userName" id="userName">
	</div>
</div>


<div class="box1">
<div class="labelbox">
	<label for="birth">생년월일*</label>
</div>	
	<div class="box2">
		<input type="date" name="birth" id="birth">
	</div>	
</div>


<div class="box1">
<div class="labelbox">
	<label>성별*</label>
</div>	
	<div class="select">
		<input type="radio" id="select" name="gender" value="M"><label for="select">남자</label>	
		<input type="radio" id="select2" name="gender" value="F"><label for="select2">여자</label>
	</div>
</div>

<div class="box1">
<div class="labelbox">
	<label>이메일*</label>
</div>	
	<div class="box2">
		<input type="text" name="email" id="userEmail1">
		<select name="email" id="userEmail2">
			<option>@naver.com</option>
			<option>@google.com</option>
			<option>@daum.net</option>
			<option>@hanmail.com</option>
		</select>
		<br>
		<input type="text" name="email_checknumber" id="email_checknumber" placeholder="인증번호를 입력해주세요">
		<button type="button" id="email_checkbtn" name="email_checkbtn">본인인증</button>
	</div>
	<div class="msgbox">	
		<span id="mail-check-warn"></span>
	</div>
</div>


<div class="box1">
<div class="labelbox">
	<label for="phone">휴대전화*</label>
</div>	
	<div class="box2">
		<input type="tel" name="phone" id="phone">
	</div>
</div>


<div class="box1">
<div class="labelbox">
	<label>주소*</label>
</div>	
	<div class="box2">
		<input type="text" name="addr1" id="addr1" placeholder="우편번호">
		<input type="button" onclick="findAddress()" value="우편번호 찾기">
		<input type="text" name="addr2" id="addr2" placeholder="도로명주소">
		<input type="text" name="addr3" id="addr3" placeholder="상세주소">
		<input type="text" id="addr4" placeholder="참고항목">
	</div>	
</div>
<a href="/login/login"><button class="btn" id="submit">가입하기</button></a><br>
<!-- </div> -->

</form> 
</div>

<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
 function idcheck() {
		
		var userId = $('#userId').val();
		
		$.ajax({
		    type : 'post',           // 타입 (get, post, put 등등)
		    url : '/login/idcheck',           // 요청할 서버url
		    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
		    data : {userId:userId} , // 보낼 데이터 (Object , String, Array)
		    success : function(res) { // 결과 성공 콜백함수
		        if(res == 1){
		        	$('#id_msg').html('이미 사용중인 아이디입니다.');
		        	$('#id_msg').css('color,#dc3545');
		        }else{
		        	$('#id_msg').html('사용 가능한 아이디입니다.');
		        	$('#id_msg').css('color,#2fb380');
		        }
		    	console.log(res);
		    },
		    error : function() { // 결과 에러 콜백함수
		        alert('서버요청 실패');
		    }
		}) // ajax end			
 }	
 	// 주소 api
	function findAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("addr4").value = extraAddr;
	            
	            } else {
	                document.getElementById("addr4").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('addr1').value = data.zonecode;
	            document.getElementById("addr2").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("addr3").focus();
	        }
	    }).open();
	}
	

	// 이메일 인증
		var code = ""; // 인증번호 저장을 위한 코드
		var isCertification = false; // 인증 여부 변수
	
		$('#email_checkbtn').click(function() {
		  const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
		  console.log('완성된 이메일: ' + email); // 이메일 오는지 확인
		  
		  const checkInput = $('#email_checknumber'); // 인증번호 입력하는 곳
		  
		  $.ajax({
		    type: 'GET',
		    url: '/login/mailCheck?email=' + email, // GET 방식이라 Url 뒤에 email을 뭍힐 수 있다.
		    dataType: 'text',
		    success: function(data) {
		      /* console.log('data: ' + data); */
		      checkInput.attr('disabled', false); // 인증번호 입력이 가능하도록 속성 변환
		      code = data;
		      isCertification = true; // 인증이 완료되었음을 표시
		      alert('인증번호가 전송되었습니다.');
		    },
		    error : function() { // 결과 에러 콜백함수
		        alert('서버요청 실패');
		    }      
		  }); // end ajax
		}); // end send email

	// 인증번호 비교 
// 	// blur -> focus가 벗어나는 경우 발생
 		$('#email_checknumber').blur(function () {
			const inputCode = $('#email_checknumber').val();
			const $resultMsg = $('#mail-check-warn');
			
			if(inputCode === code){
				$resultMsg.html('인증번호가 일치합니다.');
				$resultMsg.css('color','green');
				$('#email_checkbtn').attr('disabled',true);
				$('#userEamil1').attr('readonly',true);
				$('#userEamil2').attr('readonly',true);
				/* $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
		        $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect'); */
		       
			}else{
				$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
				$resultMsg.css('color','red');
			}
		})  


		// 인증번호가 다르면 sumit 안되게
		$('#submit').click(function submitCheck() {
			if(!isCertification){
				alert('인증이 완료되지 않았습니다.');
				return false;
			}else{
				return true;
			}
		})
		
</script>

<c:import url="../layout/footer.jsp" />


