<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
	<style>
	.center {
	    margin-left: auto;
	    margin-right: auto;
	}
	
	table, th, td {
			/* 
	      border: 1px solid ; */
	      border-collapse: collapse;
	      padding: 0px;
	}
	
	</style>
	<meta charset="utf-8">
	<title>Your Interests</title>
</head>
<body  style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover; text-decoration: none; color: white">
	<% 
    	//Database Connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		if (null == username) {
			response.sendRedirect("login.jsp");
		}
		PreparedStatement ps = con.prepareStatement(
				"SELECT interest " +
				"FROM interests " +
				"WHERE username=(?)");
		ps.setString(1, username);
		ResultSet rs = ps.executeQuery();
			
    %>
    <div style="text-align: center">
    	<h1>Interests</h1>
    	
    	<a style="text-decoration: underline; color: white" href= "account.jsp">Back</a>
    	<br>
    	<br>
    	<hr>
		<br>
    	<form method="post" action="addInterest.jsp">
    		<input type="text" name="interest">
    		<input type="submit" value="Add Interest">
    	</form>
    	<br>
    	<table class="center">
    		<tr>
	    		<th>
	    			Interests you selected
	    		</th>
    		</tr>
    		<% while (rs.next()) { %>
    			<tr> 
    				<td> - <%=rs.getString(1)%></td>
    			</tr>
    		<% } %>
    	</table>
    </div>
</body>
</html>