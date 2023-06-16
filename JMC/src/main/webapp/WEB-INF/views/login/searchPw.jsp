<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/header.jsp" />

<style type="text/css">

.container{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-top : 100px;
}

.searchbox{
	display:flex;
/* 	justify-content:center; */
	align-items: center;
	flex-direction:column;
	width:  680px;
	height:  750px;	
	margin-bottom: 350px;
	border: 1px solid #371e06;
	border-radius: 10px 10px 10px 10px;
	box-shadow: 5px 5px 15px;
	margin-top: 100px;
	
}
#searchForm{
	padding-top: 45px;
}
.namebox{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-top: 120px;
}


label{
	font-size: 24px;
	font-weight: bold;
}

input[type=text]{
	 height:28px;
     width:320px;
     border-radius: 4px;
     font-size: 20px; 
     outline: none; 
     color : #371e06;
}

input:focus{
   border-color:#371e06;
   outline: none !important;
   box-shadow: 0 0 10px #371e06;
}

input#userEmail1{
	margin-bottom: 10px;
}

div.inputPw{
	padding-bottom: 30px;
}

select{
	 height:28px;
     width:200px;
     border-radius: 4px;
     font-size: 20px; 
     outline: none; 
     border-color:#371e06;
   	 outline: none !important;
}
select:focus{
   box-shadow: 0 0 10px #371e06;
}

.search-pwbtn{
	display: flex;
	justify-content: center;
	align-items: center;
	text-align:center;
	cursor:pointer;
}
.search-pwbtn{
	font-family: '양진체';
	display :inline-block;
	background-color: #371e06;
	color: #fff;
	height: 40px;
	width: 100px;
	background: orange;
	border-radius: 20px;
	border: none;
	font-size: 18px;
	margin-right: 20px;
	
}

.search-pwbtn:hover{
	background-color: #ffcca8;
}
#nextbtn{
	font-family: '양진체';
	display :inline-block;
	background-color: #371e06;
	color: #fff;
	height: 50px;
	width: 500px;
	background: orange;
	border-radius: 20px;
	border: none;
	font-size: 20px;
	margin-right: 20px;
	margin-top: 90px;
	
}
#nextbtn:hover{
	background-color: #ffcca8;
}
.emailSelect {
  box-sizing: border-box;
  width: 200px;
  padding: 4px;
  font-size: 14px;
  border-radius: 6px;
  height: 34px;
  font-size: 18px;
}

.option {
  padding: 4px;
  font-size: 14px;
  color: black;
  background: white;
}
.option:hover {
	border-color:#371e06;
   outline: none !important;
   box-shadow: 0 0 10px #371e06;
}



</style>


<div class="container">

<div class="searchbox">	
	<div class="namebox" style="margin-bottom:5px;">
		<h1 style="font-size: 35px;">비밀번호 찾기</h1>
	</div>

	<form action="/login/searchPw" method="post" id="searchForm"> 
		<div class="inputPw">
			<label for="userId">아이디</label>
			<div>	
				<input type="text" id="userId" name="userId">
			</div>
			<div style="padding-top:8px;">
				<span id="IdMsg"></span>
			</div>
		</div>
	
	<div class="email-group">
		<label>이메일</label>
		
		<div class="input-group">
			<input type="text" name="email" id="userEmail1">
			<select name="email" name="email" id="userEmail2">
				<option class="option">@naver.com</option>
				<option class="option">@google.com</option>
				<option class="option">@daum.net</option>
				<option class="option">@hanmail.com</option>
			</select>
			
			<div>
				<input type="text" name="email_checknumber" id="email_checknumber" placeholder="인증번호를 입력해주세요">
				<input type="button" class='search-pwbtn' id="email_checkbtn" name="email_checkbtn" value="본인인증">
			<div style="padding-top:8px;">
				<span id="emailNumMsg" style="font-size: 17px;"></span>
			</div>
		</div>
		
	<!-- 		<a href="/login/searchResultPw"> -->
			
			
			<div class="nextBtn">
				<button class="search-pwbtn" id="nextbtn">다음</button>
			</div>
		</div>	
		</div>
	</form>
</div>	 
</div> 
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){

	// FIXME: 필요 스크립트 전개 영역
    let checkID = RegExp(/^[a-zA-Z0-9]{6,20}$/);
    let checkEmail = RegExp(/^([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$/);

	$('#userId').blur(function() {
		var userId = $('#userId').val();
	
		if(userId === ''){	
			$('#IdMsg').html('아이디를 입력해 주세요');
			$('#IdMsg').css('color','red');
	//			$("#userName").focus();
			return false;
		}else if(!checkID.test(userId)){
			$('#IdMsg').html('옳지않은 형식입니다.');
			$('#IdMsg').css('color','red');
			return false;
		}else{  
			$('#IdMsg').html('');
			$('#IdMsg').css('color','#3f8ef7');
	//     	$("#birth").focus();
	    	return true;
		}
	}) //$('#userName').blur ed

})

$(document).ready(function(){
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
	// blur -> focus가 벗어나는 경우 발생
	$('#email_checknumber').blur(function () {
		const inputCode = $('#email_checknumber').val();
		const resultMsg = $('#emailNumMsg');

		if (!isCertification) {
			resultMsg.html('인증이 완료되지 않았습니다.');
			resultMsg.css('color', 'red');
		} else if (inputCode === code) {
			resultMsg.html('인증번호가 일치합니다.');
			resultMsg.css('color', 'green');
			$('#email_checkbtn').attr('disabled', true);
			$('#userEamil1').attr('readonly', true);
			$('#userEamil2').attr('readonly', true);
			$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
			$('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
		} else if (inputCode === '') {
			resultMsg.html('인증번호를 입력해주세요.');
			resultMsg.css('color', 'red');
		} else {
			resultMsg.html('인증번호가 불일치합니다. 다시 확인해주세요!.');
			resultMsg.css('color', 'red');
		}
	});

	// 인증번호가 다르면 submit 안되게
	$('#nextbtn').click(function() {
		if (!isCertification) {
			alert('인증이 완료되지 않았습니다.');
			return false;
		} else {
			return true;
		}
	});
});


</script>

<c:import url="../layout/footer.jsp" />