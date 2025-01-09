<%@page import="java.text.DecimalFormat"%>
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
request.setCharacterEncoding("UTF-8");
String store_nm = request.getParameter("store_nm");

DecimalFormat fo = new DecimalFormat("###,###");

Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

String sql = "select st.store_nm, "
			+ "sa.sale_fg, sa.sale_no, sa.sale_ymd, go.goods_nm, sa.sale_cnt, "
			+ "SUM(sa.sale_cnt * go.goods_price), "
			+ "sa.pay_type "
			+ "from sale_tbl_004 sa, store_tbl_004 st, tbl_goods_02 go "
			+ "where go.goods_cd = sa.goods_cd and sa.store_cd = st.store_cd "
			+ "group by st.store_nm, sa.sale_fg, sa.sale_no, sa.sale_ymd, go.goods_nm, sa.sale_cnt, sa.pay_type "
			+ "order by sa.sale_no";


ResultSet rs = conn.prepareStatement(sql).executeQuery();

%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<br>
<section style="display: flex; justify-content: center;">
<table border="1" style="border-spacing: 0px;">
<tr>
<th style="padding: 0 10px;">판매구분</th>
<th style="padding: 0 10px;">판매번호</th>
<th style="padding: 0 18px;">판매일자</th>
<th style="padding: 0 10px;">상품명</th>
<th style="padding: 0 10px;">판매수량</th>
<th style="padding: 0 10px;">판매금액</th>
<th style="padding: 0 10px;">수취구분</th>
</tr>
<%
while(rs.next()) {
	if(store_nm.equals(rs.getString(1))) {
		
		int i = rs.getInt(7);
		String str = fo.format(i);
%>
<tr>
<td><%= rs.getString(2).equalsIgnoreCase("1") ? "판매" : (rs.getString(2).equalsIgnoreCase("2") ? "판매 취소" :  "") %></td>
<td><%= rs.getString(3) %></td>
<td><%= rs.getString(4).substring(0, 10) %></td>
<td><%= rs.getString(5) %></td>
<td><%= rs.getString(6) %></td>
<td><%= str %>원</td>
<td><%= rs.getString(8).equalsIgnoreCase("01") ? "현금" : (rs.getString(8).equalsIgnoreCase("02") ? "카드" :  "") %></td>
</tr>
<%
}
}
%>
</table>
</section>
</body>
</html>