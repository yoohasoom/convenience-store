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
	int result = 0;
	
	String sql = "insert into sale_tbl_004 values(?, ?, ?, ?, ?, ?, ?)";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);  
	
	pstmt.setString(1, request.getParameter("sale_no"));
	pstmt.setString(2, request.getParameter("sale_ymd"));
	pstmt.setString(3, request.getParameter("sale_fg"));
	pstmt.setString(4, request.getParameter("store_cd"));
	pstmt.setString(5, request.getParameter("goods_cd"));
	pstmt.setString(6, request.getParameter("sale_cnt"));
	pstmt.setString(7, request.getParameter("pay_type"));
	
	result = pstmt.executeUpdate();

	if(result == 1) {
%>
<script type="text/javascript">
alert("매출이 정상적으로 등록되었습니다");
location = "Index.jsp";
</script>
<%
	}
%>
</body>
</html>