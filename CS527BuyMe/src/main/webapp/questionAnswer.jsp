<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions and Answers!</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover; text-decoration: none; color: white">
	<a style="text-decoration: underline; color: white" href="home.jsp">Home</a>
	<div style="text-align: center">
	<h1>Questions submitted by all users</h1>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
	%>
	<form method="post" action="questionAnswer.jsp">
    	<input type="text" name="search" class="form-control" placeholder="Enter keyword">
    	<button type="submit" name="save" class="btn btn-primary">Search</button>
  	</form>
  	
  	<%
  		String keyword = request.getParameter("search");
  		ResultSet resultset;
  		
  		if (null == keyword || keyword.isBlank()) {
  			resultset = stmt.executeQuery("SELECT q_id, q_text FROM question");
  		} else {
  			PreparedStatement ps = con.prepareStatement(
  				"SELECT q_id, q_text FROM question WHERE q_text LIKE '%" + keyword + "%'"
  			);
  			resultset = ps.executeQuery();
  		}
  	%>
  	<hr>
  	<%
  		if (null != keyword && !keyword.isBlank()) {
  	%>
  	<h3>Search results for: <%= keyword %></h3>
  	<%
  		}
  	%>
	<form action="viewQuestion.jsp">

		 <% while (resultset.next()) { %>

				<button name="q_id" type="submit" value="<%= resultset.getString(1) %>">Details</button><br>
				<%= resultset.getString(2) %><br><hr>

		<% } %>

		</form>
	</div>
</body>
</html>