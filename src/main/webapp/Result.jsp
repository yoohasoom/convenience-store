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
.Alltd {
text-align: right;
}
</style>
</head>
<body>
<%
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
DecimalFormat fo = new DecimalFormat("###,###");

String sql1 = "select st.store_nm as 점포명, "
			+ "sum(case when sa.pay_type = '01' then sa.sale_cnt * go.goods_price ELSE 0 END) as 현금매출, "
			+ "sum(case when sa.pay_type = '02' then sa.sale_cnt * go.goods_price ELSE 0 END) as 카드매출, "
			+ "sum(sa.sale_cnt * go.goods_price) as 총매출 "
			+ "from sale_tbl_004 sa, store_tbl_004 st, tbl_goods_02 go "
			+ "where go.goods_cd = sa.goods_cd and sa.store_cd = st.store_cd "
			+ "group by st.store_nm "
			+ "order by SUM(sa.sale_cnt * go.goods_price) desc";

Statement stmt = conn.createStatement();
%>
<jsp:include page="Header.jsp"></jsp:include>
<br>
<h2 style="text-align: center;">점포별매출현황</h2>
<br>
<section style="display: flex; justify-content: center;">	
		<table border="1" style="border-spacing: 0px;">
			<tr>
				<th style="padding: 0 10px;">점포명</th>
				<th style="padding: 0 10px;">현금매출</th>
				<th style="padding: 0 10px;">카드매출</th>
				<th style="padding: 0 10px;">총매출</th>
			</tr>
			<%
			ResultSet rs = stmt.executeQuery(sql1);
			
			while (rs.next()) {
				
				int i = rs.getInt(2);
				String str1 = fo.format(i);
				
				int n = rs.getInt(3);
				String str2 = fo.format(n);
				
				int t = rs.getInt(4);
				String str3 = fo.format(t);
			%>
			<tr>
				<td style="text-align: center;"><a href="ResultConfirm.jsp?store_nm=<%=rs.getString(1)%>" style="color: black; font-size: 18px; text-decoration: none;"><%=rs.getString(1)%></a></td>
				<td class="Alltd"><%=str1%>원</td>
				<td class="Alltd"><%=str2%>원</td>
				<td class="Alltd"><%=str3%>원</td>
			</tr>
			<%
			}
			%>
		</table>
</section>

</body>
</html>