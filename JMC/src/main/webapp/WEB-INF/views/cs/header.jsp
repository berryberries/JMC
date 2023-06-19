<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/resources/image/faviconWhiskeyWestern.png">
<title>
	JMC  
</title>
<style type="text/css">

@font-face {
    font-family: '양진체';
    src: url('https://cdn.jsdelivr.net/gh/supernovice-lab/font@0.9/yangjin.woff') format('woff'); 
    font-weight: normal;
    font-style: normal;
}
 
body {
  background: #f5f5f5;
  font-family: '양진체';
}

header img{
	width: 100px;
	height: 100px;
}

header{
  position: sticky;
  top: 0;
  backdrop-filter: blur(30px);
  background: #371e06;
  color: white;
/*   padding-left: 120px;  */
/*   padding-right: 40px;  */
  display:flex; 
  justify-content: flex-end;
  align-items: center;
  width: 100%; 
}

header a{
	color : white;
	padding : 20px;
}

*{
  list-style: none;
}
a {
  text-decoration: none;
  color: black;
}

#header #menu{
/*   position:relative;  */
  /* z-index: 99;  */
  padding-top : 12px;
  background-color: #f5f5f5;
  height: 50px;
  text-align: center;
  margin-left: 130px;
}

#header [class*="main"] {
  background-color: #f5f5f5;
  border-radius: 5px 5px 5px 5px;
}

#header [class*="main"] ul {
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #371e06;
}
#header .main1{
  padding-left: 0px;
  height: 100%;
  width: 1600px;
  margin: 0 auto;
  display: inline-block;
}
#header .main1>li {
  float: left;
  width: 15%;
  line-height: 50px;
  position: relative;
  
}
#header .main1>li:hover .main2 {
  left: 0;
}
#header .main1>li a {
  display: block;
  font-size: 22px;
}
#header .main1>li a:hover {
  font-weight: bold;
}
#header .main2 {
  width:100%;
  position: absolute;
  top: 50px;
  left: -9999px;
  width: 100%;
  padding: 0px;
}
#header .main1>li:hover {
  border-bottom: 5px solid #371e06;
}
#header .main2 li:hover {
  border-left: 5px solid #371e06;
}

#header .main2>li {
  position: relative;
}

#header .main2>li a {
  border-radius: 10px;
  margin: 10px;
}

.footer html, body {
   height: 100%;
   padding: 0px;
   margin: 0px;
 
 }

/* .footer header { */
/*    height: 60px; */
/*    background-color: #371e06; */
/* } */

 #wrap {
  min-height: calc(100% - 120px);
}


 .footer {
   height: 300px;
   background-color: #371e06;
   text-align: center;
   padding-top: 70px;
   color: white;
   position: absolute; 
   width:100%;
 }
 



</style>
</head>
<c:import url="../../chat/chatbutton.jsp"></c:import>
<body>

<div id="header">
<header>

<div class="logo"><img src='/resources/image/주황로고.png'></div>
<c:if test="${role eq 'admin'}">
	<a href="<%=request.getContextPath()%>/admin/main">관리자페이지</a>
</c:if>

<c:if test="${not empty login}">
	<a href="<%=request.getContextPath()%>/login/logout">로그아웃</a>
	<a href="<%=request.getContextPath()%>/mypage/main">마이페이지</a>
	<a href="#">알람</a>
</c:if>
<c:if test="${empty socialNum and empty login}">
	<a href="<%=request.getContextPath()%>/login/login">로그인</a>
</c:if>	
<c:if test="${not empty socialNum}">
	<a href="<%=request.getContextPath()%>/login/logout">로그아웃</a>
	<a href="<%=request.getContextPath()%>/mypage/main">마이페이지</a>
	<a href="#">알람</a>
</c:if>

<c:if test="${platFormOption eq 'naver'}">
	<a href="/login/logout">로그아웃</a>
	<a href="/mypage/main">마이페이지</a>
	<a href="#">알람</a>
</c:if>

</header>

<div id="menu">
  <ul class="main1">
    <li style="border: none;"><a href="<%=request.getContextPath()%>/login/main">JAMANCHU</a></li>
    <li><a href="<%=request.getContextPath()%>/company/info">회사소개</a></li>
    <li style="border: none; cursor:pointer;"><a>모임</a>
       <ul class="main2">
        <li><a href="<%=request.getContextPath()%>/meeting/form">모임 등록</a></li>
        <li><a href="<%=request.getContextPath()%>/meeting/meetingcal">모임 신청</a></li>
      </ul>
    </li>
    <li><a href="<%=request.getContextPath()%>/board/allFile">커뮤니티</a></li>
    <li><a href="<%=request.getContextPath()%>/store/main">스토어</a></li>
    <li><a href="<%=request.getContextPath()%>/cs/notice/list">고객센터</a></li>
    </ul>
</div>
</div>