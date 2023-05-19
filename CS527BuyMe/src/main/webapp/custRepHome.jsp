<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep Dashboard</title>
<style>
table, th, td {
  	border-collapse: collapse;
  	
}
</style>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; color: white; background-size: cover">
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String rep_id = (String) session.getAttribute("employeeid");
		if (null == rep_id) {
			response.sendRedirect("login.jsp");
		}
	%>
	<div style="text-align: center">		
		<h1>Logged in : Customer Rep.</h1>
		<a style="text-decoration: underline; color: white" href="logout.jsp">Logout</a>
		
		<h3>Questions</h3>
		<%
			Statement stmt = con.createStatement();
			ResultSet resultset = stmt.executeQuery("SELECT q_id, q_text FROM question");
		%>
		<form action="repViewQuestion.jsp">
		<table style="margin-left: auto;  margin-right: auto;">
		<%
			if (!resultset.next()) {
		%>
		<tr>
			<td colspan="2">No one has asked a question yet!</td>
		</tr>
		<%
			} else {
				resultset.beforeFirst();
			 	while (resultset.next()) { 
		%>
			<tr>
				<td><button name="q_id" type="submit" value="<%= resultset.getString(1) %>">Details</button></td>
				<td style="max-width: 300px;: 18px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%= resultset.getString(2) %></td>
			</tr>
		<% 	
				}
			}
		%>
		</table>
		</form>
	<br>
	<hr>
	<br>
	<h3>Bids and Auctions</h3>
		<%
			resultset = stmt.executeQuery("SELECT l_id, itemname, subcategory, price FROM listings");
		%>
		<form action="repViewListing.jsp">
		<table style="margin-left: auto;  margin-right: auto;">
		<tr>
			<th></th>
			<th>Item</th>
			<th>Subcategory</th>
			<th>Price</th>
		</tr>
		<%
			if (!resultset.next()) {
		%>
		<tr>
			<td colspan="4">No one has posted a listing yet!</td>
		</tr>
		<%
			} else {
				resultset.beforeFirst();
			 	while (resultset.next()) { 
		%>
			<tr>
				<td><button name="lid" type="submit" value="<%= resultset.getString(1) %>">Details</button></td>
				<td style="max-width: 300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%= resultset.getString(2) %></td>
				<td style="max-width: 300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%= resultset.getString(3) %></td>
				<td style="max-width: 300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%= resultset.getString(4) %></td>
			</tr>
		<% 	
				}
			}
		%>
		</table>
		</form>
	<br>
	<hr>
	<br>
	<h3>Users</h3>
		<%
			resultset = stmt.executeQuery("SELECT username FROM users");
		%>
		<form action="repViewUser.jsp">
		<table style="margin-left: auto;  margin-right: auto;">
		<tr>
			<th></th>
			<th>Username</th>
		</tr>
		<%
			if (!resultset.next()) {
		%>
		<tr>
			<td colspan="4">No one has registered yet!</td>
		</tr>
		<%
			} else {
				resultset.beforeFirst();
			 	while (resultset.next()) { 
		%>
			<tr>
				<td><button name="username" type="submit" value="<%= resultset.getString(1) %>">Details</button></td>
				<td style="max-width: 300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%= resultset.getString(1) %></td>
			</tr>
		<% 	
				}
			}
		%>
		</table>
		</form>
	<br>
	<hr>
	</div>
</body>
</html>