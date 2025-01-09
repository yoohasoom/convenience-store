<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String goods_cd = request.getParameter("goods_cd");
String goods_nm = request.getParameter("goods_nm");
String goods_price = request.getParameter("goods_price");
String cost = request.getParameter("cost");
String in_date = request.getParameter("in_date");
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">상품정보변경</h2>
<br>
<section style="display: flex; justify-content: center;">

		<form action="ListEditConfirm.jsp" name="form">
			<table border="1" style="border-spacing: 0px;">
				<tr>
					<th>상품코드(변경불가)</th>
					<td><input type="text" readonly name="goods_cd" value="<%=goods_cd%>"></td>
				</tr>
				
				<tr>
					<th>상품명</th>
					<td><input type="text" name="goods_nm" value="<%=goods_nm%>"></td>
				</tr>
				
				<tr>
					<th>단가</th>
					<td><input type="text" name="goods_price" value="<%=goods_price%>"></td>
				</tr>
				
				<tr>
					<th>원가</th>
					<td><input type="text" name="cost" value="<%=cost%>"></td>
				</tr>
				
				<tr>
					<th>입고날짜(변경불가)</th>
					<td><input type="text" readonly name="in_date" value="<%=in_date.substring(0, 10)%>"></td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align: center;">
					<input type="submit" value="저장" onclick="fn_submit(); return false;">
					<input type="button" value="상품목록" onclick="fn_but();">
					</td>
				</tr>
			</table>
		</form>
</section>
<script type="text/javascript">
function fn_submit() {
	var f = document.form;
	
	if(f.goods_nm.value == "") {
		alert("상품명을 입력해주세요!");
		f.goods_nm.focus(); return false;
	}
	if(f.goods_price.value == "") {
		alert("단가를 입력해주세요!");
		f.goods_price.focus(); return false;
	}
	if(f.cost.value == "") {
		alert("원가를 입력해주세요!");
		f.cost.focus(); return false;
	}
	f.submit();
}
function fn_but() {
	location = "List.jsp";
}
</script>
</body>
</html>