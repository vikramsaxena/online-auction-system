<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; color: white; background-size: cover">
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String admin_id = (String) session.getAttribute("employeeid");
		if (null == admin_id) {
			response.sendRedirect("login.jsp");
		}
		ResultSet resultset = stmt.executeQuery("SELECT id, password FROM customer_rep");
	%>
	<div style="text-align: center; color: white">		
		<h1>Admin Dashboard</h1>
		<a style="text-decoration: underline; color: white" href="logout.jsp">Logout</a>
		<h3>Customer Rep Creation Form</h3>
		<form method="post" action="createCustRepAccount.jsp">
			Customer Rep ID: <input type="text" name="id" value="" required/>
			
			Customer Rep Password: <input type="text" name="password" value="" required/>
			
			<input type="submit" value="Create Rep"/>
			
			<% if (null != request.getParameter("CreateRet")) { %>
			<p style="text-align: center; 
					color: <%= request.getParameter("CreateRetCode").equals("0") ? "blue" : "red" %>">
						<%=request.getParameter("CreateRet")%>
			</p>
			<% } %>
		</form>
	</div>
	<br>
	<br>
	<hr>
	<br>
	<form action="generateSalesReport.jsp">
		<div style="text-align: center; color: white">		
			<h3> Sales Report</h3>
	
			From (Start Date)
			<input type="datetime-local" required name="date1">
			&nbsp;
			To (End Date)
			<input type="datetime-local" required name="date2">
			
			<input type="submit" value="Generate Report">
		</div>
	</form>
</body>
</html>