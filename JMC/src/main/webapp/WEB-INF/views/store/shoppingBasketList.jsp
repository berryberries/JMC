<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

	
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<div>
<form method="post" action="./shoppingbasket">
<input type="hidden" value="256" name="userno">

<button>장바구니 보기</button>
</form>

<form method="post" action="/payment/main">
<table class="table table table-hover">
<tr class="table-secondary">
	<th>상품이름</th>
	<th>갯수</th>
	<th>가격</th>
	<th>관리</th>
</tr>	
<c:forEach var="list" items="${list }">
<input type="hidden" value="${list.BASKETNO }" id="bkno" name="basketno">
<tr>
	<th>${list.ITEM_TITLE }</th>
	<th><input type="text" value="${list.SB_ITEM_COUNT }" name="sbItemcount">${list.SB_ITEM_COUNT }</th>
	<th>${list.ITEM_PRICE * list.SB_ITEM_COUNT }</th>
	<th><button type="button" class="btn btn-secondary" value="${list.BASKETNO }" id="bkupdate">수정</button>
	<button type="button" class="btn btn-secondary" id ="deletebtn" onClick="window.location.reload()">삭제</button></th>
</tr>
</c:forEach> 
</table>

<button id="commentbtn">결제하기</button>
<!-- <button value="bkno" name="bknolist" id="bknolist">결제하기</button> -->
</form>
</div>