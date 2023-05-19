<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
</head>
<body style="size:1040px;height:960px;background:url('background.jpeg') no-repeat; background-size: cover">
	<h2 style="text-align: center; color: white"> BuyMe <br> User Registration</h2>
	<form method="post" action="createAccount.jsp">
		<div style="text-align: center; color: white">	
			Username: <input type="text" name="username" value="" required/>
			
			Password: <input type="password" name="password" value=""  required/>
			
			<input type="submit" value="Create Account"/>
		</div>
		<p style="text-align: center; color: white">Have an account? <a style="text-decoration: underline; color: white" href="login.jsp">Sign in</a></p>
		<% if (null != request.getParameter("msg")) { %>
			<p style="text-align: center; color: red"><%=request.getParameter("msg")%></p>
		<% } %>
	</form>
</body>
</html>