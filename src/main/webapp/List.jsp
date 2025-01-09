<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td {
text-align: center;
}
</style>
</head>
<body>
<%
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

String sql = "select goods_cd, goods_nm, goods_price, cost, in_date from tbl_goods_02 order by goods_cd";

ResultSet rs = conn.prepareStatement(sql).executeQuery();
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">상품관리</h2>
<br>
<section style="display: flex; justify-content: center;">
			<table border="1" style="border-spacing: 0px;">
				<tr>
					<th style="padding: 0 10px;">상품코드</th>
					<th style="padding: 0 15px;">상품명</th>
					<th style="padding: 0 40px;">단가</th>
					<th style="padding: 0 55px;">평가</th>
					<th style="padding: 0 20px;">입고일자</th>
				</tr>
				
				<%
				while(rs.next()) {
					
				%>
				<tr>
					<td><a href="ListEdit.jsp?goods_cd=<%=rs.getString(1)%>&goods_nm=<%=rs.getString(2)%>&goods_price=<%=rs.getString(3)%>&cost=<%=rs.getString(4)%>&in_date=<%=rs.getString(5)%>&" style="color: black; font-size: 18px; text-decoration: none;"><%=rs.getString(1) %></a></td>
					<td><%= rs.getString(2) %></td>
					<td style="text-align: right; padding-right: 5px">\<%= rs.getString(3) %></td>
					<td style="text-align: right; padding-right: 5px">\<%= rs.getString(4) %></td>
					<td><%= rs.getString(5).substring(0, 10) %></td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="5" style="text-align: center;"><input type="button" value="등록" onclick="fn_but();"></td>
				</tr>
			</table>
</section>
<script type="text/javascript">
function fn_but() {
	location = "ListRegi.jsp";
}
</script>
</body>
</html>