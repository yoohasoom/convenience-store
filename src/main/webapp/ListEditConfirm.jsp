<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<meta charset="UTF-8">
<% 
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
	int result = 0;
	
	String sql = "update tbl_goods_02 set goods_nm = ?, goods_price = ?, cost = ?, in_date = ? where goods_cd = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);  
	
	pstmt.setString(1, request.getParameter("goods_nm"));
	pstmt.setString(2, request.getParameter("goods_price"));
	pstmt.setString(3, request.getParameter("cost"));
	pstmt.setString(4, request.getParameter("in_date"));
	pstmt.setString(5, request.getParameter("goods_cd"));

	result = pstmt.executeUpdate();

	response.sendRedirect("List.jsp");
%>