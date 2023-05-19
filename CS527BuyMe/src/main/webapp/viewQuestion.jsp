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
	<div style="text-align: center">
	<a style="text-decoration: underline; color: white" href="questionAnswer.jsp">Back to Q&A</a>
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
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
	<h2>Question asked by <%= asker %>:</h2>
	<%= q_text %>
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
	<h4>No resolution yet!</h4>
	<% } else { %>
	<h4>Question has been resolved by Customer Representative#<%= resolver_id %>:</h4>
	<%= resolve_text %>
	<% } %>
	</div>
</body>
</html>