<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.app.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Account Options</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover">

	<% 
    	//Database Connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		if (null == username) {
			response.sendRedirect("login.jsp");
		}
			
    %>

    <div style="text-align: center; color: white">
    	<h1>Hi <%=username%> !</h1>
    	<h3>Welcome to your account</h3>
				<hr>
				<br><a style="text-decoration: underline; color: white" href="home.jsp">Home</a><br><br>
				<a style="text-decoration: underline; color: white" href="logout.jsp">Logout</a><br><br>
				<a style="text-decoration: underline; color: white" href="logout.jsp">Delete Account</a><br><br>
				<a style="text-decoration: underline; color: white" href="activity.jsp">Account Info</a>
				
    			<br>
   				<br>
    			<hr>
    			<b>
	   				<% if (null != request.getParameter("msg")) { %>
	
						<p style="text-align: center; color: red"><%=request.getParameter("msg")%></p>
	
					<% } %>
					
					<% if (null != request.getParameter("askQuestionRet")) { %>
		
						<p style="text-align: center; color: green"><%=request.getParameter("askQuestionRet")%></p>
		
					<% } %>
			
					<% if (null != request.getParameter("createListingRet")) { %>
		
						<p style="text-align: center; color: blue"><%=request.getParameter("createListingRet")%></p>
		
					<% } %>
   				</b>
   				<br>
				
   				<a style="text-decoration: underline; color: white" href="postQuestion.jsp">Ask a Question</a><br><br>
				<a style="text-decoration: underline; color: white" href="postListing.jsp">Add an Auction Listing</a><br><br>
   				<a style="text-decoration: underline; color: white" href="interest.jsp">Interests</a><br><br>
   				
    	
    </div>
</body>
</html>