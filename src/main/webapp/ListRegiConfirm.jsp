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

	
	String sql = "insert into tbl_goods_02 values(?, ?, ?, ?, ?)";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);  
	
	pstmt.setString(1, request.getParameter("goods_cd"));
	pstmt.setString(2, request.getParameter("goods_nm"));
	pstmt.setString(3, request.getParameter("goods_price"));
	pstmt.setString(4, request.getParameter("cost"));
	pstmt.setString(5, request.getParameter("in_date"));
	
	pstmt.executeUpdate();

	response.sendRedirect("List.jsp");
%>

</body>
</html>