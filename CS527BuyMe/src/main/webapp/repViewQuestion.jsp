<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Viewing Question</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover; text-decoration: none; color: white">
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String rep_id = (String) session.getAttribute("employeeid");
		if (null == rep_id) {
			response.sendRedirect("login.jsp");
		}
		String q_id = request.getParameter("q_id");
		
		String ask_query = "SELECT asker FROM asks WHERE q_id=(?)";
		PreparedStatement ps = con.prepareStatement(ask_query);
		ps.setString(1, q_id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		String asker = rs.getString(1);
		
		String q_text_query = "SELECT q_text FROM question WHERE q_id=(?)";
		ps = con.prepareStatement(q_text_query);
		ps.setString(1, q_id);
		rs = ps.executeQuery();
		rs.next();
		String q_text = rs.getString(1);
	%>
	<a style="text-decoration: underline; color: white" href="custRepHome.jsp">Back to Home</a>
	<div style="text-align: center">
	<h2><%= asker %> asks:</h2>
	<%= q_text %>
	<hr>
	<%
		ps = con.prepareStatement(
				"SELECT resolver, resolve_text FROM resolves WHERE q_id=(?)"
		);
		ps.setString(1, q_id);
		String resolver_id = null;
		String resolve_text = null;
		rs = ps.executeQuery();
		if (rs.next()) {
			resolver_id = rs.getString(1);
			resolve_text = rs.getString(2);
		}
		if (null == resolver_id) {
	%>
	<h4>Provide issue resolution:</h4>
	<form action="repResolveQuestion.jsp">
		<textarea style="width:500px; height:250px" name="resolve_text"></textarea>
		<br>
		<button type="submit">Resolve!</button>
		<input type="hidden" name ="rep_id" value = "<%= rep_id %>" />
		<input type="hidden" name ="q_id" value = "<%= q_id %>" />
	</form>
	<% } else { %>
	<h4>Resolved by Customer Rep Id #<%= resolver_id %>:</h4>
	<%= resolve_text %>
	<% } %>
	</div>
</body>
</html>