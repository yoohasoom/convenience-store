<%@page import="java.sql.*"%>
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
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

String sql = "select max(goods_cd)+1, sysdate from tbl_goods_02";

ResultSet rs = conn.prepareStatement(sql).executeQuery();

rs.next();
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">상품정보등록</h2>
<br>
<section style="display: flex; justify-content: center;">
		<form action="ListRegiConfirm.jsp" name="form">
			<table border="1" style="border-spacing: 0px;">
				<tr>
					<th>상품코드(자동채번)</th>
					<td><input type="text" readonly name="goods_cd" value="<%=rs.getString(1)%>"></td>
				</tr>
				
				<tr>
					<th>상품명</th>
					<td><input type="text" name="goods_nm"></td>
				</tr>
				
				<tr>
					<th>단가</th>
					<td><input type="text" name="goods_price"></td>
				</tr>
				
				<tr>
					<th>원가</th>
					<td><input type="text" name="cost"></td>
				</tr>
				
				<tr>
					<th>입고날짜(자동세팅)</th>
					<td><input type="text" readonly name="in_date" value="<%=rs.getString(2).substring(0, 10)%>"></td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align: center;">
					<input type="submit" value="등록" onclick="fn_submit(); return false;">
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
		alert("상품명이 입력되지 않았습니다!");
		f.goods_nm.focus(); return false;
	}
	if(f.goods_price.value == "") {
		alert("단가가 입력되지 않았습니다!");
		f.goods_price.focus(); return false;
	}
	if(f.cost.value == "") {
		alert("원가가 입력되지 않았습니다!");
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