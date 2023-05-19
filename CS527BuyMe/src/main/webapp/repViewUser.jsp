<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Examining User</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover; text-decoration: none; color: white">
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String user = request.getParameter("username");
		PreparedStatement ps = con.prepareStatement(
			"SELECT password FROM users WHERE username=(?)"
		);
		ps.setString(1, user);
		ResultSet rs = ps.executeQuery();
		rs.next();
	%>
	<p><a style="text-decoration: underline; color: white" href="custRepHome.jsp">Back</a></p>
	<div style="text-align: center">
	<h1>Examining: <%= user %></h1>
	<form action="repModifyUser.jsp">
		<p>Current Username: <%= user %></p>
		<br>
		<p>New Username: <input type="text" name="new_user" value="" maxlength="30">
		&nbsp;New Password: <input type="text" name="new_pass" value="" maxlength="30"></p>
		<br>
		<button type="submit">Confirm</button>
		<hr>
		<button name="delete" type="submit" value="true">Delete User</button>
		<input type="hidden" name="old_user" value="<%= user %>"/>
	</form>
		
	</div>
</body>
</html>